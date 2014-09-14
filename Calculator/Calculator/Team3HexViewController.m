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
    //Sets delegates for delegate methods
    [self.binaryInput setDelegate:self];
    [self.decimalInput setDelegate:self];
    [self.hexInput setDelegate:self];
    //allows dynamic text fields by reading text via the textFieldDidChnageMethod
    [self.binaryInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.decimalInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.hexInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //adds the "clear" button (stylized as a cutout 'x' in a grey circle) when a text field is active
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
/* BEGIN MOVE textField FOCUS */
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 0; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
/* END MOVE textField FOCUS */

-(void)textFieldDidChange :(UITextField *)textField{
    //converts and sends text to other two text fields
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
    //writes to console to check whats being passed
    NSLog( @"text changed: %@", textField.text);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //removes keyboard when return key is pressed
    [self.binaryInput resignFirstResponder];
    [self.decimalInput resignFirstResponder];
    [self.hexInput resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //removes keyboard when touch even occurs outside of keyboard and/or active text field
    [self.binaryInput resignFirstResponder];
    [self.decimalInput resignFirstResponder];
    [self.hexInput resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//binary input
- (void)binaryToDecimal:(UITextField *)textField{
    long decimal = strtol([textField.text UTF8String], NULL, 2);
    self.decimalInput.text = [[NSNumber numberWithLong:decimal] stringValue];
}

- (void)binaryToHex:(UITextField *)textField{
    self.hexInput.text = textField.text;
}

//decimal input
- (void)decimalToBinary:(UITextField *)textField{
    self.binaryInput.text = textField.text;
}

- (void)decimalToHex:(UITextField *)textField{
    NSString *dec = textField.text;
    NSString *hexString = [NSString stringWithFormat:@"%lX", (unsigned long)[dec integerValue]];
    self.hexInput.text = hexString;
}

//hexadecimal input
- (void)HexToBinary:(UITextField *)textField{
    
    NSString *hexValue = textField.text;
    if ([textField.text length] > 0) {
        NSUInteger hexInteger;
        [[NSScanner scannerWithString:hexValue] scanHexInt:&hexInteger];
        self.binaryInput.text = [NSString stringWithFormat:@"%@", [self recursiveConvertToBinary:hexInteger]];
    }
    else{
        self.binaryInput.text = @"";
    }
}

- (void)HexToDecimal:(UITextField *)textField{
    self.decimalInput.text = textField.text;
}

- (NSString *)recursiveConvertToBinary:(NSUInteger)inputValue
{
    if (inputValue == 1 || inputValue == 0)
        return [NSString stringWithFormat:@"%u", inputValue];
    return [NSString stringWithFormat:@"%@%u", [self recursiveConvertToBinary:inputValue / 2], inputValue % 2];
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
