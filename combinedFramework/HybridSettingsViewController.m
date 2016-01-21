//
//  HybridSettingsViewController.m
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-08-11.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import "HybridSettingsViewController.h"
#import "HybridSettingsTableViewController.h"

@interface HybridSettingsViewController ()

@end

@implementation HybridSettingsViewController
@synthesize submitSettings, containerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Called when user selected a cell either search cell or regular and the specific cell "sub-view" needs to be pushed
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"settingsTableView"])
    {
        NSLog(@"YES");
    }
}

- (IBAction)confirmAndExit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Call to re-update location and cells
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateLoc" object:nil];

}

- (void) displayContentController: (UIViewController*) content
{
    [self addChildViewController:content];
       [content didMoveToParentViewController:self];
}
@end
