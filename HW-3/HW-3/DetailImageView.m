//
//  DetailImageView.m
//  HW-3
//
//  Created by Muhammad Naviwala on 11/4/14.
//  Copyright (c) 2014 Muhammad Naviwala. All rights reserved.
//

#import "DetailImageView.h"

@interface DetailImageView ()
@end

@implementation DetailImageView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.theImage.image = self.imageToAssign;
    self.theImage.contentMode = UIViewContentModeScaleAspectFit;
}

@end
