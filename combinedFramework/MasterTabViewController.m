//
//  MasterTabViewController.m
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-03-22.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import "MasterTabViewController.h"
#import "AppDelegate.h"

@interface MasterTabViewController ()

@end

@implementation MasterTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    // Configure the tab bar
    // Customize the tab bar icons
    
    UITabBarController* tabBarController = self;
    
    UITabBar *tabBar = tabBarController.tabBar;
    
    NSMutableArray *tabbarViewControllers = [NSMutableArray arrayWithArray: [tabBarController viewControllers]];
    
    //Remove unnecesarry tabs, Engineering
    if ([delegate.userTypeActive isEqualToString:@"engineering"]) {
        //tabBarItem3.enabled = false;
        //tabBarItem4.enabled = false;
        [tabbarViewControllers removeObjectAtIndex: 3];
        [tabBarController setViewControllers: tabbarViewControllers ];
        [tabbarViewControllers removeObjectAtIndex: 3];
        [tabBarController setViewControllers: tabbarViewControllers ];
    }
    
    //Remove unnecesarry tabs, Non-Engineering
    if ([delegate.userTypeActive isEqualToString:@"non-engineering"]) {
        
        [tabbarViewControllers removeObjectAtIndex: 2];
        [tabBarController setViewControllers: tabbarViewControllers ];
        [tabbarViewControllers removeObjectAtIndex: 4];
        [tabBarController setViewControllers: tabbarViewControllers ];
    }
    
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    
    //Customize tab bar icons, Engineering
    if ([delegate.userTypeActive isEqualToString:@"engineering"]) {
        tabBarItem1.selectedImage = [UIImage imageNamed:@"DashboardIcon-Filled"];
        tabBarItem2.selectedImage = [UIImage imageNamed:@"BuildingsIcon-Filled"];
        tabBarItem3.selectedImage = [UIImage imageNamed:@"HomeworkIcon-Filled"];
        //More tab is default
    }
    
    //Customize tab bar icons, Non-Engineering
    if ([delegate.userTypeActive isEqualToString:@"non-engineering"]) {
        tabBarItem1.selectedImage = [UIImage imageNamed:@"DashboardIcon-Filled"];
        tabBarItem2.selectedImage = [UIImage imageNamed:@"BuildingsIcon-Filled"];
        tabBarItem3.selectedImage = [UIImage imageNamed:@"ResourcesIcon-Filled"];
        tabBarItem4.selectedImage = [UIImage imageNamed:@"SettingsIcon-Filled"];
    }
    
    if (delegate.applicationDefaultCheck == nil) {
        delegate.applicationDefaultCheck = @"FALSE";
    }
    
    if ([delegate.applicationDefaultCheck isEqualToString:@"FALSE"]) {
        //Make magic
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
