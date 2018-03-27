//
//  ECTHTTPClientManager.h
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/25/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HTTPClientCompletionBlock) (BOOL success, id rawResponseObject, NSError *error);

@interface ECTHTTPClientManager : NSObject

-(void)getRequestAtURL:(NSString *) targetUrl
          InBackground:(BOOL) inBackground
        withCompletion:(HTTPClientCompletionBlock) httpRequestCompletion;

+(ECTHTTPClientManager *)sharedClient;

@end
