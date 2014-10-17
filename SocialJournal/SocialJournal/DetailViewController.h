//
//  DetailViewController.h
//  SocialJournal
//
//  Created by Gabe on 10/17/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

