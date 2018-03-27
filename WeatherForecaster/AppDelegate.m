//
//  AppDelegate.m
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/23/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import "AppDelegate.h"

#import "ECTWeeklyForecastTVC.h"
#import "ECTReachabilityManager.h"

#import "ECTAppConstants.h"

#import <UserNotifications/UserNotifications.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //register to monitor internet connection
    [ECTReachabilityManager sharedClient];
    
    //...Set time interval for background fetch 
    [application setMinimumBackgroundFetchInterval:kMinimumBackgroundFetchInterval];
    
    ECTWeeklyForecastTVC *weatherTVC = [[ECTWeeklyForecastTVC alloc] init];
    UINavigationController *weatherNC = [[UINavigationController alloc] initWithRootViewController:weatherTVC];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = weatherNC;
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [self configureLocalNotifications];
    
    return YES;
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSDictionary *userInfo = @{@"backgroundFetchCompletionHandler": completionHandler};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backgroundFetchNotification"
                                                        object:nil
                                                      userInfo:userInfo];
}


#pragma mark - Private methods

-(void) configureLocalNotifications
{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    
    UNNotificationAction *deleteAction = [UNNotificationAction actionWithIdentifier:@"Delete"
                                                                              title:@"Seen"
                                                                            options:UNNotificationActionOptionNone];
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"ECTWarningCategory"
                                                                              actions:@[deleteAction]
                                                                    intentIdentifiers:@[]
                                                                              options:UNNotificationCategoryOptionCustomDismissAction];
    NSSet *categories = [NSSet setWithObject:category];
    [center setNotificationCategories:categories];
    
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                          completionHandler:^(BOOL granted, NSError * _Nullable error)
     {
         if (granted)
         {
             
         }
     }];
}

@end
