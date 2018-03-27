//
//  ECTHTTPClientManager.m
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/25/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import "ECTHTTPClientManager.h"

#import <objc/runtime.h>

static NSString *const GET = @"GET";
static NSString *const ContentTypeHeaderField = @"Content-Type";
static NSString *const ContentTypeHeaderFieldValue = @"application/json";
static NSString *kBackgroundSessionConfigurationId = @"weatherForecaster.nsurlsession.backgroundfetch";

const char kECTTaskAssociatedCompletionBlock;

@interface ECTHTTPClientManager ()  <NSURLSessionDownloadDelegate>
@end

@implementation ECTHTTPClientManager

/* ================================================ Using NSURLSession ================================================ */

-(void)getRequestAtURL:(NSString *) targetUrl
          InBackground:(BOOL) inBackground
        withCompletion:(HTTPClientCompletionBlock) httpRequestCompletion
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:GET];
    [request setURL:[NSURL URLWithString:targetUrl]];
    [request setValue:ContentTypeHeaderFieldValue
   forHTTPHeaderField:ContentTypeHeaderField];
    
    if(!inBackground)
    {
        [[[NSURLSession sharedSession] dataTaskWithRequest:request
                                         completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
          {
              if(httpRequestCompletion)
              {
                  if(error == nil)
                  {
                      dispatch_async(dispatch_get_main_queue(), ^()
                                     {
                                         NSError *error;
                                         NSMutableDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                                             options:kNilOptions
                                                                                                               error:&error];
                                         httpRequestCompletion(YES, jsonResponse, nil);
                                     });
                  }
                  else
                  {
                      dispatch_async(dispatch_get_main_queue(), ^()
                                     {
                                         httpRequestCompletion(NO, nil, error);
                                     });
                  }
              }
              
          }]
         resume];
        
    }
    else
    {
        NSURLSessionConfiguration *backgroundSessionConfiguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:kBackgroundSessionConfigurationId];
        NSURLSession *downloadSession = [NSURLSession sessionWithConfiguration:backgroundSessionConfiguration
                                                                      delegate:self
                                                                 delegateQueue:NSOperationQueue.mainQueue];
        
        // try downloadTask 10 times. If still nil, try in next cycle
        NSURLSessionDownloadTask *downloadTask;
        static int numRetries = 10;
        for (int i = 0; downloadTask == nil && i < numRetries; i++)
        {
            downloadTask = [downloadSession downloadTaskWithRequest:request];
        }
        
        //Attach the completion block to sessionTask
        objc_setAssociatedObject(downloadTask, &kECTTaskAssociatedCompletionBlock, httpRequestCompletion, OBJC_ASSOCIATION_COPY);
        
        [downloadTask resume];
    }
}

#pragma mark - NSURLSessionDownload Delegate Method

- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location
{
    //Get the attached completion block to sessionTask
    void(^httpRequestCompletion)(BOOL success, id rawResponseObject, NSError *error) = objc_getAssociatedObject(downloadTask, &kECTTaskAssociatedCompletionBlock);
    
    
    NSHTTPURLResponse *httpURLResponse = (NSHTTPURLResponse *)downloadTask.response;
    if ([httpURLResponse statusCode] == 200)
    {
        NSData *incomingData = [NSData dataWithContentsOfURL:location];
        NSError *error;
        NSMutableDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:incomingData
                                                                            options:NSJSONReadingAllowFragments
                                                                              error:&error];
        httpRequestCompletion(YES, jsonResponse, nil);
    }
    else
    {
        httpRequestCompletion(NO, nil, downloadTask.error);
    }
}
 
#pragma mark - thread safe initialization

+(ECTHTTPClientManager *)sharedClient
{
    static ECTHTTPClientManager *sharedClient = nil;
    static dispatch_once_t  onceToken;
    
    dispatch_once(&onceToken, ^
                  {
                      sharedClient = [[self alloc] initPrivate];
                  });
    
    return sharedClient;
}

-(id)initPrivate
{
    if(self = [super init])
    {
        
    }
    
    return self;
}

-(id)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"init Not allowed here, use sharedClient"
                                 userInfo:nil];
    
    return nil;
}


@end
