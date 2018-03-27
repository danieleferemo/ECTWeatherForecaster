//
//  ECTReachabilityManager.m
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/25/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import "ECTReachabilityManager.h"

#import "Reachability.h"

@interface ECTReachabilityManager ()

@property (strong, nonatomic) Reachability *reachability;

@end

@implementation ECTReachabilityManager

+ (BOOL)isReachable
{
    return [[[ECTReachabilityManager sharedClient] reachability] isReachable];
}

#pragma mark Thread safe init

+ (ECTReachabilityManager *)sharedClient
{
    static ECTReachabilityManager *sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      sharedClient = [[self alloc] init];
                  });
    
    return sharedClient;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.reachability = [Reachability reachabilityForInternetConnection];
        
        // Start Monitoring
        [self.reachability startNotifier];
    }
    
    return self;
}

@end
