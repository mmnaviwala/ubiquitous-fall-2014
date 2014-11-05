//
//  ViewController.m
//  HW-3
//
//  Created by Muhammad Naviwala on 11/4/14.
//  Copyright (c) 2014 Muhammad Naviwala. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "DetailImageView.h"

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong) NSArray *assets;
@property UIImage *imageToPass;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchAssets];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchAssets];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cameraPushed:(UIBarButtonItem *)sender {
    
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage, (NSString *) kUTTypeMovie];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
        UIView *overLayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        UIImage *overlayGraphic = [UIImage imageNamed:@"Grid.png"];
        UIImageView *overlayGraphicView = [[UIImageView alloc] initWithImage:overlayGraphic];
        overlayGraphicView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [overLayView addSubview:overlayGraphicView];
        imagePicker.cameraOverlayView = overLayView;
        NSLog(@"Screen width:%f, Screen Height:%f", self.view.frame.size.width, self.view.frame.size.height);
    }
}
-(void)reloadCollectionData {
    [self fetchAssets];
    NSLog(@"Reload collection called");
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    
    if ([mediaType isEqualToString:(NSString *) kUTTypeImage]) {
        
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(savedFailed:didFinishSavingWithError:contextInfo:), nil);
        
    }else if ([mediaType isEqualToString:(NSString *) kUTTypeMovie]) {
        
        NSString *sourcePath = [[info objectForKey:@"UIImagePickerControllerMediaURL"] relativePath];
        UISaveVideoAtPathToSavedPhotosAlbum(sourcePath, self, @selector(savedFailed:didFinishSavingWithError:contextInfo:), nil);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) savedFailed:(UIImage*)image didFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo
{
    if (error) {
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:nil
                                   message:@"Save Failed"
                                   delegate:nil
                                   cancelButtonTitle:@"ОК"
                                   otherButtonTitles:nil];
        [errorAlert show];
        NSLog(@"%@", [error localizedDescription]);
    }
    UIAlertView *saveComplete = [[UIAlertView alloc]
                               initWithTitle:@"Success"
                               message:@"Media Saved Successfully"
                               delegate:nil
                               cancelButtonTitle:@"ОК"
                               otherButtonTitles:nil];
    [saveComplete show];
    [self fetchAssets];
    
}



+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}

- (void) fetchAssets
{
    _assets = [@[] mutableCopy];
    __block NSMutableArray *tmpAssets = [@[] mutableCopy];
    ALAssetsLibrary *assetsLibrary = [ViewController defaultAssetsLibrary];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if(result)
            {
                [tmpAssets addObject:result];
            }
        }];
        
        self.assets = tmpAssets;
        
        [self.collectionView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"Error loading images %@", error);
    }];
}

#pragma mark - collection view data source

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = (PhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    ALAsset *asset = self.assets[indexPath.row];
    cell.asset = asset;
    
    return cell;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = self.assets[indexPath.row];
    ALAssetRepresentation *defaultRep = [asset defaultRepresentation];
    UIImage *image = [UIImage imageWithCGImage:[defaultRep fullScreenImage] scale:[defaultRep scale] orientation:0];
    // Do something with the image
    self.imageToPass = image;
    [self performSegueWithIdentifier:@"SegueToDetailImageView" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"SegueToDetailImageView"])
    {
        DetailImageView *transferViewController = segue.destinationViewController;
        transferViewController.imageToAssign = self.imageToPass;
    }
    
}


@end
