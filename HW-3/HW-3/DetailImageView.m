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
@property UIBarButtonItem *originalRightBarButton;
@property UIBarButtonItem *originalLeftBarButton;
@property (weak, nonatomic) IBOutlet UIScrollView *imageFiltersScrollView;
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
    self.spinner.backgroundColor = [UIColor whiteColor];
    CGAffineTransform transform = CGAffineTransformMakeScale(1.5f, 1.5f);
    self.spinner.transform = transform;
    [self.view addSubview:self.spinner];
    
    self.originalRightBarButton = self.navigationItem.rightBarButtonItem;
    self.originalLeftBarButton = self.navigationItem.leftBarButtonItem;
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)];
    [pinchRecognizer setDelegate:self];
    [self.theImage addGestureRecognizer:pinchRecognizer];
    
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    [rotationRecognizer setDelegate:self];
    [self.theImage addGestureRecognizer:rotationRecognizer];


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

- (IBAction)imageFiltersButtonTapped:(UIBarButtonItem *)sender {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    self.imageFiltersScrollView.frame = CGRectMake(0, 914, 768, 90);
    [UIView commitAnimations];
    
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveImageAfterFilterIsApplied:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonTapped:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
}

- (void) saveImageAfterFilterIsApplied:(id)sender
{
    UIImageWriteToSavedPhotosAlbum(self.theImage.image, nil, nil, nil);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Image successfully saved to device" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    self.imageFiltersScrollView.frame = CGRectMake(0, 1030, 768, 90);
    [UIView commitAnimations];
    
    self.navigationItem.rightBarButtonItem = self.originalRightBarButton;
    self.navigationItem.leftBarButtonItem = self.originalLeftBarButton;
    
}

- (void) cancelButtonTapped:(id)sender
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    self.imageFiltersScrollView.frame = CGRectMake(0, 1030, 768, 90);
    [UIView commitAnimations];
    
    self.theImage.image = self.originalImage;
    
    self.navigationItem.rightBarButtonItem = self.originalRightBarButton;
    self.navigationItem.leftBarButtonItem = self.originalLeftBarButton;
    
}


# pragma Scale and Rotate

-(void)scale:(id)sender {
    
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _lastScale = 1.0;
    }
    
    CGFloat scale = 1.0 - (_lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    
    CGAffineTransform currentTransform = self.theImage.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
    [self.theImage setTransform:newTransform];
    
    _lastScale = [(UIPinchGestureRecognizer*)sender scale];
    [self showOverlayWithFrame:self.theImage.frame];
}

-(void)rotate:(id)sender {
    
    if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        _lastRotation = 0.0;
        return;
    }
    
    CGFloat rotation = 0.0 - (_lastRotation - [(UIRotationGestureRecognizer*)sender rotation]);
    
    CGAffineTransform currentTransform = self.theImage.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    
    [self.theImage setTransform:newTransform];
    
    _lastRotation = [(UIRotationGestureRecognizer*)sender rotation];
    [self showOverlayWithFrame:self.theImage.frame];
}

-(void)showOverlayWithFrame:(CGRect)frame {
    
    if (![_marque actionForKey:@"linePhase"]) {
        CABasicAnimation *dashAnimation;
        dashAnimation = [CABasicAnimation animationWithKeyPath:@"lineDashPhase"];
        [dashAnimation setFromValue:[NSNumber numberWithFloat:0.0f]];
        [dashAnimation setToValue:[NSNumber numberWithFloat:15.0f]];
        [dashAnimation setDuration:0.5f];
        [dashAnimation setRepeatCount:HUGE_VALF];
        [_marque addAnimation:dashAnimation forKey:@"linePhase"];
    }
    
    _marque.bounds = CGRectMake(frame.origin.x, frame.origin.y, 0, 0);
    _marque.position = CGPointMake(frame.origin.x + canvas.frame.origin.x, frame.origin.y + canvas.frame.origin.y);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, frame);
    [_marque setPath:path];
    CGPathRelease(path);
    
    _marque.hidden = NO;
    
}


@end
