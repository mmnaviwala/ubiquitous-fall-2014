//
//  DetailViewController.m
//  SocialJournal
//
//  Created by Gabe on 10/17/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

#import "DetailViewController.h"
#import <Parse/Parse.h>

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextView *journalEntryTextView;
@property (weak, nonatomic) IBOutlet UIView *whiteBackgroundView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.whiteBackgroundView.layer.masksToBounds = NO;
    self.whiteBackgroundView.layer.shadowOffset = CGSizeMake(-15, 0);
    self.whiteBackgroundView.layer.shadowRadius = 5;
    self.whiteBackgroundView.layer.shadowOpacity = 0.7;
    
    
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitButtonClicked:(id)sender {
    PFObject *eachEntry = [PFObject objectWithClassName:@"Entries"];
    eachEntry[@"title"] = self.titleText.text;
    eachEntry[@"entry"] = self.journalEntryTextView.text;
    [eachEntry saveEventually];
}




@end
