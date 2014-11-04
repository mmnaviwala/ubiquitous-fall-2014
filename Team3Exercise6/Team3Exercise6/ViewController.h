//
//  ViewController.h
//  Team3Exercise6
//
//  Created by ubicomp3 on 10/16/14.
//  Copyright (c) 2014 CPL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate> {
    
    CGFloat _lastScale;
    CGFloat _lastRotation;
    CGFloat _firstX;
    CGFloat _firstY;
    
    UIView *canvas;
    
    CAShapeLayer *_marque;
}



@end

