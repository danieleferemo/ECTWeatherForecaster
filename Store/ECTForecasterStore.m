//
//  ECTForecasterStore.m
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/25/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import "ECTForecasterStore.h"

#import "ECTHTTPClientManager.h"
#import "ECTAppConstants.h"
#import "ECTWeather.h"

@interface ECTForecasterStore ()

@property (nonatomic, strong) ECTHTTPClientManager *httpClientManager;

@end

@implementation ECTForecasterStore

-(void)getCurrentWeatherForecastInBackground:(BOOL) inBackground
                              WithCompletion:(ForecasterStoreCompletionBlock) forecastCompletion
{
    [_httpClientManager getRequestAtURL:DarkSkyEventCloudApiProxy
                           InBackground:inBackground
                         withCompletion:^(BOOL success, id rawResponseObject, NSError *error)
     {
         if(success)
         {
             ECTWeather *weather = [[ECTWeather alloc] initWithDictionary:rawResponseObject
                                                                    error:&error];
             forecastCompletion((weather), weather, error);
         }
         else
         {
             forecastCompletion(success, nil, error);
         }
     }];
}

#pragma mark - thread safe initialization

+(ECTForecasterStore *)sharedClient
{
    static ECTForecasterStore *sharedClient = nil;
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
        self.httpClientManager = [ECTHTTPClientManager sharedClient];
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
