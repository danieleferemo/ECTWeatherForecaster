//
//  ECTForecastData.m
//  WeatherForecaster
//
//  Created by Daniel Eferemo on 3/25/18.
//  Copyright © 2018 danieleferemo. All rights reserved.
//

#import "ECTForecastData.h"

@implementation ECTForecastData

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_time forKey:@"time"];
    [aCoder encodeObject:_summary forKey:@"summary"];
    [aCoder encodeObject:_icon forKey:@"icon"];
    [aCoder encodeObject:_precipIntensity forKey:@"precipIntensity"];
    [aCoder encodeObject:_precipProbability forKey:@"precipProbability"];
    [aCoder encodeObject:_temperature forKey:@"temperature"];
    [aCoder encodeObject:_apparentTemperature forKey:@"apparentTemperature"];
    [aCoder encodeObject:_dewPoint forKey:@"dewPoint"];
    [aCoder encodeObject:_humidity forKey:@"humidity"];
    [aCoder encodeObject:_pressure forKey:@"pressure"];
    [aCoder encodeObject:_windSpeed forKey:@"windSpeed"];
    [aCoder encodeObject:_windGust forKey:@"windGust"];
    [aCoder encodeObject:_windBearing forKey:@"windBearing"];
    [aCoder encodeObject:_cloudCover forKey:@"cloudCover"];
    [aCoder encodeObject:_uvIndex forKey:@"uvIndex"];
    [aCoder encodeObject:_visibility forKey:@"visibility"];
    [aCoder encodeObject:_ozone forKey:@"ozone"];
    
    
    [aCoder encodeObject:_sunriseTime forKey:@"sunriseTime"];
    [aCoder encodeObject:_sunsetTime forKey:@"sunsetTime"];
    [aCoder encodeObject:_moonPhase forKey:@"moonPhase"];
    
    [aCoder encodeObject:_precipIntensityMax forKey:@"precipIntensityMax"];
    [aCoder encodeObject:_precipIntensityMaxTime forKey:@"precipIntensityMaxTime"];
    
    [aCoder encodeObject:_precipType forKey:@"precipType"];
    
    [aCoder encodeObject:_temperatureHigh forKey:@"temperatureHigh"];
    [aCoder encodeObject:_temperatureHighTime forKey:@"temperatureHighTime"];
    [aCoder encodeObject:_temperatureLow forKey:@"temperatureLow"];
    [aCoder encodeObject:_temperatureLowTime forKey:@"temperatureLowTime"];
    [aCoder encodeObject:_apparentTemperatureHigh forKey:@"apparentTemperatureHigh"];
    [aCoder encodeObject:_apparentTemperatureHighTime forKey:@"apparentTemperatureHighTime"];
    [aCoder encodeObject:_apparentTemperatureLow forKey:@"apparentTemperatureLow"];
    [aCoder encodeObject:_apparentTemperatureLowTime forKey:@"apparentTemperatureLowTime"];
    
    [aCoder encodeObject:_windGustTime forKey:@"windGustTime"];
    [aCoder encodeObject:_uvIndexTime forKey:@"uvIndexTime"];
    
    [aCoder encodeObject:_temperatureMin forKey:@"temperatureMin"];
    [aCoder encodeObject:_temperatureMinTime forKey:@"temperatureMinTime"];
    [aCoder encodeObject:_temperatureMax forKey:@"temperatureMax"];
    [aCoder encodeObject:_temperatureMaxTime forKey:@"temperatureMaxTime"];
    [aCoder encodeObject:_apparentTemperatureMin forKey:@"apparentTemperatureMin"];
    [aCoder encodeObject:_apparentTemperatureMinTime forKey:@"apparentTemperatureMinTime"];
    [aCoder encodeObject:_apparentTemperatureMax forKey:@"apparentTemperatureMax"];
    [aCoder encodeObject:_apparentTemperatureMaxTime forKey:@"apparentTemperatureMaxTime"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if(self)
    {
        _time = [aDecoder decodeObjectForKey:@"time"];
        _summary = [aDecoder decodeObjectForKey:@"summary"];
        _icon = [aDecoder decodeObjectForKey:@"icon"];
        _precipIntensity = [aDecoder decodeObjectForKey:@"precipIntensity"];
        _precipProbability = [aDecoder decodeObjectForKey:@"precipProbability"];
        _temperature = [aDecoder decodeObjectForKey:@"temperature"];
        _apparentTemperature = [aDecoder decodeObjectForKey:@"apparentTemperature"];
        _dewPoint = [aDecoder decodeObjectForKey:@"dewPoint"];
        _humidity = [aDecoder decodeObjectForKey:@"humidity"];
        _pressure = [aDecoder decodeObjectForKey:@"pressure"];
        _windSpeed = [aDecoder decodeObjectForKey:@"windSpeed"];
        _windGust = [aDecoder decodeObjectForKey:@"windGust"];
        _windBearing = [aDecoder decodeObjectForKey:@"windBearing"];
        _cloudCover = [aDecoder decodeObjectForKey:@"cloudCover"];
        _uvIndex = [aDecoder decodeObjectForKey:@"uvIndex"];
        _visibility = [aDecoder decodeObjectForKey:@"visibility"];
        _ozone = [aDecoder decodeObjectForKey:@"ozone"];
        
        
        _sunriseTime = [aDecoder decodeObjectForKey:@"sunriseTime"];
        _sunsetTime = [aDecoder decodeObjectForKey:@"sunsetTime"];
        _moonPhase = [aDecoder decodeObjectForKey:@"moonPhase"];
        
        _precipIntensityMax = [aDecoder decodeObjectForKey:@"precipIntensityMax"];
        _precipIntensityMaxTime = [aDecoder decodeObjectForKey:@"precipIntensityMaxTime"];
        
        _precipType = [aDecoder decodeObjectForKey:@"precipType"];
        
        _temperatureHigh = [aDecoder decodeObjectForKey:@"temperatureHigh"];
        _temperatureHighTime = [aDecoder decodeObjectForKey:@"temperatureHighTime"];
        _temperatureLow = [aDecoder decodeObjectForKey:@"temperatureLow"];
        _temperatureLowTime = [aDecoder decodeObjectForKey:@"temperatureLowTime"];
        _apparentTemperatureHigh = [aDecoder decodeObjectForKey:@"apparentTemperatureHigh"];
        _apparentTemperatureHighTime = [aDecoder decodeObjectForKey:@"apparentTemperatureHighTime"];
        _apparentTemperatureLow = [aDecoder decodeObjectForKey:@"apparentTemperatureLow"];
        _apparentTemperatureLowTime = [aDecoder decodeObjectForKey:@"apparentTemperatureLowTime"];
        
        _windGustTime = [aDecoder decodeObjectForKey:@"windGustTime"];
        _uvIndexTime = [aDecoder decodeObjectForKey:@"uvIndexTime"];
        
        _temperatureMin = [aDecoder decodeObjectForKey:@"temperatureMin"];
        _temperatureMinTime = [aDecoder decodeObjectForKey:@"temperatureMinTime"];
        _temperatureMax = [aDecoder decodeObjectForKey:@"temperatureMax"];
        _temperatureMaxTime = [aDecoder decodeObjectForKey:@"temperatureMaxTime"];
        _apparentTemperatureMin = [aDecoder decodeObjectForKey:@"apparentTemperatureMin"];
        _apparentTemperatureMinTime = [aDecoder decodeObjectForKey:@"apparentTemperatureMinTime"];
        _apparentTemperatureMax = [aDecoder decodeObjectForKey:@"apparentTemperatureMax"];
        _apparentTemperatureMaxTime = [aDecoder decodeObjectForKey:@"apparentTemperatureMaxTime"];
    }
    return self;
}

@end
