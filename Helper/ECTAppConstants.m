//
//  ECTAppConstants.m
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/25/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import "ECTAppConstants.h"

@implementation ECTAppConstants

NSString *const DarkSkyEventCloudApiProxy = @"http://ec-weather-proxy.appspot.com/forecast/29e4a4ce0ec0068b03fe203fa81d457f/-33.9249,18.4241?delay=5&chaos=0.2";

float kMinimumBackgroundFetchInterval = 1200; //20 mins

int kMinimumSafeTemperature = 15;

int kMaximumSafeTemperature = 25;

@end
