//
//  Team3UnitConversionHelper.m
//  Calculator
//
//  Created by Muhammad Naviwala on 9/20/14.
//  Copyright (c) 2014 Team3. All rights reserved.
//

#import "Team3UnitConversionHelper.h"

@implementation Team3UnitConversionHelper

#pragma mark - Length
+ (double)convertKilometerToMeter:(double)numberToConvert{
    return (numberToConvert*1000);
}
+ (double)convertKilometerToCentimeter:(double)numberToConvert{
    return (numberToConvert*100000);
}
+ (double)convertMeterToKilometer:(double)numberToConvert{
    return (numberToConvert*0.001);
}
+ (double)convertMeterToCentimeter:(double)numberToConvert{
    return (numberToConvert*100);
}
+ (double)convertCentimeterToKilometer:(double)numberToConvert{
    return (numberToConvert*0.00001);
}
+ (double)convertCentimeterToMeter:(double)numberToConvert{
    return (numberToConvert*0.01);
}

#pragma mark - Mass
+ (double)convertMetricTonToKilogram:(double)numberToConvert{
    return (numberToConvert*1000);
}
+ (double)convertMetricTonToGram:(double)numberToConvert{
    return (numberToConvert*1000000);
}
+ (double)convertMetricTonToMilligram:(double)numberToConvert{
    return (numberToConvert*1000000000);
}
+ (double)convertKilogramToMetricTon:(double)numberToConvert{
    return (numberToConvert*0.001);
}
+ (double)convertKilogramToGram:(double)numberToConvert{
    return (numberToConvert*1000);
}
+ (double)convertKilogramToMilligram:(double)numberToConvert{
    return (numberToConvert*1000000);
}
+ (double)convertGramToMetricTon:(double)numberToConvert{
    return (numberToConvert*0.000001);
}
+ (double)convertGramToKiloGram:(double)numberToConvert{
    return (numberToConvert*0.001);
}
+ (double)convertGramToMilligram:(double)numberToConvert{
    return (numberToConvert*1000);
}
+ (double)convertMilligramToMetricTon:(double)numberToConvert{
    return (numberToConvert*0.000000001);
}
+ (double)convertMilligramToKilogram:(double)numberToConvert{
    return (numberToConvert*0.000001);
}
+ (double)convertMilligramToGram:(double)numberToConvert{
    return (numberToConvert*0.001);
}

#pragma mark - Time
+ (double)convertDaysToHours:(double)numberToConvert{
    return (numberToConvert*24);
}
+ (double)convertDaysToMinutes:(double)numberToConvert{
    return (numberToConvert*1440);
}
+ (double)convertHoursToDays:(double)numberToConvert{
    return (numberToConvert*0.0416667);
}
+ (double)convertHoursToMinutes:(double)numberToConvert{
    return (numberToConvert*60);
}
+ (double)convertMinutesToDays:(double)numberToConvert{
    return (numberToConvert*0.000694444);
}
+ (double)convertMinutesToHours:(double)numberToConvert{
    return (numberToConvert*0.0166667);
}

#pragma mark - Temperature
+ (double)convertCelsiusToFahrenheit:(double)numberToConvert{
    return ((numberToConvert*5/9)+32);
}
+ (double)convertCelsiusToKelvin:(double)numberToConvert{
    return (numberToConvert+273.15);
}
+ (double)convertFahrenheitToCelsius:(double)numberToConvert{
    return ((numberToConvert*-32)*5/9);
}
+ (double)convertFahrenheitToKelvin:(double)numberToConvert{
    return ((numberToConvert+459.67)*5/9);
}
+ (double)convertKelvinToCelsius:(double)numberToConvert{
    return (numberToConvert-273.15);
}
+ (double)convertKelvinToFahrenheit:(double)numberToConvert{
    return (((numberToConvert-273.15)*1.8)+32);
}


@end

