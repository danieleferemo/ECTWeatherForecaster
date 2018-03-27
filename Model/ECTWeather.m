//
//  ECTWeather.m
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/25/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import "ECTWeather.h"

@implementation ECTWeather

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_latitude forKey:@"latitude"];
    [aCoder encodeObject:_longitude forKey:@"longitude"];
    [aCoder encodeObject:_timezone forKey:@"timezone"];
    [aCoder encodeObject:_currently forKey:@"currently"];
    [aCoder encodeObject:_hourly forKey:@"hourly"];
    [aCoder encodeObject:_daily forKey:@"daily"];
    [aCoder encodeObject:_offset forKey:@"offset"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if(self)
    {
        _latitude = [aDecoder decodeObjectForKey:@"latitude"];
        _longitude  = [aDecoder decodeObjectForKey:@"longitude"];
        _timezone  = [aDecoder decodeObjectForKey:@"timezone"];
        _currently  = [aDecoder decodeObjectForKey:@"currently"];
        _hourly  = [aDecoder decodeObjectForKey:@"hourly"];
        _daily  = [aDecoder decodeObjectForKey:@"daily"];
        _offset  = [aDecoder decodeObjectForKey:@"offset"];
    }
    return self;
}

@end
