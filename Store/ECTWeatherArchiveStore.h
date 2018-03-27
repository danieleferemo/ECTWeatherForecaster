//
//  ECTWeatherArchiveStore.h
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/27/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ECTArchiveWeather;

@interface ECTWeatherArchiveStore : NSObject

-(void)saveWeather:(ECTArchiveWeather *) weather;

-(ECTArchiveWeather *)unarchiveSavedWeather;

+(ECTWeatherArchiveStore *)sharedClient;

@end
