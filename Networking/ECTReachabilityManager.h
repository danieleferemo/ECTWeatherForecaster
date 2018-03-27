//
//  ECTReachabilityManager.h
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/25/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECTReachabilityManager : NSObject

+ (BOOL)isReachable;

//...this method should only be called in the app delegate class. Other classes should use the class methods above. D.E
+ (ECTReachabilityManager *)sharedClient;

@end
