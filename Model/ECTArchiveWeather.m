//
//  ECTArchiveWeather.m
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/27/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import "ECTArchiveWeather.h"
#import "ECTWeather.h"

@implementation ECTArchiveWeather

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_weather forKey:@"weather"];
    [aCoder encodeObject:_archivedDate forKey:@"archivedDate"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if(self)
    {
        _weather = [aDecoder decodeObjectForKey:@"weather"];
        _archivedDate  = [aDecoder decodeObjectForKey:@"archivedDate"];
    }
    return self;
}

#pragma mark - thread safe initialization

+(id)sharedClient
{
    static ECTArchiveWeather *sharedClient = nil;
    static dispatch_once_t  onceToken;
    
    dispatch_once(&onceToken, ^
                  {
                      sharedClient = [[ECTArchiveWeather alloc] init];
                  });
    
    return sharedClient;
}

@end
