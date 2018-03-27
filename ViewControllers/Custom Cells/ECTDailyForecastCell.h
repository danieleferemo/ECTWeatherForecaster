//
//  ECTDailyForecastCell.h
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/27/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECTDailyForecastCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *temptLabel;

@end
