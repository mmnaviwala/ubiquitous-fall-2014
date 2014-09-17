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
    self.firstNumber = [self.calculationDisplay.text intValue];
    self.operation = [sender currentTitle];
}

- (IBAction)equalsPressed:(UIButton *)sender {
    self.typingNumber = NO;
    self.secondNumber = [self.calculationDisplay.text intValue];
    int result = 0;
    if ([self.operation isEqualToString:@"+"]) {
        result = self.firstNumber + self.secondNumber;
    }else if([self.operation isEqualToString:@"-"])
    {
        result = self.firstNumber - self.secondNumber;
    }
    self.calculationDisplay.text = [NSString stringWithFormat:@"%d", result];
}

- (IBAction)numberPressed:(UIButton *)sender {
    NSString *number = sender.currentTitle;
    if (self.typingNumber) {
        
        self.calculationDisplay.text = [self.calculationDisplay.text stringByAppendingString:number];
        }else
        {
            self.calculationDisplay.text = number;
            self.typingNumber = YES;
        }
}
- (IBAction)clear:(UIButton *)sender {
}
@end
