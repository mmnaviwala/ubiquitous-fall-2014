//
//  Team3HexViewController.m
//  Calculator
//
//  Created by James Garcia on 9/13/14.
//  Copyright (c) 2014 Team3. All rights reserved.
//

#import "Team3HexViewController.h"
#define BINARY_ACCEPTABLE_CHARACTERS @"01"
#define DECIMAL_ACCEPTABLE_CHARACTERS @"-0123456789"
#define HEX_ACCEPTABLE_CHARACTERS @"0123456789ABCDEFabcdef"

@interface Team3HexViewController ()

@property NSString *interfaceMode;

@end

@implementation Team3HexViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self hideBinInput:NO];
    [self hideDecInput:YES];
    [self hideHexInput:YES];
    self.interfaceMode = @"binary";
    
}

- (void)pressNumber:(NSString *)inputField :(NSString *)inputValue
{
    NSLog(@"inputField: %@",inputField);
    NSLog(@"inputField: %@",inputValue);
    
    if ([inputField  isEqual: @"binary"]) {
        
        if ([inputValue  isEqual: @"backspace"]) {
            if (![self.binaryOutput.text  isEqual: @""]) {
                self.binaryOutput.text = [self.binaryOutput.text substringToIndex:[self.binaryOutput.text length] - 1];
                self.decimalOutput.text = [self binaryToDecimal:self.binaryOutput.text];
                self.hexOutput.text = [self binaryToHex:self.binaryOutput.text];
            }
        }else{
            NSMutableString *texter = [[NSMutableString alloc] init];
            [texter setString: self.binaryOutput.text];
            if (texter.length > 31) {
                [texter appendString:@""];
            }else{
                [texter appendString:inputValue];
            }
            self.binaryOutput.text = texter;
            self.decimalOutput.text = [self binaryToDecimal:self.binaryOutput.text];
            self.hexOutput.text = [self binaryToHex:self.binaryOutput.text];
        }
        
    }
    
    if ([inputField  isEqual: @"decimal"]) {
        
        if ([inputValue  isEqual: @"backspace"]) {
            if (![self.decimalOutput.text  isEqual: @""]) {
                self.decimalOutput.text = [self.decimalOutput.text substringToIndex:[self.decimalOutput.text length] - 1];
                self.binaryOutput.text = [self decimalToBinary:self.decimalOutput.text];
                self.hexOutput.text = [self decimalToHex:self.decimalOutput.text];
            }
        }else{
            NSMutableString *texter = [[NSMutableString alloc] init];
            [texter setString: self.decimalOutput.text];
            if (texter.length > 31) {
                [texter appendString:@""];
            }else{
                [texter appendString:inputValue];
            }
            self.decimalOutput.text = texter;
            self.binaryOutput.text = [self decimalToBinary:self.decimalOutput.text];
            self.hexOutput.text = [self decimalToHex:self.decimalOutput.text];
        }
    }
}

- (IBAction)pressButton:(UIButton *)sender {
    //clear
    if (sender == self.clearButton) {
        self.binaryOutput.text = @"";
        self.hexOutput.text = @"";
        self.decimalOutput.text = @"";
    }
    //backspace
    if (sender == self.backspaceButton) {
        [self pressNumber:self.interfaceMode :@"backspace"];
    }
    
    //dec interface
    if (sender == self.binButton) {
        [self hideBinInput:NO];
        [self hideDecInput:YES];
        [self hideHexInput:YES];
    }
    if (sender == self.decButton) {
        [self hideBinInput:YES];
        [self hideDecInput:NO];
        [self hideHexInput:YES];
    }
    if (sender == self.hexButton) {
        [self hideBinInput:YES];
        [self hideDecInput:YES];
        [self hideHexInput:NO];
    }
    
    
    //bin input
    if (sender == self.buttonZero) {
        [self pressNumber:@"binary" :@"0"];
    }
    if (sender == self.buttonOne) {
        [self pressNumber:@"binary" :@"1"];
    }
    
    //decimal input
    if (sender == self.decButtonZero) {
        [self pressNumber:@"decimal" :@"0"];
    }
    if (sender == self.decButtonOne) {
        [self pressNumber:@"decimal" :@"1"];
    }
    if (sender == self.decButtonTwo) {
        [self pressNumber:@"decimal" :@"2"];
    }
    if (sender == self.decButtonThree) {
        [self pressNumber:@"decimal" :@"3"];
    }
    if (sender == self.decButtonFour) {
        [self pressNumber:@"decimal" :@"4"];
    }
    if (sender == self.decButtonFive) {
        [self pressNumber:@"decimal" :@"5"];
    }
    if (sender == self.decButtonSix) {
        [self pressNumber:@"decimal" :@"6"];
    }
    if (sender == self.decButtonSeven) {
        [self pressNumber:@"decimal" :@"7"];
    }
    if (sender == self.decButtonEight) {
        [self pressNumber:@"decimal" :@"8"];
    }
    if (sender == self.decButtonNine) {
        [self pressNumber:@"decimal" :@"9"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//binary input
- (NSString *)binaryToDecimal:(NSString *)textField{
    
    if ([textField length] > 0) {
        long decimal = strtol([textField UTF8String], NULL, 2);
        NSString *decimalString = [[NSNumber numberWithLong:decimal] stringValue];
        return decimalString;
        
    }
    else{
        return @"";
    }
    
}

- (NSString *)binaryToHex:(NSString *)textField{
    
    if ([textField length] > 0) {
        return [self decimalToHex:[self binaryToDecimal:textField]];
    }
    else{
        return @"";
    }
}

//decimal input
- (NSString *)decimalToBinary:(NSString *)textField{
    
    if ([textField length] > 0) {
        return [self HexToBinary: [self decimalToHex:textField]];
    }
    else{
        return @"";
    }
}

- (NSString *)decimalToHex:(NSString *)textField{
    
    if ([textField length] > 0) {
        NSString *decValue = textField;
        NSString *hexString = [NSString stringWithFormat:@"%lX", (unsigned long)[decValue integerValue]];
        return hexString;
    }
    else{
        return @"";
    }
}

//hexadecimal input
- (NSString *)HexToBinary:(NSString *)textField{
    
    if ([textField length] > 0) {
        NSString *hexValue = textField;
        NSUInteger hexInteger;
        [[NSScanner scannerWithString:hexValue] scanHexInt:&hexInteger];
        NSString *binaryString = [NSString stringWithFormat:@"%@", [self recursiveConvertToBinary:hexInteger]];
        return binaryString;
    }
    else{
        return @"";
    }
}

- (NSString *)HexToDecimal:(NSString *)textField{
    
    if ([textField length] > 0) {
        unsigned result = 0;
        NSScanner *scanner = [NSScanner scannerWithString:textField];
        [scanner scanHexInt:&result];
        NSString *decimalString = [NSString stringWithFormat:@"%u",result];
        return decimalString;
    }
    else{
        return @"";
    }
}

- (NSString *)recursiveConvertToBinary:(NSUInteger)inputValue
{
    if (inputValue == 1 || inputValue == 0)
        return [NSString stringWithFormat:@"%u", inputValue];
    return [NSString stringWithFormat:@"%@%u", [self recursiveConvertToBinary:inputValue / 2], inputValue % 2];
}

- (void)hideBinInput:(BOOL) option
{
    if (!option) {
        [self.binButton setTitleColor:[UIColor colorWithRed:60.0/256.0 green:62.0/256.0 blue:80.0/256.0 alpha:0.5] forState:UIControlStateNormal];
        [self.decButton setTitleColor:[UIColor colorWithRed:60.0/256.0 green:62.0/256.0 blue:80.0/256.0 alpha:1.0] forState:UIControlStateNormal];
        [self.hexButton setTitleColor:[UIColor colorWithRed:60.0/256.0 green:62.0/256.0 blue:80.0/256.0 alpha:1.0] forState:UIControlStateNormal];
        self.interfaceMode = @"binary";
    }
    [self.buttonZero setHidden:option];
    [self.buttonOne setHidden:option];
}

- (void)hideDecInput:(BOOL) option
{
    if (!option) {
        [self.binButton setTitleColor:[UIColor colorWithRed:60.0/256.0 green:62.0/256.0 blue:80.0/256.0 alpha:1.0] forState:UIControlStateNormal];
        [self.decButton setTitleColor:[UIColor colorWithRed:60.0/256.0 green:62.0/256.0 blue:80.0/256.0 alpha:0.5] forState:UIControlStateNormal];
        [self.hexButton setTitleColor:[UIColor colorWithRed:60.0/256.0 green:62.0/256.0 blue:80.0/256.0 alpha:1.0] forState:UIControlStateNormal];
        self.interfaceMode = @"decimal";
    }
    
    [self.decButtoneBlank1 setHidden:option];
    [self.decButtonBlank2 setHidden:option];
    [self.decButtonZero setHidden:option];
    [self.decButtonOne setHidden:option];
    [self.decButtonTwo setHidden:option];
    [self.decButtonThree setHidden:option];
    [self.decButtonFour setHidden:option];
    [self.decButtonFive setHidden:option];
    [self.decButtonSix setHidden:option];
    [self.decButtonSeven setHidden:option];
    [self.decButtonEight setHidden:option];
    [self.decButtonNine setHidden:option];
    
}

- (void)hideHexInput:(BOOL) option
{
    if (!option) {
        [self.binButton setTitleColor:[UIColor colorWithRed:60.0/256.0 green:62.0/256.0 blue:80.0/256.0 alpha:1.0] forState:UIControlStateNormal];
        [self.decButton setTitleColor:[UIColor colorWithRed:60.0/256.0 green:62.0/256.0 blue:80.0/256.0 alpha:1.0] forState:UIControlStateNormal];
        [self.hexButton setTitleColor:[UIColor colorWithRed:60.0/256.0 green:62.0/256.0 blue:80.0/256.0 alpha:0.5] forState:UIControlStateNormal];
        self.interfaceMode = @"hexadecimal";
    }
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
