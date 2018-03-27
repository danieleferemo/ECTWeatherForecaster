//
//  ECTForecast.m
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/25/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import "ECTForecast.h"

@implementation ECTForecast

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_summary forKey:@"summary"];
    [aCoder encodeObject:_icon forKey:@"icon"];
    [aCoder encodeObject:_data forKey:@"data"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if(self)
    {
        _summary = [aDecoder decodeObjectForKey:@"summary"];
        _icon  = [aDecoder decodeObjectForKey:@"icon"];
        _data  = [aDecoder decodeObjectForKey:@"data"];
    }
    return self;
}

@end
