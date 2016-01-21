//
//  tutorialScreensViewController.m
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-06-11.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import "tutorialScreensViewController.h"
#import "AppDelegate.h"

@interface tutorialScreensViewController ()

@end

@implementation tutorialScreensViewController
@synthesize title, img, descrip, pgIndex, titleLbl, descripLbl, imgView, mainTitleLbl, mainDescripLbl1, mainDescripLbl2, mainDescripLbl3, mainImgView, doneBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Populate the contents
    if (pgIndex == 0)  // Very main screen
    {
        titleLbl.hidden = YES;
        descripLbl.hidden = YES;
        imgView.hidden = YES;
        doneBtn.hidden = NO;
    }
    else if (pgIndex == 1)  // Dashboard screen
    {
        titleLbl.text = @"Dashboard";
        descripLbl.text = @"See whats most important to you. Viewing your schedule has never been this easy before. With color coded courses and the timeline, you'll never miss a class";
        imgView.image = [UIImage imageNamed:@"Dash.png"];
        mainTitleLbl.hidden = YES;
        mainDescripLbl1.hidden = YES;
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        mainImgView.hidden = YES;
        doneBtn.hidden = NO;
        
    }
    else if (pgIndex == 2)  // Buildings MAIN screen
    {
        titleLbl.text = @"  Campus";
        descripLbl.text = @"View all your favorite on campus food services and related information such as their hours, location and address";
        imgView.image = [UIImage imageNamed:@"Campus"];
        mainTitleLbl.hidden = YES;
        mainDescripLbl1.hidden = YES;
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        mainImgView.hidden = YES;
        doneBtn.hidden = YES;
        
    }
    else if (pgIndex == 3)  // Buildings screen - Search Screen
    {
        titleLbl.text = @"  Campus";
        descripLbl.text = @"Can't seem to find that food service?\nQtap has you covered";
        imgView.image = [UIImage imageNamed:@"Campus2.png"];
        mainTitleLbl.hidden = YES;
        mainDescripLbl1.hidden = YES;
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        mainImgView.hidden = YES;
        doneBtn.hidden = YES;
        
    }
    else if (pgIndex == 4)  // Buildings screen - actual service
    {
        titleLbl.text = @"  Campus";
        descripLbl.text = @"View all your favorite on campus food services and related information such as their hours, location and address";
        imgView.image = [UIImage imageNamed:@"Campus3.png"];
        mainTitleLbl.hidden = YES;
        mainDescripLbl1.hidden = YES;
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        mainImgView.hidden = YES;
        doneBtn.hidden = YES;
    }
    else if (pgIndex == 5)  // Buildings screen - Open to Map
    {
        titleLbl.text = @"  Campus";
        descripLbl.text = @"Want to get directions to and from any campus building?\nTap on the pin located on the top right hand side";
        imgView.image = [UIImage imageNamed:@"CampusToMap.png"];
        mainTitleLbl.hidden = YES;
        mainDescripLbl1.hidden = YES;
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        mainImgView.hidden = YES;
        doneBtn.hidden = YES;
    }
    else if (pgIndex == 6)  // Buildings screen - Open to Map
    {
        titleLbl.text = @"  Campus";
        descripLbl.text = @"Recieve step by step walking and driving directions";
        imgView.image = [UIImage imageNamed:@"Map.png"];
        mainTitleLbl.hidden = YES;
        mainDescripLbl1.hidden = YES;
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        mainImgView.hidden = YES;
        doneBtn.hidden = YES;
    }
    else if (pgIndex == 7)  // Buildings screen - Open to Map
    {
        titleLbl.text = @" Homework";
        descripLbl.text = @"Recieve updated weekly homework, pulled from the web\nNever miss another assignment again";
        imgView.image = [UIImage imageNamed:@"Homework.png"];
        mainTitleLbl.hidden = YES;
        mainDescripLbl1.hidden = YES;
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        mainImgView.hidden = YES;
        doneBtn.hidden = YES;
    }
    else if (pgIndex == 8)  // Buildings screen - Open to Map
    {
        titleLbl.text = @" Resources";
        descripLbl.text = @"All your resources and settings in one convienient place";
        imgView.image = [UIImage imageNamed:@"ResourcesMain.png"];
        mainTitleLbl.hidden = YES;
        mainDescripLbl1.hidden = YES;
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        mainImgView.hidden = YES;
        doneBtn.hidden = YES;
    }
    else if (pgIndex == 9)  // Buildings screen - Open to Map
    {
        titleLbl.text = @" Resources";
        descripLbl.text = @"All your resources and settings in one convienient place";
        imgView.image = [UIImage imageNamed:@"Resources2.png"];
        mainTitleLbl.hidden = YES;
        mainDescripLbl1.hidden = YES;
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        mainImgView.hidden = YES;
        doneBtn.hidden = YES;
    }
    else if (pgIndex == 10)  // Buildings screen - Open to Map
    {
        titleLbl.text = @" Resources";
        descripLbl.text = @"Select and change sections with ease";
        imgView.image = [UIImage imageNamed:@"Resources3.png"];
        mainTitleLbl.hidden = YES;
        mainDescripLbl1.hidden = YES;
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        mainImgView.hidden = YES;
        doneBtn.hidden = YES;
    }
    else if (pgIndex == 11)  // Buildings screen - Open to Map
    {
        titleLbl.hidden = YES;
        descripLbl.text = @"We think you're gonna love the app\n\nWelcome to QTap!";
        imgView.hidden = YES;
        mainTitleLbl.hidden = YES;
        mainDescripLbl1.hidden = YES;
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        mainImgView.hidden = YES;
        doneBtn.hidden = NO;
    }
}

- (IBAction)btnAction:(id)sender
{
    //When go is hit we need to save a counter that will allow us not to ever see this tutorial again
    NSString *tutorialPass = @"PASSED";
    // Save it in the appdelegate
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.tutorialPassed = tutorialPass;
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
