//
//  ECTUtilityMethods.m
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/25/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import "ECTUtilityMethods.h"
#import <UIKit/UIKit.h>
#import "ECTAppConstants.h"

@interface ECTUtilityMethods ()

@property (strong,nonatomic) UIWindow *dropDownWindow;
@property (strong,nonatomic) UILabel *errorLabel;

@end

@implementation ECTUtilityMethods

-(NSInteger)getScreenWidth
{
    return [[UIScreen mainScreen] bounds].size.width;
}

#pragma mark - Date/Time

-(NSString *)getDateAndDayInSATimeZone:(int) timeInterval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:kTimeZone];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm"];
    [df setTimeZone:timeZone];
    
    NSString *time = [df stringFromDate:date];
    NSString *day = [self getWeekdayFromUnixDate:timeInterval];
    
    return [NSString stringWithFormat:@"%@, %@",day,time];
}

-(NSString *)getTimeFromUnixDate:(int) timeInterval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:kTimeZone];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"hh"];
    [df setTimeZone:timeZone];
    
    return [df stringFromDate:date];
}

-(NSString *)getDateNumbFromUnixDate:(int) timeInterval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:kTimeZone];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd"];
    [df setTimeZone:timeZone];
    
    return [df stringFromDate:date];
}

-(NSString *)getWeekdayFromUnixDate:(int) timeInterval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];

    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents* dateComp = [cal components:NSCalendarUnitWeekday fromDate:date];

    return cal.shortWeekdaySymbols[dateComp.weekday - 1];
}

#pragma mark - Tempt

-(BOOL)checkIfTemptExtreme:(NSNumber *) tempt
{
    NSNumber *temptCelcius = [self convertFarenheitTemptToCelcius:tempt];
    
    if([temptCelcius integerValue] < kMinimumSafeTemperature || [temptCelcius integerValue] > kMaximumSafeTemperature)
    {
        return true;
    }
    else
        return false;
}

-(NSNumber *)convertFarenheitTemptToCelcius:(NSNumber *) farenheitTempt
{
    return [NSNumber numberWithFloat:([farenheitTempt integerValue] - 32) / 1.8];
}

#pragma mark - Local Notification

-(void)warnUserAboutHighTempt:(NSNumber *) tempt
                       atDate:(NSDate *) warningDate
{
    NSNumber *temptCelcius = [self convertFarenheitTemptToCelcius:tempt];
    
    if([self checkIfTemptExtreme:tempt])
    {
        UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
        
        if([temptCelcius integerValue] < kMinimumSafeTemperature)
        {
            notificationContent.title = @"It just got really cold!!!";
            notificationContent.body = [NSString stringWithFormat:@"It is currently %ld degrees Celcius", (long)[temptCelcius integerValue]];
        }
        else if ([temptCelcius integerValue] > kMaximumSafeTemperature)
        {
            notificationContent.title = @"It just got rather hot!'";
            notificationContent.body = [NSString stringWithFormat:@"Dress lightly. Currently %ld degrees Celcius", (long)[temptCelcius integerValue]];
        }
        
        notificationContent.sound = [UNNotificationSound defaultSound];
        notificationContent.categoryIdentifier = @"ECTWarningCategory";
        
        [self sendWarningNotification:notificationContent
                       withIdentifier:@"ECTLocalNotification"
                               atDate:warningDate];
    }
}

-(void)sendWarningNotification:(UNMutableNotificationContent *) notificationContent
                withIdentifier:(NSString *) requestIdentifier
                        atDate:(NSDate *) date
{
    NSDateComponents *triggerDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear +
                                     NSCalendarUnitMonth + NSCalendarUnitDay +
                                     NSCalendarUnitHour + NSCalendarUnitMinute +
                                     NSCalendarUnitSecond
                                                                    fromDate:date]; //[NSDate dateWithTimeIntervalSinceNow:5] <---use to test and change tempt. extremes in app constant
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate
                                                                                                      repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier
                                                                          content:notificationContent
                                                                          trigger:trigger];
    
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    [center addNotificationRequest:request
             withCompletionHandler:^(NSError * _Nullable error)
     {
         if (error != nil)
         {
             NSLog(@"%@",error);
         }
     }];
}

#pragma mark - Dropdown Headers

-(void)showDropDownErrorLabelWithErrorMessage:(NSString *)errorMessage
{
    CGFloat statusBarHeight = (CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]));
    
    _dropDownWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, -statusBarHeight, CGRectGetWidth([[UIScreen mainScreen] bounds]), 20)];
    
    [self animateHeaderErrorLabelWithString:errorMessage
                                     window:_dropDownWindow
                                   andLabel:_errorLabel
                              withTextColor:[UIColor redColor]];
}

-(void)showNoInternetConnectionAvailableLabel
{
    CGFloat statusBarHeight = (CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]));
    
    _dropDownWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, -statusBarHeight, CGRectGetWidth([[UIScreen mainScreen] bounds]), 20)];
    
    [self animateHeaderErrorLabelWithString:@"No Internet Connection"
                                     window:_dropDownWindow
                                   andLabel:_errorLabel
                              withTextColor:[UIColor redColor]];
}

-(void)animateHeaderErrorLabelWithString:(NSString *) errorString
                                  window:(UIWindow *) dropDownWindow
                                andLabel:(UILabel *) errorLabel
                               withTextColor:(UIColor *) textColor
{
    CGFloat statusBarHeight = (CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]));
    
    dropDownWindow.backgroundColor = [UIColor lightGrayColor];
    
    errorLabel = [[UILabel alloc] initWithFrame:dropDownWindow.bounds];
    errorLabel.textAlignment = NSTextAlignmentCenter;
    errorLabel.font = [UIFont systemFontOfSize:15];
    errorLabel.backgroundColor = [UIColor clearColor];
    errorLabel.textColor = textColor;
    errorLabel.text = errorString;
    
    [dropDownWindow addSubview:errorLabel];
    dropDownWindow.windowLevel = UIWindowLevelStatusBar;
    
    [dropDownWindow makeKeyAndVisible];
    [dropDownWindow resignKeyWindow];
    
    [UIView animateWithDuration:.5
                          delay:0
                        options:0
                     animations:^
     {
         dropDownWindow.frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 24);
     }
                     completion:^(BOOL finished)
     {
         //finished animating downwards
         [UIView animateWithDuration:.5
                               delay:2
                             options:0
                          animations:^
          {
              dropDownWindow.frame = CGRectMake(0, -statusBarHeight, CGRectGetWidth([[UIScreen mainScreen] bounds]), 24);
          }
                          completion:^(BOOL finished)
          {
              //finished animating back up
          }];
     }];
}

@end
