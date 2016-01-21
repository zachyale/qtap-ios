//
//  GoNonEngPageViewController.m
//  combinedFramework
//
//  Created by Zachary Yale and Rony Besprozvanny on 2015-08-21.
//  Copyright (c) 2016 QTap Project. All rights reserved.
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
