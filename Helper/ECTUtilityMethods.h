//
//  ECTUtilityMethods.h
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/25/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

static NSString *kTimeZone = @"Africa/Johannesburg";

@interface ECTUtilityMethods : NSObject

-(NSInteger)getScreenWidth;

-(BOOL)checkIfTemptExtreme:(NSNumber *) tempt;
-(NSNumber *)convertFarenheitTemptToCelcius:(NSNumber *) farenheitTempt;

-(void)warnUserAboutHighTempt:(NSNumber *) tempt
                       atDate:(NSDate *) warningDate;

-(NSString *)getDateAndDayInSATimeZone:(int) timeInterval;
-(NSString *)getTimeFromUnixDate:(int) timeInterval;
-(NSString *)getDateNumbFromUnixDate:(int) timeInterval;
-(NSString *)getWeekdayFromUnixDate:(int) timeInterval;

-(void)showDropDownErrorLabelWithErrorMessage:(NSString *)errorMessage;
-(void)showNoInternetConnectionAvailableLabel;

@end
