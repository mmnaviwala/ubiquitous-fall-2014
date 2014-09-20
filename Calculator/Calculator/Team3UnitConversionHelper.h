//
//  Team3UnitConversionHelper.h
//  Calculator
//
//  Created by Muhammad Naviwala on 9/20/14.
//  Copyright (c) 2014 Team3. All rights reserved.
//

#ifndef Calculator_Team3UnitConversionHelper_h
#define Calculator_Team3UnitConversionHelper_h

#import <Foundation/Foundation.h>

@interface Team3UnitConversionHelper : NSObject

#pragma mark - Length
+ (double)convertKilometerToMeter:(double)numberToConvert;
+ (double)convertKilometerToCentimeter:(double)numberToConvert;
+ (double)convertMeterToKilometer:(double)numberToConvert;
+ (double)convertMeterToCentimeter:(double)numberToConvert;
+ (double)convertCentimeterToKilometer:(double)numberToConvert;
+ (double)convertCentimeterToMeter:(double)numberToConvert;

#pragma mark - Mass
+ (double)convertMetricTonToKilogram:(double)numberToConvert;
+ (double)convertMetricTonToGram:(double)numberToConvert;
+ (double)convertMetricTonToMilligram:(double)numberToConvert;
+ (double)convertKilogramToMetricTon:(double)numberToConvert;
+ (double)convertKilogramToGram:(double)numberToConvert;
+ (double)convertKilogramToMilligram:(double)numberToConvert;
+ (double)convertGramToMetricTon:(double)numberToConvert;
+ (double)convertGramToKiloGram:(double)numberToConvert;
+ (double)convertGramToMilligram:(double)numberToConvert;
+ (double)convertMilligramToMetricTon:(double)numberToConvert;
+ (double)convertMilligramToKilogram:(double)numberToConvert;
+ (double)convertMilligramToGram:(double)numberToConvert;

#pragma mark - Time
+ (double)convertDaysToHours:(double)numberToConvert;
+ (double)convertDaysToMinutes:(double)numberToConvert;
+ (double)convertHoursToDays:(double)numberToConvert;
+ (double)convertHoursToMinutes:(double)numberToConvert;
+ (double)convertMinutesToDays:(double)numberToConvert;
+ (double)convertMinutesToHours:(double)numberToConvert;

#pragma mark - Temperature
+ (double)convertCelsiusToFahrenheit:(double)numberToConvert;
+ (double)convertCelsiusToKelvin:(double)numberToConvert;
+ (double)convertFahrenheitToCelsius:(double)numberToConvert;
+ (double)convertFahrenheitToKelvin:(double)numberToConvert;
+ (double)convertKelvinToCelsius:(double)numberToConvert;
+ (double)convertKelvinToFahrenheit:(double)numberToConvert;

@end



#endif
