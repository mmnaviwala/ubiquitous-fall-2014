//
//  Team3HexViewController.h
//  Calculator
//
//  Created by James Garcia on 9/13/14.
//  Copyright (c) 2014 Team3. All rights reserved.
//

#import "Team3DataViewController.h"

@interface Team3HexViewController : Team3DataViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *binaryInput;
@property (weak, nonatomic) IBOutlet UITextField *decimalInput;
@property (weak, nonatomic) IBOutlet UITextField *hexInput;




@end
