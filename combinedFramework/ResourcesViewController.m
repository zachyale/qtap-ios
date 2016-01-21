//
//  ResourcesViewController.m
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-03-21.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import "ResourcesViewController.h"
#import "DashNavigationController.h"
#import "AppDelegate.h"
#import "HomeworkViewController.h"
#import "buildingsTableViews.h"
#import "settingsViewControllerPrime.h"
@interface ResourcesViewController()
{
    NSArray *fallArray;
    NSArray *winterArray;
    NSArray *facultyArray;
}
@end

@implementation ResourcesViewController
// Initialize all the required UI elements
@synthesize semesterLabel, sectionLabel, facultyLabel, semesterCell, sectionCell, facultyCell, sectLbl, btnSect, sectPicker, segSemesterControl, facultyPicker, lblNetID, lblFirstSync;

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self navBarColorSet];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.facultyActive == nil) {
        delegate.facultyActive = @"Applied Science";
    }
    
    // Populate the account info
    lblNetID.text = delegate.userNetID;
    lblFirstSync.text = delegate.userLoginDate;
    // Set the notification for log out
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkLogOffProgress:) name:@"checkLogOffProcess" object:nil];
    
    //Specify a fall and winter array with the corresponding sections
    //LATER IT WOULD BE USEFUL TO INCLUDE THIS AS A RANGE IN THE .PLIST/WEB VIEW TO REMOVE THIS CODE AND AUTOMIZE
    fallArray = [[NSArray alloc]initWithObjects:@"00",@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", nil];

    winterArray = [[NSArray alloc]initWithObjects:@"00",@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"J", nil];
    
    //Faculty array
    facultyArray = [[NSArray alloc]initWithObjects:@"Applied Science", @"Arts and Science", @"School of Business", @"School of Music", @"School of Computing", @"Fine Arts", @"School of Nursing", @"Kinesology and Health Sciences", @"Faculty of Education", nil];
    
    semesterLabel.text = delegate.semesterActive;
    sectionLabel.text = delegate.sectionActive;
    facultyLabel.text = delegate.facultyActive;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void) viewDidAppear:(BOOL)animated {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // The labels have to reloaded every time
    semesterLabel.text = delegate.semesterActive;
    sectionLabel.text = delegate.sectionActive;
    facultyLabel.text = delegate.facultyActive;
    // Set proper nav bar color
    [self navBarColorSet];
    
}

- (IBAction)facSelector:(id)sender
{
    //Get the users faculty
    NSString *facSelected = [[NSString alloc] init];
    facSelected = [facultyArray objectAtIndex:[facultyPicker selectedRowInComponent:0]];
    //Save it in the App delegate
    
    //Create an instance of the app delegate
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.facultyActive = facSelected;
    [self navBarColorSet];
    
}

- (UIView *)  tableView:(UITableView *)tableView
 viewForFooterInSection:(NSInteger)section{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIView *result = nil;
    
        if ([tableView isEqual:self.tableView] && section == 1 && [self.restorationIdentifier isEqualToString:@"settingsViewNE"]){
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.text = @"Made with ❤︎ in Kingston, ON";
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        [label setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:14.0]];
        
        
        /* Move the label 10 points to the right */
        label.frame = CGRectMake(label.frame.origin.x + 15.0f,
                                 5.0f, /* Go 5 points down in y axis */
                                 label.frame.size.width,
                                 label.frame.size.height);
        
        
        /* Give the container view 10 points more in width than our label
         because the label needs a 10 extra points left-margin */
        CGRect resultFrame = CGRectMake(0.0f,
                                        0.0f,
                                        label.frame.size.width + 10.0f,
                                        label.frame.size.height + 20.0f);
        result = [[UIView alloc] initWithFrame:resultFrame];
        [result addSubview:label];
        tableView.tableFooterView = result;
    }
    
    return result;
    
}

- (void) navBarColorSet {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //Change the colors correspondingly
    if([delegate.facultyActive isEqualToString:@"Applied Science"]) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(91/255.0) green:(35/255.0) blue:(180/255.0) alpha:1.0];
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:(91/255.0) green:(35/255.0) blue:(180/255.0) alpha:1.0]];
    }
    else if ([delegate.facultyActive isEqualToString:@"Arts and Science"]) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.35 green:0.34 blue:0.84 alpha:1.0];
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.35 green:0.34 blue:0.84 alpha:1.0]];
    }
    else if ([delegate.facultyActive isEqualToString:@"School of Business"])
    {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.00 green:0.18 blue:0.33 alpha:1.0];
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:1.00 green:0.18 blue:0.33 alpha:1.0]];
    }
    else if ([delegate.facultyActive isEqualToString:@"School of Music"]) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.0];
        [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.0]];
    }
    else if ([delegate.facultyActive isEqualToString:@"School of Computing"]) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.30 green:0.85 blue:0.39 alpha:1.0];
        [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:0.30 green:0.85 blue:0.39 alpha:1.0]];
    }
    else if ([delegate.facultyActive isEqualToString:@"School of Nursing"])   {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.00 green:0.18 blue:0.33 alpha:1.0];
        [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:1.00 green:0.18 blue:0.33 alpha:1.0]];
    }
    else if ([delegate.facultyActive isEqualToString:@"Kinesology and Health Sciences"]){
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.35 green:0.34 blue:0.84 alpha:1.0];
        [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:0.35 green:0.34 blue:0.84 alpha:1.0]];
    }
    else if ([delegate.facultyActive isEqualToString:@"Fine Arts"]) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(122/255.0) green:(122/255.0) blue:(128/255.0) alpha:1.0];
        [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:0.78 green:0.78 blue:0.80 alpha:1.0]];
    }
    else if ([delegate.facultyActive isEqualToString:@"Faculty of Education"]){
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(122/255.0) green:(122/255.0) blue:(128/255.0) alpha:1.0];
        [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:0.78 green:0.78 blue:0.80 alpha:1.0]];
    }
}

//The actions that will redirect users to safari for the specific link
- (IBAction)wolframLink:(id)sender
{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.wolframalpha.com"]];
}

- (IBAction)outlookLink:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.outlook.com/owa/queensu.ca"]];
}

- (IBAction)goBackToStart:(id)sender {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // Redirect users to settings
    if (delegate.didLogOffNonEng == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Calendar" message:@"Before logging out you must delete the calendar created to store your schedule. You will now be redirected to the QTap iPhone Settings. Please go into the Mail, Contacts and Calendar section of the settings and select your NETID Class Schedule calendar and delete it. Once complete please return to the app to finish log off" delegate:self cancelButtonTitle:@"Go" otherButtonTitles:nil];
        [alert show];
        delegate.didLogOffNonEng = @"IN PROGRESS";
    }
    else if ([delegate.didLogOffNonEng isEqualToString:@"IN PROGRESS"])
    {
        // This will occur once the user has come back to the app
        // Check if the user deleted the calendar
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        EKEntityType type = EKEntityTypeEvent;
        NSArray *calArry = [eventStore calendarsForEntityType:type];
        BOOL hasDeleted = YES;
        // Now find the just created subscribed one
        for (int i = 0; i < calArry.count; i++) {
            EKCalendar *curCal = [calArry objectAtIndex:i];
            if (curCal.type == EKCalendarTypeSubscription) {
                if ([curCal.title rangeOfString:@"Class Schedule"].location != NSNotFound) {
                    NSLog(@"User still has not deleted calendar");
                    hasDeleted = NO;
                    break;
                }
            }
        }
        
        // Check the current condition of log off
        if (hasDeleted == NO) {
            // Alert
            UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"The Class Calendar is still present. Please go back to the Mail, Contacts and Calendar settings and delete the subscribed NETID Class Schedule" delegate:self cancelButtonTitle:@"Go" otherButtonTitles:@"Remain Logged In", nil];
            [alert2 show];
        }
        else
        {
            // Calendar deleted and now we can log off
            delegate.didLogOffNonEng = @"YES";
            delegate.loginTutorialPassed = @"NO";
            UIViewController *viewCont = [[UIViewController alloc]init];
            viewCont = [self.storyboard instantiateViewControllerWithIdentifier:@"loginTutorialInitialView"];
            delegate.window.rootViewController = viewCont;
            [delegate.window makeKeyAndVisible];
        }
    }
        
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // Both alerts redirect to settings
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
    else
    {
        // This is for the "Remain Logged In"
        delegate.didLogOffNonEng = nil;
    }
}

- (void) checkLogOffProgress: (NSNotification *)notif
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([delegate.didLogOffNonEng isEqualToString:@"IN PROGRESS"])
    {
        // This will occur once the user has come back to the app
        // Check if the user deleted the calendar
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        EKEntityType type = EKEntityTypeEvent;
        NSArray *calArry = [eventStore calendarsForEntityType:type];
        BOOL hasDeleted = YES;
        // Now find the just created subscribed one
        for (int i = 0; i < calArry.count; i++) {
            EKCalendar *curCal = [calArry objectAtIndex:i];
            if (curCal.type == EKCalendarTypeSubscription) {
                if ([curCal.title rangeOfString:@"Class Schedule"].location != NSNotFound) {
                    NSLog(@"User still has not deleted calendar");
                    hasDeleted = NO;
                    break;
                }
            }
        }
        
        // Check the current condition of log off
        if (hasDeleted == NO) {
            // Alert
            UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"The Class Calendar is still present. Please go back to the Mail, Contacts and Calendar settings and delete the subscribed NETID Class Schedule" delegate:self cancelButtonTitle:@"Go" otherButtonTitles:@"Remain Logged In", nil];
            [alert2 show];
        }
        else
        {
            // Calendar deleted and now we can log off
            delegate.didLogOffNonEng = @"YES";
            delegate.loginTutorialPassed = @"NO";
            UIViewController *viewCont = [[UIViewController alloc]init];
            viewCont = [self.storyboard instantiateViewControllerWithIdentifier:@"loginTutorialInitialView"];
            delegate.window.rootViewController = viewCont;
            [delegate.window makeKeyAndVisible];
        }
        
    }
}


- (IBAction)moodleLink:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://moodle.queensu.ca"]];
}

- (IBAction)solusLink:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://my.queensu.ca/"]];
}

- (IBAction)d2lLink:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://courses.engineering.queensu.ca"]];
}

- (IBAction)EducationD2LLink:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://d2l.educ.queensu.ca/"]];
}

- (IBAction)onQLink:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://onq.queensu.ca"]];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    if ([[segue identifier] isEqualToString:@"ShowSemester"])
    {
        delegate.settingsIdentifier = @"semester";
    }
    else if ([[segue identifier] isEqualToString:@"ShowSection"])
    {
        delegate.settingsIdentifier = @"section";
    }
    else if ([[segue identifier] isEqualToString:@"ShowFaculty"])
    {
       delegate.settingsIdentifier = @"faculty";
    }
}

@end
