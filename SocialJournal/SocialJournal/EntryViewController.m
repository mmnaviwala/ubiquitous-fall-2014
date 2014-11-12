//
//  EntryViewController.m
//  SocialJournal
//
//  Created by James Garcia on 11/9/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

#import "EntryViewController.h"

@interface EntryViewController ()
@property (weak, nonatomic) IBOutlet UIView *whiteBackgroundView;

@end

@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.whiteBackgroundView.layer.masksToBounds = NO;
    self.whiteBackgroundView.layer.shadowOffset = CGSizeMake(-15, 0);
    self.whiteBackgroundView.layer.shadowRadius = 5;
    self.whiteBackgroundView.layer.shadowOpacity = 0.7;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)heartButtonClicked:(UIButton *)sender {
    NSLog(@"%@", [sender.imageView accessibilityIdentifier]);
    if ([[sender.imageView accessibilityIdentifier] isEqualToString:@"HeartWhite"]) {
        UIImageView *newImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HeartRed"]];
        [sender setImage:newImageView.image forState:UIControlStateNormal];
    }else{
        UIImageView *newImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HeartWhite"]];
        [sender setImage:newImageView.image forState:UIControlStateNormal];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
