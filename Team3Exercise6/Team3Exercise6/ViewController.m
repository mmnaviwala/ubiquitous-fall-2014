//
//  ViewController.m
//  Team3Exercise6
//
//  Created by ubicomp3 on 10/16/14.
//  Copyright (c) 2014 CPL. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *currentImage;
@property (weak, nonatomic) IBOutlet UILabel *indexController;
@property (strong, nonatomic) NSArray *photos;
@property (weak, nonatomic) IBOutlet UIImageView *imageToDisplay;
@property BOOL newMedia;
@end

@implementation ViewController

- (IBAction)cameraButtonPushed:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        self.newMedia = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self fetchPictures];
    self.scrollView.delegate = self;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    int currentIndex = self.scrollView.contentOffset.x / scrollView.frame.size.width;
    self.indexController.text = [NSString stringWithFormat:@"%i of %i", currentIndex+1, [self.photos count]];
    
    
    self.currentImage = [self.photos objectAtIndex:currentIndex];
    NSLog(@"%@", NSStringFromClass([[self.photos objectAtIndex:currentIndex] class]));
    self.imageToDisplay.image = self.currentImage.image;
    [self filterSepia];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES]; 
    [self fetchPictures];
    [self.scrollView setNeedsDisplay];
    
}

- (void)filterSepia {
    CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(self.currentImage.image)];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, beginImage, nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        
    self.currentImage.image = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
}

-(void)fetchPictures{
    NSMutableArray *collector = [[NSMutableArray alloc] initWithCapacity:0];
    ALAssetsLibrary *library = [self defaultAssetsLibrary];
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
            if (asset) {
                // [collector addObject:asset];
                // [self createNewImageView:asset];
                ALAssetRepresentation *rep = [asset defaultRepresentation];
                CGImageRef imageRef = [rep fullResolutionImage];
                if (imageRef) {
                    UIImage *someImage = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:UIImageOrientationUp];
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width * index, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
                    imageView.contentMode = UIViewContentModeScaleAspectFit;
                    imageView.image = someImage;
                    
                    // =============================================
                    // =============================================
                    // =============================================
                    [collector addObject:imageView];
                    
                    [self.scrollView addSubview:imageView];
                }
                
            }
//            NSLog(@"%i", index);
        }];
        self.photos = [collector copy];
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [self.photos count], self.scrollView.frame.size.height);
        // self.indexController.text = [NSString stringWithFormat:@"%ld", (long)[self.photos count ]];
        //        [self.view setNeedsDisplay];`
    }failureBlock:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ALAssetsLibrary *) defaultAssetsLibrary {
    static dispatch_once_t predicate = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&predicate, ^{
        library = [[ALAssetsLibrary alloc]init]; });
    return library;
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
//        self.currentImage.image = image;
        NSLog(@"HOLA!");
        if (self.newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
