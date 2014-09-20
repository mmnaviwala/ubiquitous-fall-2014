//
//  Team3UnitViewController.h
//  Calculator
//
//  Created by James Garcia on 9/13/14.
//  Copyright (c) 2014 Team3. All rights reserved.
//

#import "Team3DataViewController.h"

@interface Team3UnitViewController : Team3DataViewController<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerMeasurementType;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerConvertFrom;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerConvertTo;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UITextField *userInput;
@property (weak, nonatomic) IBOutlet UITextField *convertedNumberDisplay;
- (IBAction)userInputChanged:(id)sender;
@end
