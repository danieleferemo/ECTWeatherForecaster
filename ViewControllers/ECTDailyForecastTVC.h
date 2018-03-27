//
//  ECTDailyForecastTVC.h
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/27/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ECTForecast;

@interface ECTDailyForecastTVC : UITableViewController

@property(nonatomic, strong) ECTForecast *hourlyForecast;

@end
