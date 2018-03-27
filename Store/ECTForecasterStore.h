//
//  ECTForecasterStore.h
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/25/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ECTWeather;

typedef void (^ForecasterStoreCompletionBlock) (BOOL success, ECTWeather *weather, NSError *error);

@interface ECTForecasterStore : NSObject

-(void)getCurrentWeatherForecastInBackground:(BOOL) inBackground
                              WithCompletion:(ForecasterStoreCompletionBlock) forecastCompletion;

+(ECTForecasterStore *)sharedClient;

@end
