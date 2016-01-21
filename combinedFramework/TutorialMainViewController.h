//
//  TutorialMainViewController.h
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-06-11.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialMainViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property(nonatomic, strong) UIPageViewController *pageView;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *descriptions;

@end
