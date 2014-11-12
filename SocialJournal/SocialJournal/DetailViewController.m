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

/*
 * Method: replaceWordInString(text:removed:replacement)
 * pass text, the word to be removed, and the word to be replaced to this method
 * it will return the text with the removed word replaced with the desired wored
 */
-(NSString*) replaceWordInString: (NSString*)text : (NSString*)removed : (NSString*)replacement{
    return [text stringByReplacingOccurrencesOfString:removed withString:replacement];
}

/*
 * Method: getTagsFromText(text)
 * pass text to this method and it will return an array of hashtags
 * a hashtag is any of the following:
 * #yes #YESyesyes # no #n o #YesYes
 * no whitespace in a hashtag
 */
- (NSMutableArray*) getTagsFromText: (NSString*)text{
    //initialize the arrays
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *wordArray = [text componentsSeparatedByString:@" "];
    
    //go through the text to find hashtags
    for(int i = 0; i < wordArray.count; i++){
        //if the first letter of a word starts with a hashtag
        if([[wordArray[i] substringFromIndex:0] containsString:@"#"]){
            NSString *temp = [wordArray objectAtIndex:i];
            //more in depth hashtag checking to make sure its a valid format
            //could potentially change to regex if someone wants to get fancy
            if(temp.length > 1 &&
               ![temp hasPrefix:@"##"] &&
               ![[temp substringFromIndex:1] containsString:@"#"]){
                
                //add the correct hashtag to the result array
                [result addObject:temp];
                //NSLog(@"%@", result);
            }
        }
    }
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitButtonClicked:(id)sender {
    
    NSMutableArray *entryTags = [self getTagsFromText:self.journalEntryTextView.text];
    NSMutableArray *titleTags = [self getTagsFromText:self.titleText.text];
    NSArray *tags = [entryTags arrayByAddingObjectsFromArray:titleTags];
    NSLog(@"%@", tags);
    
    PFObject *eachEntry = [PFObject objectWithClassName:@"Entries"];
    eachEntry[@"title"] = self.titleText.text;
    eachEntry[@"entry"] = self.journalEntryTextView.text;
    [eachEntry saveEventually];
}




@end
