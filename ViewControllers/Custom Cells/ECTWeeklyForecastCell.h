//
//  ECTWeeklyForecastCell.h
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/25/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ECTWeather;

@interface ECTWeeklyForecastCell : UITableViewCell

@property (nonatomic, strong) UIImageView *rainDropIconIV;

@property (nonatomic, strong) UILabel *temperatureLbl;
@property (nonatomic, strong) UILabel *descLbl;
@property (nonatomic, strong) UILabel *chanceOfRainLbl;
@property (nonatomic, strong) UILabel *dateNumbLbl;
@property (nonatomic, strong) UILabel *dateDayLbl;

@end
