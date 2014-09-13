//
//  Team3HexViewController.m
//  Calculator
//
//  Created by James Garcia on 9/13/14.
//  Copyright (c) 2014 Team3. All rights reserved.
//

#import "Team3HexViewController.h"
#define BINARY_ACCEPTABLE_CHARACTERS @"01"
#define DECIMAL_ACCEPTABLE_CHARACTERS @"0123456789"
#define HEX_ACCEPTABLE_CHARACTERS @"0123456789ABCDEFabcdef"

@interface Team3HexViewController ()

@end

@implementation Team3HexViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initializatio
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.binaryInput setDelegate:self];
    [self.decimalInput setDelegate:self];
    [self.hexInput setDelegate:self];
    [self.binaryInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.decimalInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.hexInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.binaryInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.decimalInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.hexInput.clearButtonMode = UITextFieldViewModeWhileEditing;

    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    
    if(textField == self.binaryInput){
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:BINARY_ACCEPTABLE_CHARACTERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
    
    }
    if(textField == self.decimalInput){
        

        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:DECIMAL_ACCEPTABLE_CHARACTERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        
        
        return [string isEqualToString:filtered];
        
    }
    if(textField == self.hexInput){
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:HEX_ACCEPTABLE_CHARACTERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
        
    }
    return YES;
    
}

-(void)textFieldDidChange :(UITextField *)textField{
    
    if(textField == self.binaryInput){
        [self binaryToDecimal:textField];
        [self binaryToHex:textField];
    }
    
    if(textField == self.decimalInput){
        [self decimalToBinary:textField];
        [self decimalToHex:textField];
    }
    
    if(textField == self.hexInput){
        [self HexToBinary:textField];
        [self HexToDecimal:textField];
    }

    

    NSLog( @"text changed: %@", textField.text);
}


- (void)binaryToDecimal:(UITextField *)textField{
    long decimal = strtol([textField.text UTF8String], NULL, 2);
    self.decimalInput.text = [[NSNumber numberWithLong:decimal] stringValue];
}


- (void)binaryToHex:(UITextField *)textField{
    self.hexInput.text = textField.text;
}


- (void)decimalToBinary:(UITextField *)textField{
    self.binaryInput.text = textField.text;
}

- (void)decimalToHex:(UITextField *)textField{
    NSString *dec = textField.text;
    NSString *hexString = [NSString stringWithFormat:@"%lX", (unsigned long)[dec integerValue]];
    self.hexInput.text = hexString;
}

- (void)HexToBinary:(UITextField *)textField{
    
    self.binaryInput.text = textField.text;
}

- (void)HexToDecimal:(UITextField *)textField{
    self.decimalInput.text = textField.text;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.binaryInput resignFirstResponder];
    [self.decimalInput resignFirstResponder];
    [self.hexInput resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.binaryInput resignFirstResponder];
    [self.decimalInput resignFirstResponder];
    [self.hexInput resignFirstResponder];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
