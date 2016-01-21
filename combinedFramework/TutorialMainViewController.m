//
//  TutorialMainViewController.m
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-06-11.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import "TutorialMainViewController.h"
#import "tutorialScreensViewController.h"

@interface TutorialMainViewController ()

@end

@implementation TutorialMainViewController
@synthesize pageView, titles, images, descriptions;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    titles = [[NSArray alloc]initWithObjects:@"1", @"2", @"3", @"",@"4",@"5",@"6",@"7", @"8",@"9",@"10",@"11", nil];
    self.pageView = [self.storyboard instantiateViewControllerWithIdentifier:@"PageController"];
    self.pageView.dataSource = self;
    tutorialScreensViewController *tutScreens = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[tutScreens];
    [self.pageView setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:pageView];
    [self.view addSubview:pageView.view];
    [self.pageView didMoveToParentViewController:self];
    
}

- (tutorialScreensViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.titles count] == 0) || (index >= [self.titles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    tutorialScreensViewController *tutViews = [self.storyboard instantiateViewControllerWithIdentifier:@"tutorialScreen"];
    //tutViews.img = self.images[index];
    //tutViews.title = self.titles[index];
    tutViews.pgIndex = index;
    
    return tutViews;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Page Controller
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((tutorialScreensViewController *) viewController).pgIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((tutorialScreensViewController*) viewController).pgIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.titles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCount:(UIPageViewController *)pageViewController
{
    return [self.titles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
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
