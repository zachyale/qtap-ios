//
//  TutorialController.h
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-08-18.
//  Copyright (c) 2015 Queen's University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property(nonatomic, strong) UIPageViewController *pageView;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *descriptions;

@end
