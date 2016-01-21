//
//  tutorialScreenView.m
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-08-18.
//  Copyright (c) 2015 Queen's University. All rights reserved.
//

#import "tutorialScreenView.h"
#import "AppDelegate.h"

@interface tutorialScreenView ()

@end

@implementation tutorialScreenView

@synthesize title, img, descrip, pgIndex, titleLbl, descripLbl, imgView, mainDescripLbl2, mainDescripLbl3, doneBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Populate the contents - contents may differ for the eng specific and the regular
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (pgIndex == 0)  // Very main screen - same for both
    {
        titleLbl.hidden = YES;
        descripLbl.hidden = YES;
        imgView.hidden = YES;
        doneBtn.hidden = YES;
    }
    else if (pgIndex == 1)  // Dashboard screen - differernt for both
    {
        if ([delegate.userTypeActive isEqualToString:@"engineering"]) {
            titleLbl.text = @"Dashboard";
            descripLbl.text = @"See whats most important to you. Viewing your schedule has never been this easy before. With color coded courses and the timeline, you'll never miss a class";
            imgView.image = [UIImage imageNamed:@"Dash.png"];
        }
        else
        {
            titleLbl.text = @"Dashboard";
            descripLbl.text = @"With color coded courses and the timeline, you'll never miss a class. Not to mention that QTap adds your schedule to your local calendar, allowing you to view your schedule on all your Apple devices";
            imgView.image = [UIImage imageNamed:@"dashOtherStudents.png"];
        }
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        doneBtn.hidden = YES;
        
    }
    else if (pgIndex == 2)
    {
        titleLbl.text = @"Buildings";
        descripLbl.text = @"View all your favorite on campus food services and academic buildings and related information such as their bio/hours, location and address";
        imgView.image = [UIImage imageNamed:@"Campus1.png"];
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        doneBtn.hidden = YES;
        
    }
    else if (pgIndex == 3)
    {
        titleLbl.text = @"Buildings";
        descripLbl.text = @"QTap monitors your location, making it easy for you to see whats nearby";
        imgView.image = [UIImage imageNamed:@"Campus3.png"];
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        doneBtn.hidden = YES;
        
    }
    else if (pgIndex == 4)
    {
        titleLbl.text = @"Buildings";
        descripLbl.text = @"Open up a service/building using either the Map annotations or by clicking on it in the table.\nThe choice is yours";
        imgView.image = [UIImage imageNamed:@"CampusPic4.png"];
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        doneBtn.hidden = YES;
    }
    else if (pgIndex == 5)
    {
        titleLbl.text = @"Buildings";
        descripLbl.text = @"Can't seem to find that food service or building?\nQtap has you covered";
        imgView.image = [UIImage imageNamed:@"Campus2.png"];
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        doneBtn.hidden = YES;
    }
    else if (pgIndex == 6)
    {
        titleLbl.text = @"Buildings";
        descripLbl.text = @"Pop open the building options to change filters and various settings";
        imgView.image = [UIImage imageNamed:@"Filters.png"];
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        doneBtn.hidden = YES;
    }
    else if (pgIndex == 7)
    {
        if ([delegate.userTypeActive isEqualToString:@"engineering"])
        {
            titleLbl.text = @"Homework";
            descripLbl.text = @"Recieve updated weekly homework, pulled from the web. Never miss another assignment again";
            imgView.image = [UIImage imageNamed:@"Homework.png"];
        }
        else
        {
            titleLbl.text = @"Resources";
            descripLbl.text = @"All the resource you'll need in one place. View all the important phone and email addresses you'll need as well as easily access common websites from the app";
            imgView.image = [UIImage imageNamed:@"resReg.png"];
        }
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        doneBtn.hidden = YES;
    }
    else if (pgIndex == 8)
    {
        if ([delegate.userTypeActive isEqualToString:@"engineering"])
        {
            titleLbl.text = @"Settings";
            descripLbl.text = @"All your resources and settings in one convienient place";
            imgView.image = [UIImage imageNamed:@"SettingsEng.png"];
        }
        else
        {
            titleLbl.text = @"Settings";
            descripLbl.text = @"Access and change settings for the app with ease";
            imgView.image = [UIImage imageNamed:@"settingsOtherStudents.png"];
        }
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        doneBtn.hidden = YES;
    }
    else if (pgIndex == 9)
    {
        if ([delegate.userTypeActive isEqualToString:@"engineering"])
        {
            titleLbl.text = @"Settings";
            descripLbl.text = @"Change your section and semester with ease\nBe sure to change to the winter semester when that time rolls around, but the only thing you should be worried about now is climbing the pole";
            imgView.image = [UIImage imageNamed:@"settingsEng2.png"];
        }
        else
        {
            titleLbl.text = @"Settings";
            descripLbl.text = @"Be sure to select your faculty. This will change the theming option of the app to reflect your faculty colors";
            imgView.image = [UIImage imageNamed:@"settingsRegChangeFaculty.png"];
        }
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        doneBtn.hidden = YES;
    }
    else if (pgIndex == 10)
    {
        titleLbl.hidden = YES;
        descripLbl.text = @"We think you're gonna love the app\n\nWelcome to QTap!";
        imgView.hidden = YES;
        mainDescripLbl2.hidden = YES;
        mainDescripLbl3.hidden = YES;
        doneBtn.hidden = NO;
    }
}

- (IBAction)btnAction:(id)sender
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([delegate.userTypeActive isEqualToString:@"engineering"]) {
        [self performSegueWithIdentifier:@"goToEngineer" sender:self];
    }
    else
        //delegate.loginTutorialPassed = @"YES";

        [self performSegueWithIdentifier:@"goToMainApp" sender:self];

    
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
