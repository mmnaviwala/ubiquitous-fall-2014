//
//  Team3ModelController.m
//  Calculator
//
//  Created by James Garcia on 9/13/14.
//  Copyright (c) 2014 Team3. All rights reserved.
//

#import "Team3ModelController.h"

#import "Team3DataViewController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

@interface Team3ModelController()
@property (readonly, strong, nonatomic) NSArray *pageData;
@end

@implementation Team3ModelController

- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
        //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        _pageData = @[@"Basic",@"Scientific",@"Hex",@"Matrix",@"Unit",];
    }
    return self;
}

- (Team3DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{   
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    if (index == 0) {
        Team3DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"Basic"];
        dataViewController.dataObject = self.pageData[index];
        return dataViewController;
    }
    
    if (index == 1) {
        Team3DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"Scientific"];
        dataViewController.dataObject = self.pageData[index];
        return dataViewController;
    }
    if (index == 2) {
        Team3DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"Hex"];
        dataViewController.dataObject = self.pageData[index];
        return dataViewController;
    }
    if (index == 3) {
        Team3DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"Matrix"];
        dataViewController.dataObject = self.pageData[index];
        return dataViewController;
    }
    if (index == 4) {
        Team3DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"Unit"];
        dataViewController.dataObject = self.pageData[index];
        return dataViewController;
    }
    
    // Create a new view controller and pass suitable data.
    Team3DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"Team3DataViewController"];
    dataViewController.dataObject = self.pageData[index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(Team3DataViewController *)viewController
{   
     // Return the index of the given data view controller.
     // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(Team3DataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(Team3DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
