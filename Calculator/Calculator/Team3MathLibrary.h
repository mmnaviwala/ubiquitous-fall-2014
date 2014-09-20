//
//  Team3MathLibrary.h
//  Calculator
//
//  Created by Gabe on 9/20/14.
//  Copyright (c) 2014 Team3. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "math.h"

@class Team3MathLibrary;

@interface Team3MathLibrary : NSObject 

+ (float)addOperand1:(float)firstFloat toOperand2:(float)secondFloat;
+ (float)subtractOperand1:(float)firstFloat fromOperand2:(float)secondFloat;
+ (float)multiplyOperand1:(float)firstFloat byOperand2:(float)secondFloat;
+ (float)divdeOperand1:(float)firstFloat byOperand2:(float)secondFloat;


+ (float)sineUsingDegrees:(float)degrees;
+ (float)sineUsingRadians:(float)radians;

+ (float)log:(float)value;
+ (float)modulusOperand1:(float)firstFloat withOperand2:(double)secondFloat;
+ (float)squareRoot:(float)value;
+ (float)exponetBase:(float)base raiseTo:(float)exponet;
+ (int)factorial:(int)value;





@end