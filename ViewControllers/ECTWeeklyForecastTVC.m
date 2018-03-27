//
//  ECTWeeklyForecastTVC.m
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/25/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import "ECTWeeklyForecastTVC.h"

#import "ECTWeeklyForecastCell.h"
#import "ECTForecasterStore.h"

#import "ECTWeather.h"
#import "ECTForecast.h"
#import "ECTForecastData.h"

#import "ECTArchiveWeather.h"
#import "ECTWeatherArchiveStore.h"

#import "ECTDailyForecastTVC.h"

#import "ECTUtilityMethods.h"
#import "ECTReachabilityManager.h"
#import "ECTAppConstants.h"

#import <UserNotifications/UserNotifications.h>

@interface ECTWeeklyForecastTVC ()

@property (nonatomic, strong) ECTWeather *weather;
@property (nonatomic, strong) NSArray *weekForecastArray;
@property (nonatomic, strong) ECTForecasterStore *forecasterStore;
@property (nonatomic, strong) ECTUtilityMethods *utilityMethods;
@property (nonatomic, readwrite) BOOL activeInternetConnectionAvailable;

@end

@implementation ECTWeeklyForecastTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    _activeInternetConnectionAvailable = [ECTReachabilityManager isReachable];
    _forecasterStore = [ECTForecasterStore  sharedClient];
    _utilityMethods = [[ECTUtilityMethods alloc] init];
    
    [self.tableView registerClass:[ECTWeeklyForecastCell class] forCellReuseIdentifier:@"ECTWeeklyForecastCell"];
    
    // Register for background fetches
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getForecastInBg:)
                                                 name:@"backgroundFetchNotification"
                                               object:nil];
    
    //refresh button
    UIBarButtonItem *refreshBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                           target:self
                                                                           action:@selector(refreshPage)];
    
    UIBarButtonItem *moreBtn = [[UIBarButtonItem alloc] initWithTitle:@"More"
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:@selector(showHourlyForecast)];
    
    self.navigationItem.leftBarButtonItem = moreBtn;
    self.navigationItem.rightBarButtonItem = refreshBtn;
    self.navigationItem.title = @"Cape Town Tempt.";
    
    [self requestWeatherForecast];
    
    /* Uncomment below code to force request immediately, instead of checking for local data. */
//    [self getWeatherForecast];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_weekForecastArray != nil && [_weekForecastArray count] > 0)
    {
         return [_weekForecastArray count];
    }
    else
    {
        return 1.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.numberOfLines = 0;
    
    if(_weekForecastArray != nil && [_weekForecastArray count] > 0)
    {
        ECTWeeklyForecastCell *forecastCell = [tableView dequeueReusableCellWithIdentifier:@"ECTWeeklyForecastCell" forIndexPath:indexPath];
        
        if(indexPath.row == 0)
        {
            ECTForecastData *forcastData = _weather.currently;
            ECTForecast *today = _weather.hourly;
            
            BOOL temptIsExtreme = [_utilityMethods checkIfTemptExtreme:forcastData.temperature];
            forecastCell.temperatureLbl.textColor = temptIsExtreme ? [UIColor redColor] : [UIColor blackColor];
            
            forecastCell.temperatureLbl.text = [NSString stringWithFormat:@"%ld%@C",(long)[[_utilityMethods convertFarenheitTemptToCelcius:forcastData.temperature] integerValue], @"\u00B0"];
            
            NSString *descText = [NSString stringWithFormat:@"Currently %@. %@",forcastData.summary, today.summary];
            forecastCell.descLbl.text = descText;
            
            forecastCell.chanceOfRainLbl.text = [NSString stringWithFormat:@"%ld%% C.O.R",(long)([forcastData.precipProbability doubleValue] * 100)];
            forecastCell.dateDayLbl.text = @"Today";
            forecastCell.dateNumbLbl.text = [NSString stringWithFormat:@"%@", [_utilityMethods getDateNumbFromUnixDate:[forcastData.time intValue]]];
            return forecastCell;
        }
        else
        {
            ECTForecastData *forcastData = _weekForecastArray[indexPath.row];
            forecastCell.temperatureLbl.text = [NSString stringWithFormat:@"%ld%@C",(long)[[_utilityMethods convertFarenheitTemptToCelcius:forcastData.temperatureHigh] integerValue], @"\u00B0"];
            
            NSNumber *temptHigh = [_utilityMethods convertFarenheitTemptToCelcius:forcastData.temperatureHigh];
            NSNumber *temptLow = [_utilityMethods convertFarenheitTemptToCelcius:forcastData.temperatureLow];
            
            NSString *descText = [NSString stringWithFormat:@"%@ The high would be %ld%@C, and the low would be %ld%@C",forcastData.summary,
                                                                                                                  (long)[temptHigh integerValue],@"\u00B0",
                                                                                                                  (long)[temptLow integerValue], @"\u00B0"];
            forecastCell.descLbl.text = descText;
            
            forecastCell.chanceOfRainLbl.text = [NSString stringWithFormat:@"%ld%% C.O.R", (long)([forcastData.precipProbability doubleValue] * 100)];
            forecastCell.dateDayLbl.text = [NSString stringWithFormat:@"%@", [_utilityMethods getWeekdayFromUnixDate:[forcastData.time intValue]]];
            forecastCell.dateNumbLbl.text = [NSString stringWithFormat:@"%@", [_utilityMethods getDateNumbFromUnixDate:[forcastData.time intValue]]];
            return forecastCell;
        }
    }
    else
    {
        if(_activeInternetConnectionAvailable)
        {
            cell.textLabel.text = @"Fetching forecast...";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            return cell;
        }
        else
        {
            cell.textLabel.text = @"Reconnect to the internet and refresh.";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            return cell;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_utilityMethods getScreenWidth] * 0.4;
}

#pragma mark - Private methods

- (void) showHourlyForecast
{
    if(_weather != nil && _weather.hourly != nil)
    {
        ECTDailyForecastTVC *dailyForecastVC = [[ECTDailyForecastTVC alloc] init];
        dailyForecastVC.hourlyForecast = _weather.hourly;
        
        UINavigationController *dfNC = [[UINavigationController alloc] initWithRootViewController:dailyForecastVC];
        
        [self.navigationController presentViewController:dfNC
                                                animated:YES
                                              completion:nil];
        
    }
    else
    {
        [_utilityMethods showDropDownErrorLabelWithErrorMessage:@"Just a sec..."];
    }
}

-(void)refreshPage
{
    [self requestWeatherForecast];
}

-(void) requestWeatherForecast
{
    NSLog(@"trying to request archived data");
    ECTArchiveWeather *archWeather = [[ECTWeatherArchiveStore sharedClient] unarchiveSavedWeather];
    NSTimeInterval timeSinceLastRequest = [[NSDate date] timeIntervalSinceDate:archWeather.archivedDate];
    
    if(archWeather != nil && timeSinceLastRequest < (kMinimumBackgroundFetchInterval - 300))
    {
        //archived data is less than 15mins. Use archived data!
        _weather = archWeather.weather;
        ECTForecast *dailyForecast = _weather.daily;
        _weekForecastArray = [[NSArray alloc] initWithArray:dailyForecast.data];
        [self checkWeatherForecastForExtremeTempt:archWeather.weather];
        [self.tableView reloadData];
        NSLog(@"archived data recieved");
    }
    else
    {
        //...archived data too old, get new data
        [self getWeatherForecast];
        NSLog(@"no archive data, requesting new data");
    }
}

-(void) getForecastInBg:(NSNotification *) notification
{
    /* ============ The completion handler block to call when the data fetching is finished! Must call!!! ============= */
    NSDictionary *userInfo = notification.userInfo;
    void (^backgroundFetchCompletionHandler)(UIBackgroundFetchResult) = [userInfo objectForKey:@"backgroundFetchCompletionHandler"];
    
    _activeInternetConnectionAvailable = [ECTReachabilityManager isReachable];
    if(_activeInternetConnectionAvailable)
    {
        [_forecasterStore getCurrentWeatherForecastInBackground:YES
                                                 WithCompletion:^(BOOL success, ECTWeather *weather, NSError *error)
         {
             if(success)
             {
                 _weather = weather;
                 ECTForecast *dailyForecast = _weather.daily;
                 _weekForecastArray = [[NSArray alloc] initWithArray:dailyForecast.data];
                 [self archiveWeatherData:weather];
                 [self checkWeatherForecastForExtremeTempt:weather];
                 
                 [self.tableView reloadData];
                 backgroundFetchCompletionHandler(UIBackgroundFetchResultNewData);
             }
             else
             {
                 backgroundFetchCompletionHandler(UIBackgroundFetchResultFailed);
             }
         }];
    }
    else
    {
        backgroundFetchCompletionHandler(UIBackgroundFetchResultFailed);
    }
}

-(void) getWeatherForecast
{
    _activeInternetConnectionAvailable = [ECTReachabilityManager isReachable];
    
    if(_activeInternetConnectionAvailable)
    {
        __weak typeof(self) weakSelf = self; //incase the view controller dismisses before the network request is completed

        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                       {
                           [_forecasterStore getCurrentWeatherForecastInBackground:NO
                                                                    WithCompletion:^(BOOL success, ECTWeather *weather, NSError *error)
                            {
                                if(success)
                                {
                                    _weather = weather;
                                    ECTForecast *dailyForecast = _weather.daily;
                                    _weekForecastArray = [[NSArray alloc] initWithArray:dailyForecast.data];
                                    [self archiveWeatherData:weather];
                                    [self checkWeatherForecastForExtremeTempt:weather];

                                    dispatch_async(dispatch_get_main_queue(), ^
                                                   {
                                                       [weakSelf.tableView reloadData];
                                                       [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                                   });
                                }
                                else
                                {
                                    dispatch_async(dispatch_get_main_queue(), ^
                                                   {
                                                       [weakSelf.tableView reloadData];
                                                       [_utilityMethods showDropDownErrorLabelWithErrorMessage:@"Couldn't get forecast. Try refresh."];
                                                       [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                                   });
                                }
                            }];
                       });
//        [_forecasterStore getCurrentWeatherForecastInBackground:NO
//                                                 WithCompletion:^(BOOL success, ECTWeather *weather, NSError *error)
//         {
//             if(success)
//             {
//                 _weather = weather;
//                 ECTForecast *dailyForecast = _weather.daily;
//                 _weekForecastArray = [[NSArray alloc] initWithArray:dailyForecast.data];
//                 [self archiveWeatherData:weather];
//                 [self checkWeatherForecastForExtremeTempt:weather];
//
//                 [self.tableView reloadData];
//                 [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//             }
//             else
//             {
//                 [self.tableView reloadData];
//                 [_utilityMethods showDropDownErrorLabelWithErrorMessage:@"Couldn't get forecast. Try refresh."];
//                 [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//             }
//         }];
    }
    else
    {
        [_utilityMethods showNoInternetConnectionAvailableLabel];
    }
}

-(void) checkWeatherForecastForExtremeTempt:(ECTWeather *) weather
{
    [_utilityMethods warnUserAboutHighTempt:weather.currently.temperature
                                     atDate:[[NSDate date] dateByAddingTimeInterval:30]];
}

-(void) archiveWeatherData:(ECTWeather *) weather
{
    ECTArchiveWeather *archWeather = [[ECTArchiveWeather alloc] init];
    archWeather.weather = weather;
    archWeather.archivedDate = [NSDate date];
    
    NSLog(@"requesting to archive new data");
    [[ECTWeatherArchiveStore sharedClient] saveWeather:archWeather];
}

#pragma mark - Init

-(id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if(self)
    {
        
    }
    
    return self;
}

@end
