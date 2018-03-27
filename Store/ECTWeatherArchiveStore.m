//
//  ECTWeatherArchiveStore.m
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/27/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import "ECTWeatherArchiveStore.h"
#import "ECTArchiveWeather.h"

@implementation ECTWeatherArchiveStore

-(void)saveWeather:(ECTArchiveWeather *) weather
{
    //remove previous data and save new data
    [self deleteArchivedWeather];
    
    NSString *path = [self itemArchivePath];
    [NSKeyedArchiver archiveRootObject:weather
                                toFile:path];
    NSLog(@"Archiving data!!!");
}

-(ECTArchiveWeather *)unarchiveSavedWeather
{
    NSString *path = [self itemArchivePath];
    
    NSLog(@"checking for archived data!!!");
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

-(void)deleteArchivedWeather
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"weatherForecaster.archive"];
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath
                            error:&error];
}

-(NSString *)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"weatherForecaster.archive"];
}


#pragma mark - thread safe initialization

+(ECTWeatherArchiveStore *)sharedClient
{
    static ECTWeatherArchiveStore *sharedClient = nil;
    static dispatch_once_t  onceToken;
    
    dispatch_once(&onceToken, ^
                  {
                      sharedClient = [[self alloc] initPrivate];
                  });
    
    return sharedClient;
}

-(id)initPrivate
{
    if(self = [super init])
    {
        
    }
    
    return self;
}

-(id)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"init Not allowed here, use sharedClient"
                                 userInfo:nil];
    
    return nil;
}

@end
