//
//  Team3ModelController.h
//  Calculator
//
//  Created by James Garcia on 9/13/14.
//  Copyright (c) 2014 Team3. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Team3DataViewController;

@interface Team3ModelController : NSObject <UIPageViewControllerDataSource>

- (Team3DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(Team3DataViewController *)viewController;

@end
