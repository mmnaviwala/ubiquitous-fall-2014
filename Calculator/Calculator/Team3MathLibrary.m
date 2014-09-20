//
//  Team3MathLibrary.m
//  Calculator
//
//  Created by Gabe on 9/20/14.
//  Copyright (c) 2014 Team3. All rights reserved.
//
#import "Team3MathLibrary.h"


@implementation Team3MathLibrary

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
        return value * [Team3MathLibrary factorial:(value-1)];
}


@end