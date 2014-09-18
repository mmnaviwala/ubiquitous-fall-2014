//
//  Team3BasicViewController.h
//  Calculator
//
//  Created by James Garcia on 9/13/14.
//  Copyright (c) 2014 Team3. All rights reserved.
//

#import "Team3DataViewController.h"

@interface Team3BasicViewController : Team3DataViewController<UITextFieldDelegate>

@property (nonatomic) BOOL typingNumber; //check if user is typing a number
@property (nonatomic) float firstNumber;
@property (nonatomic) float secondNumber;
@property (nonatomic, copy) NSString *operation; // +,-,*,/ operation
//@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;

- (IBAction)clear:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *calculationDisplay;

- (IBAction)calculationPressed:(id)sender;

- (IBAction)equalsPressed:(UIButton *)sender;


- (IBAction)numberPressed:(UIButton *)sender;





@end
