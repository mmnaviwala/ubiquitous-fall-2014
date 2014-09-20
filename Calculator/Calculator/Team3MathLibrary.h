//
//  Team3MathLibrary.h
//  Calculator
//
//  Created by Gabe on 9/20/14.
//  Copyright (c) 2014 Team3. All rights reserved.
//
#import <Foundation/Foundation.h>

@class Team3MathLibrary;

@interface Team3MathLibrary : NSObject 

+ (float)addOperand1:(float)firstFloat toOperand2:(float)secondFloat;
+ (float)subtractOperand1:(float)firstFloat fromOperand2:(float)secondFloat;
+ (float)multiplyOperand1:(float)firstFloat byOperand2:(float)secondFloat;
+ (float)divdeOperand1:(float)firstFloat byOperand2:(float)secondFloat;




@end