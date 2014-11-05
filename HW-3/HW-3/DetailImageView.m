//
//  DetailImageView.m
//  HW-3
//
//  Created by Muhammad Naviwala on 11/4/14.
//  Copyright (c) 2014 Muhammad Naviwala. All rights reserved.
//

#import "DetailImageView.h"

@interface DetailImageView ()
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property UIImage* originalImage;
@end

@implementation DetailImageView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.theImage.image = self.imageToAssign;
    self.theImage.contentMode = UIViewContentModeScaleAspectFit;
    
    self.originalImage = self.theImage.image;
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.center = CGPointMake(380, 880);
    self.spinner.hidesWhenStopped = YES;
    CGAffineTransform transform = CGAffineTransformMakeScale(1.5f, 1.5f);
    self.spinner.transform = transform;
    [self.view addSubview:self.spinner];
}

- (IBAction)revertToOriginalImage:(id)sender {
    self.theImage.image = self.originalImage;
}

- (IBAction)filterSepia:(id)sender {
    [self.spinner startAnimating];
    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
    
    dispatch_async(queue, ^{
        
        CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(self.originalImage)];
        CIContext *context = [CIContext contextWithOptions:nil];
        CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, beginImage, nil];
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.theImage.image = [UIImage imageWithCGImage:cgimg];
            CGImageRelease(cgimg);
            [self.spinner stopAnimating];
        });
    });
    
}

- (IBAction)filterMono:(id)sender {
    [self.spinner startAnimating];
    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
    
    dispatch_async(queue, ^{
        
        CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(self.originalImage)];
        CIContext *context = [CIContext contextWithOptions:nil];
        CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectMono" keysAndValues: kCIInputImageKey, beginImage, nil];
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.theImage.image = [UIImage imageWithCGImage:cgimg];
            CGImageRelease(cgimg);
            [self.spinner stopAnimating];
        });
    });
}

- (IBAction)filterVignette:(id)sender {
    [self.spinner startAnimating];
    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
    
    dispatch_async(queue, ^{
        
        CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(self.originalImage)];
        CIContext *context = [CIContext contextWithOptions:nil];
        
        float imageHeight = self.theImage.image.size.height;
        float imageWidth = self.theImage.image.size.width;
        
        CIFilter *filter = [CIFilter filterWithName:@"CIVignetteEffect" keysAndValues: kCIInputImageKey, beginImage, kCIInputCenterKey, [CIVector vectorWithX:imageWidth/2 Y:imageHeight/2], nil];
        [filter setValue:[NSNumber numberWithFloat:imageWidth/2.1] forKey:kCIInputRadiusKey];
        
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.theImage.image = [UIImage imageWithCGImage:cgimg];
            CGImageRelease(cgimg);
            [self.spinner stopAnimating];
        });
    });
}

- (IBAction)filterChrome:(id)sender {
    [self.spinner startAnimating];
    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
    
    dispatch_async(queue, ^{
        
        CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(self.originalImage)];
        CIContext *context = [CIContext contextWithOptions:nil];
        CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectChrome" keysAndValues: kCIInputImageKey, beginImage, nil];
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.theImage.image = [UIImage imageWithCGImage:cgimg];
            CGImageRelease(cgimg);
            [self.spinner stopAnimating];
        });
    });
}

- (IBAction)filterInvert:(id)sender {
    [self.spinner startAnimating];
    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
    
    dispatch_async(queue, ^{
        
        CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(self.originalImage)];
        CIContext *context = [CIContext contextWithOptions:nil];
        CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert" keysAndValues: kCIInputImageKey, beginImage, nil];
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.theImage.image = [UIImage imageWithCGImage:cgimg];
            CGImageRelease(cgimg);
            [self.spinner stopAnimating];
        });
    });
}

- (IBAction)filterPixellate:(id)sender {
    [self.spinner startAnimating];
    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
    
    dispatch_async(queue, ^{
        
        CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(self.originalImage)];
        CIContext *context = [CIContext contextWithOptions:nil];
        CIFilter *filter = [CIFilter filterWithName:@"CIPixellate" keysAndValues: kCIInputImageKey, beginImage, nil];
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.theImage.image = [UIImage imageWithCGImage:cgimg];
            CGImageRelease(cgimg);
            [self.spinner stopAnimating];
        });
    });
}

- (IBAction)filterDotScreen:(id)sender {
    
    [self.spinner startAnimating];
    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
    
    dispatch_async(queue, ^{
        
        CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(self.originalImage)];
        CIContext *context = [CIContext contextWithOptions:nil];
        CIFilter *filter = [CIFilter filterWithName:@"CIDotScreen" keysAndValues: kCIInputImageKey, beginImage, nil];
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.theImage.image = [UIImage imageWithCGImage:cgimg];
            CGImageRelease(cgimg);
            [self.spinner stopAnimating];
        });
    });
    
}

@end
