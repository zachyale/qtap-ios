//
//  GoEngPageViewController.m
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-08-21.
//  Copyright (c) 2015 Queen's University. All rights reserved.
//

#import "GoEngPageViewController.h"

@interface GoEngPageViewController ()

@end

@implementation GoEngPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToMainApp:(id)sender
{
    // Delegate already set to enginering when they hit the 1st year engineer button
    [self performSegueWithIdentifier:@"goToEngineer" sender:self];
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
