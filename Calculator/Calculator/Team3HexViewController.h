//
//  Team3HexViewController.h
//  Calculator
//
//  Created by James Garcia on 9/13/14.
//  Copyright (c) 2014 Team3. All rights reserved.
//

#import "Team3DataViewController.h"

@interface Team3HexViewController : Team3DataViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *binaryOutput;
@property (weak, nonatomic) IBOutlet UILabel *decimalOutput;
@property (weak, nonatomic) IBOutlet UILabel *hexOutput;
@property (weak, nonatomic) IBOutlet UIButton *buttonOne;
@property (weak, nonatomic) IBOutlet UIButton *buttonZero;
@property (strong, nonatomic) IBOutlet UIView *mainHexView;
@property (weak, nonatomic) IBOutlet UIImageView *outputBackground;
@property (weak, nonatomic) IBOutlet UIButton *binButton;
@property (weak, nonatomic) IBOutlet UIButton *decButton;
@property (weak, nonatomic) IBOutlet UIButton *hexButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIButton *backspaceButton;
@property (weak, nonatomic) IBOutlet UIButton *decButtonZero;
@property (weak, nonatomic) IBOutlet UIButton *decButtonOne;
@property (weak, nonatomic) IBOutlet UIButton *decButtonTwo;
@property (weak, nonatomic) IBOutlet UIButton *decButtonThree;
@property (weak, nonatomic) IBOutlet UIButton *decButtonFour;
@property (weak, nonatomic) IBOutlet UIButton *decButtonFive;
@property (weak, nonatomic) IBOutlet UIButton *decButtonSix;
@property (weak, nonatomic) IBOutlet UIButton *decButtonSeven;
@property (weak, nonatomic) IBOutlet UIButton *decButtonEight;
@property (weak, nonatomic) IBOutlet UIButton *decButtonNine;
@property (weak, nonatomic) IBOutlet UIButton *decButtoneBlank1;
@property (weak, nonatomic) IBOutlet UIButton *decButtonBlank2;


@end
