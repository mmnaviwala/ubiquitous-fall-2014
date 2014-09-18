//
//  Team3BasicViewController.m
//  Calculator
//
//  Created by James Garcia on 9/13/14.
//  Copyright (c) 2014 Team3. All rights reserved.
//

#import "Team3BasicViewController.h"

@interface Team3BasicViewController ()

@end

@implementation Team3BasicViewController

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
    // Do any additional setup after loading the view.
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

- (IBAction)calculationPressed:(id)sender {
    self.typingNumber = NO;
    self.firstNumber = [self.calculationDisplay.text floatValue];
    self.operation = [sender currentTitle];
}

- (IBAction)equalsPressed:(UIButton *)sender {
    self.typingNumber = NO;
    self.secondNumber = [self.calculationDisplay.text floatValue];
    float result = 0;

    if ([self.operation isEqualToString:@"+"]) {
        result = self.firstNumber + self.secondNumber;
    }else if([self.operation isEqualToString:@"-"])
    {
        result = self.firstNumber - self.secondNumber;
    }
    else if ([self.operation isEqualToString:@"*"])
    {
        result = self.firstNumber * self.secondNumber;
    }else if([self.operation isEqualToString:@"/"])
    {
        if (self.secondNumber !=0) {
            result = self.firstNumber / self.secondNumber;
        }else
        {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wrong Input" message:@"The divisor has to be a non-zero number " delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            
            [alert show ];
            
        }
        
    }
    
    self.calculationDisplay.text = [NSString stringWithFormat:@"%f", result];
}

- (IBAction)numberPressed:(UIButton *)sender {
    NSString *number = sender.currentTitle;
    NSRange isNumberDecimal = [self.calculationDisplay.text rangeOfString:@"."];
    if (self.typingNumber) {
        if ([number isEqualToString:@"."]) {
            // the number inside display label is not decimal
            if (isNumberDecimal.location == NSNotFound) {
                self.calculationDisplay.text = [self.calculationDisplay.text stringByAppendingString:number];
            }
        }else{ //user did not press . button
            self.calculationDisplay.text = [self.calculationDisplay.text stringByAppendingString:number];
        }
    }else{//if user start with . assume the number starts with 0
        if ([number isEqualToString:@"."]) {
            number = @"0.";
        }
        self.calculationDisplay.text = number;
        self.typingNumber = YES;
    }
    

}


- (IBAction)clear:(UIButton *)sender {
    self.calculationDisplay.text = @" ";
}
@end
