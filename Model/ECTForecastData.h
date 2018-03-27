//
//  ECTForecastData.h
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/25/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface ECTForecastData : JSONModel <NSCoding>

@property (nonatomic) NSNumber *time;
@property (nonatomic) NSString *summary;
@property (nonatomic) NSString *icon;
@property (nonatomic) NSNumber *precipIntensity;
@property (nonatomic) NSNumber *precipProbability;
@property (nonatomic) NSNumber <Optional> *temperature;
@property (nonatomic) NSNumber <Optional> *apparentTemperature;
@property (nonatomic) NSNumber *dewPoint;
@property (nonatomic) NSNumber *humidity;
@property (nonatomic) NSNumber *pressure;
@property (nonatomic) NSNumber *windSpeed;
@property (nonatomic) NSNumber *windGust;
@property (nonatomic) NSNumber *windBearing;
@property (nonatomic) NSNumber *cloudCover;
@property (nonatomic) NSNumber *uvIndex;
@property (nonatomic) NSNumber <Optional> *visibility;
@property (nonatomic) NSNumber *ozone;

/* Optional properties below. Only applicable to daily forecast data */
/* Using JSONModel library, we decorate these with '<Optional>'. Meaning, they can be null or empty (ignored) when parsing the Json data. */

@property (nonatomic) NSNumber <Optional> *sunriseTime;
@property (nonatomic) NSNumber <Optional> *sunsetTime;
@property (nonatomic) NSNumber <Optional> *moonPhase;

@property (nonatomic) NSNumber <Optional> *precipIntensityMax;
@property (nonatomic) NSNumber <Optional> *precipIntensityMaxTime;

@property (nonatomic) NSString <Optional> *precipType;

@property (nonatomic) NSNumber <Optional> *temperatureHigh;
@property (nonatomic) NSNumber <Optional> *temperatureHighTime;
@property (nonatomic) NSNumber <Optional> *temperatureLow;
@property (nonatomic) NSNumber <Optional> *temperatureLowTime;
@property (nonatomic) NSNumber <Optional> *apparentTemperatureHigh;
@property (nonatomic) NSNumber <Optional> *apparentTemperatureHighTime;
@property (nonatomic) NSNumber <Optional> *apparentTemperatureLow;
@property (nonatomic) NSNumber <Optional> *apparentTemperatureLowTime;

@property (nonatomic) NSNumber <Optional> *windGustTime;
@property (nonatomic) NSNumber <Optional> *uvIndexTime;

@property (nonatomic) NSNumber <Optional> *temperatureMin;
@property (nonatomic) NSNumber <Optional> *temperatureMinTime;
@property (nonatomic) NSNumber <Optional> *temperatureMax;
@property (nonatomic) NSNumber <Optional> *temperatureMaxTime;
@property (nonatomic) NSNumber <Optional> *apparentTemperatureMin;
@property (nonatomic) NSNumber <Optional> *apparentTemperatureMinTime;
@property (nonatomic) NSNumber <Optional> *apparentTemperatureMax;
@property (nonatomic) NSNumber <Optional> *apparentTemperatureMaxTime;

@end
