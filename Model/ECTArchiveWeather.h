//
//  ECTArchiveWeather.h
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/27/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ECTWeather;

@interface ECTArchiveWeather : NSObject <NSCoding>

@property (nonatomic) ECTWeather *weather;
@property (nonatomic) NSDate *archivedDate;

+(id)sharedClient;

@end
