//
//  UICollectionViewCell+PhotoCell.m
//  HW-3
//
//  Created by Muhammad Naviwala on 11/4/14.
//  Copyright (c) 2014 Muhammad Naviwala. All rights reserved.
//

#import "PhotoCell.h"

@interface PhotoCell ()
// 1
@property(nonatomic, weak) IBOutlet UIImageView *photoImageView;
@end

@implementation PhotoCell
- (void) setAsset:(ALAsset *)asset
{
    // 2
    _asset = asset;
    self.photoImageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
}
@end
