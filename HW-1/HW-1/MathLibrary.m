//
//  MathLibrary.m
//  HW-1
//
//  Created by Muhammad Naviwala on 9/21/14.
//  Copyright (c) 2014 Muhammad Naviwala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MathLibrary.h"

@implementation MathLibrary

+ (float)addOperand1:(float)firstFloat toOperand2:(float)secondFloat {
    return firstFloat + secondFloat;
}

+ (float)subtractOperand1:(float)firstFloat fromOperand2:(float)secondFloat {
    return firstFloat + secondFloat;
}

+ (float)multiplyOperand1:(float)firstFloat byOperand2:(float)secondFloat {
    return firstFloat * secondFloat;
}

+ (float)divdeOperand1:(float)firstFloat byOperand2:(float)secondFloat {
    return firstFloat / secondFloat;
}

+ (float)sineUsingDegrees:(float)degrees {
    return sin( degrees * M_PI / 180.0 );
}

+ (float)sineUsingRadians:(float)radians {
    return sin( radians );
}

+ (float)log:(float)value {
    return log(value);
}

+ (float)modulusOperand1:(float)firstFloat withOperand2:(double)secondFloat {
    return modf(firstFloat, &secondFloat);
}

+ (float)squareRoot:(float)value {
    return sqrtf(value);
}

+ (float)exponetBase:(float)base raiseTo:(float)exponet {
    return powf(base, exponet);
}

+ (int)factorial:(int)value {
    if (value <= 1)
        return 1;
    else
        return value * [MathLibrary factorial:(value-1)];
}

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

#pragma mark - Hex

//binary input
+ (NSString *)binaryToDecimal:(NSString *)textField{
    long decimal = strtol([textField UTF8String], NULL, 2);
    NSString *decimalString = [[NSNumber numberWithLong:decimal] stringValue];
    return decimalString;
    
}
+ (NSString *)binaryToHex:(NSString *)textField{
    return [self decimalToHex:[self binaryToDecimal:textField]];
}
//decimal input
+ (NSString *)decimalToBinary:(NSString *)textField{
    
    NSString *binaryString = @"" ;
    NSUInteger x = [textField intValue] ;
    do {
        binaryString = [[NSString stringWithFormat: @"%lu", x&1] stringByAppendingString:binaryString];
    } while (x >>= 1);
    return binaryString;
    
    
    //return [self hexToBinary: [self decimalToHex:textField]];
}
+ (NSString *)decimalToHex:(NSString *)textField{
    NSString *decValue = textField;
    NSString *hexString = [NSString stringWithFormat:@"%lX", (unsigned long)[decValue integerValue]];
    return hexString;
}
//hexadecimal input
+ (NSString *)hexToBinary:(NSString *)textField{
    NSString *hexValue = textField;
    NSUInteger hexInteger;
    [[NSScanner scannerWithString:hexValue] scanHexInt:&hexInteger];
    NSString *binaryString = [NSString stringWithFormat:@"%@", [self recursiveConvertToBinary:hexInteger]];
    return binaryString;
}
+ (NSString *)hexToDecimal:(NSString *)textField{
    unsigned result = 0;
    NSScanner *scanner = [NSScanner scannerWithString:textField];
    [scanner scanHexInt:&result];
    NSString *decimalString = [NSString stringWithFormat:@"%u",result];
    return decimalString;
}
+ (NSString *)recursiveConvertToBinary:(NSUInteger)inputValue
{
    if (inputValue == 1 || inputValue == 0)
        return [NSString stringWithFormat:@"%lu", (unsigned long)inputValue];
    return [NSString stringWithFormat:@"%@%lu", [self recursiveConvertToBinary:inputValue / 2], inputValue % 2];
}


@end