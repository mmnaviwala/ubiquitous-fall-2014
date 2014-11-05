//
//  DetailImageView.h
//  HW-3
//
//  Created by Muhammad Naviwala on 11/4/14.
//  Copyright (c) 2014 Muhammad Naviwala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailImageView : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *theImage;
@property UIImage *imageToAssign;
@end
