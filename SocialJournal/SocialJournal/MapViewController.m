//
//  MapViewController.m
//  SocialJournal
//
//  Created by Matt Phillips on 11/12/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showMapLocation:10.000 :0.000];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) showMapLocation:(double)latitude :(double)longitude {
    
    CLLocationCoordinate2D location;
    location.latitude = latitude;
    location.longitude = longitude;
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = location;
    [self.mapView addAnnotation:annotation];
    //[self.mapView setShowsUserLocation:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
