//
//  ECTWeather.h
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/25/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@class ECTForecast;
@class ECTForecastData;
@class ECTWeatherFlags;

@interface ECTWeather : JSONModel <NSCoding>

@property (nonatomic) NSNumber *latitude;
@property (nonatomic) NSNumber *longitude;
@property (nonatomic) NSString *timezone;

@property (nonatomic) ECTForecastData *currently;
@property (nonatomic) ECTForecast *hourly;
@property (nonatomic) ECTForecast *daily;

@property (nonatomic) NSNumber <Ignore> *offset;
@property (nonatomic) ECTWeatherFlags <Ignore> *flags;

@end
