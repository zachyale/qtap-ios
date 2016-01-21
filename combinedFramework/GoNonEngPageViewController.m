//
//  GoNonEngPageViewController.m
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-08-21.
//  Copyright (c) 2015 Queen's University. All rights reserved.
//

#import "GoNonEngPageViewController.h"

@interface GoNonEngPageViewController ()

@end

@implementation GoNonEngPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToMainAppNonEng:(id)sender
{
    [self performSegueWithIdentifier:@"goToMainApp" sender:self];
}

@end
