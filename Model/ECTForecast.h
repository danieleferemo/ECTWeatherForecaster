//
//  ECTForecast.h
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/25/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"
@class ECTForecastData;

@protocol ECTForecastData;

@interface ECTForecast : JSONModel <NSCoding>

@property (nonatomic) NSString *summary;
@property (nonatomic) NSString *icon;
@property (nonatomic) NSArray <ECTForecastData *> <ECTForecastData> *data;

@end
