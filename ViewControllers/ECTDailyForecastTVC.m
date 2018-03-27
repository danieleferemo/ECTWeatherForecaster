//
//  ECTDailyForecastTVC.m
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/27/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import "ECTDailyForecastTVC.h"

#import "ECTDailyForecastCell.h"

#import "ECTForecast.h"
#import "ECTForecastData.h"

#import "ECTUtilityMethods.h"

@interface ECTDailyForecastTVC ()

@property (nonatomic, strong) ECTUtilityMethods *utilityMethods;

@end

@implementation ECTDailyForecastTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    _utilityMethods = [[ECTUtilityMethods alloc] init];
    
    UINib *dailyForcstNib = [UINib nibWithNibName:@"ECTDailyForecastCell" bundle:nil];
    [self.tableView registerNib:dailyForcstNib forCellReuseIdentifier:@"ECTDailyForecastCell"];
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:@selector(dismissVC)];
    
    self.navigationItem.rightBarButtonItem = doneBtn;
    self.navigationItem.title = @"Next few hours";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([_hourlyForecast.data count] > 0) ? [_hourlyForecast.data count] : 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if([_hourlyForecast.data count] > 0)
    {
        ECTDailyForecastCell *forecastCell = [tableView dequeueReusableCellWithIdentifier:@"ECTDailyForecastCell"
                                                                             forIndexPath:indexPath];
        
        ECTForecastData *hourlyData = _hourlyForecast.data[indexPath.row];
        
        BOOL temptIsExtreme = [_utilityMethods checkIfTemptExtreme:hourlyData.temperature];
        forecastCell.temptLabel.textColor = temptIsExtreme ? [UIColor redColor] : [UIColor blackColor];
        
        forecastCell.temptLabel.text = [NSString stringWithFormat:@"%ld%@C",(long)[[_utilityMethods convertFarenheitTemptToCelcius:hourlyData.temperature] integerValue], @"\u00B0"];
        forecastCell.dateTimeLabel.text = [_utilityMethods getDateAndDayInSATimeZone:[hourlyData.time intValue]];
        
        return forecastCell;
    }
    else
    {
        cell.textLabel.text = @"Can't see the future atm!";
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

#pragma mark - Private Method

-(void) dismissVC
{
    [self.navigationController dismissViewControllerAnimated:YES
                                                  completion:nil];
}

@end
