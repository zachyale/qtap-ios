//
//  AppDelegate.m
//  combinedFramework
//
//  Created by Zachary Yale on 2015-03-19.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import "AppDelegate.h"
#import "DashViewController.h"
#import "HomeworkViewController.h"
#import "ResourcesViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *viewCont = [[UIViewController alloc]init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Check if they were logged on as eng from last time
    // Override point for customization after application launch
    self.sectionActive = [defaults objectForKey:@"section"];
    self.semesterActive = [defaults objectForKey:@"semester"];
    self.facultyActive = [defaults objectForKey:@"faculty"];
    self.settingsIdentifier = [defaults objectForKey:@"settings"];
    self.userTypeActive = [defaults objectForKey:@"userTypeActive"];
    self.applicationDefaultCheck = [defaults objectForKey:@"userTypeActive"];
    self.loginTutorialPassed = [defaults objectForKey:@"loginTutorialPassed"];
    self.userNetID = [defaults objectForKey:@"userNetID"];
    self.userLoginDate = [defaults objectForKey:@"userLoginDate"];
    self.didLogOffNonEng = [defaults objectForKey:@"didLogOffNonEng"];
    self.didPassEATutorial = [defaults objectForKey:@"didPassEATutorial"];
    self.shouldUpdateWebpage = [defaults objectForKey:@"shouldUpdateWebpage"];
    self.closedAppResourceIndicator = [defaults objectForKey:@"closedAppResourceIndicator"];


    if (!(self.sectionActive == nil || [self.sectionActive isEqualToString:@""]) && [self.userTypeActive isEqualToString:@"engineering"]) {
        //Previous version loaded before and they were set as an eng
        // Push them to tutorial again
        self.sectionActive = @"";
        self.loginTutorialPassed = @"NO";
        //viewCont = [storyboard instantiateViewControllerWithIdentifier:@"loginTutorialInitialView"];
        // Inform user of new change
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Change" message:@"With this new update, your engineering schedule will now be taken from SOLUS. Please login to SOLUS using the '1st Year Button. Have a great semester.'" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }
    // Check the tutorial progress and load up corresponding view
    if ([self.loginTutorialPassed isEqualToString:@"YES"]) {
        viewCont = [storyboard instantiateViewControllerWithIdentifier:@"mainViewApp"];
    }
    else
    {
        // THE LOGINTUTORIALINITIALVIEW STORYBOARD ID CORRESPONDS TO THE LOGIN VIEW
        // WHEN REPLACING WITH THE NEW STORYBOARD FILE USE SAME ID OR UPDATE THIS LINE TO REFLECT CHANGE
        viewCont = [storyboard instantiateViewControllerWithIdentifier:@"loginTutorialInitialView"];
    }

    self.window.rootViewController = viewCont;
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    

    //Default nav bar colour
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:(91/255.0) green:(35/255.0) blue:(180/255.0) alpha:1.0]];
    
    //Change the colors correspondingly
    if([self.facultyActive isEqualToString:@"Applied Science"]) {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:(91/255.0) green:(35/255.0) blue:(180/255.0) alpha:1.0]];
    }
    else if ([self.facultyActive isEqualToString:@"Arts and Science"]) {
            [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.35 green:0.34 blue:0.84 alpha:1.0]];
    }
    else if ([self.facultyActive isEqualToString:@"School of Business"])
    {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:1.00 green:0.18 blue:0.33 alpha:1.0]];
    }
    else if ([self.facultyActive isEqualToString:@"School of Music"]) {
        [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.0]];
    }
    else if ([self.facultyActive isEqualToString:@"School of Computing"]) {
        [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:0.30 green:0.85 blue:0.39 alpha:1.0]];
    }
    else if ([self.facultyActive isEqualToString:@"School of Nursing"])   {
        [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:1.00 green:0.18 blue:0.33 alpha:1.0]];
    }
    else if ([self.facultyActive isEqualToString:@"Kinesology and Health Sciences"]){
        [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:0.35 green:0.34 blue:0.84 alpha:1.0]];
    }
    else if ([self.facultyActive isEqualToString:@"Fine Arts"]) {
        [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:(122/255.0) green:(122/255.0) blue:(128/255.0) alpha:1.0]];
    }
    else if ([self.facultyActive isEqualToString:@"Faculty of Education"]){
        [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:(122/255.0) green:(122/255.0) blue:(128/255.0) alpha:1.0]];
    }
    
    self.closedAppResourceIndicator = @"NEW";
    
    NSString *section = self.sectionActive;
    NSString *semester = self.semesterActive;
    NSString *faculty = self.facultyActive;
    NSString *tutorialPass = self.loginTutorialPassed;
    NSString *buildingSettingFilter = self.buildingSettingFilter;
    NSString *buildingSettingsNearbyConfig = self.buildingSettingsNearbyConfig;
    NSString *buildingSettingsRange = self.buildingSettingsRange;
    NSString *userTypeActive = self.userTypeActive;
    NSString *userNetID = self.userNetID;
    NSString *userLoginDate = self.userLoginDate;
    NSString *didLogOffNonEng = self.didLogOffNonEng;
    NSString *didPassEATutorial = self.didPassEATutorial;
    NSString *shouldUpdateWebpage = self.shouldUpdateWebpage;
    NSString *closedAppResourceIndicator = self.closedAppResourceIndicator;
    
    [defaults setObject:section forKey:@"section"];
    [defaults setObject:semester forKey:@"semester"];
    [defaults setObject:faculty forKey:@"faculty"];
    [defaults setObject:tutorialPass forKey:@"loginTutorialPassed"];
    [defaults setObject:userTypeActive forKey:@"userTypeActive"];
    [defaults setObject:buildingSettingFilter forKey:@"buildingSettingFilter"];
    [defaults setObject:buildingSettingsNearbyConfig forKey:@"buildingSettingsNearbyConfig"];
    [defaults setObject:buildingSettingsRange forKey:@"buildingSettingsRange"];
    [defaults setObject:userNetID forKey:@"userNetID"];
    [defaults setObject:userLoginDate forKey:@"userLoginDate"];
    [defaults setObject:didLogOffNonEng forKey:@"didLogOffNonEng"];
    [defaults setObject:didPassEATutorial forKey:@"didPassEATutorial"];
    [defaults setObject:shouldUpdateWebpage forKey:@"shouldUpdateWebpage"];
    [defaults setObject:closedAppResourceIndicator forKey:@"closedAppResourceIndicator"];
    
    
    [defaults synchronize];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSString *section = self.sectionActive;
    NSString *semester = self.semesterActive;
    NSString *faculty = self.facultyActive;
    NSString *tutorialPass = self.loginTutorialPassed;
    NSString *buildingSettingFilter = self.buildingSettingFilter;
    NSString *buildingSettingsNearbyConfig = self.buildingSettingsNearbyConfig;
    NSString *buildingSettingsRange = self.buildingSettingsRange;
    NSString *userTypeActive = self.userTypeActive;
    NSString *userNetID = self.userNetID;
    NSString *userLoginDate = self.userLoginDate;
    NSString *didLogOffNonEng = self.didLogOffNonEng;
    NSString *didPassEATutorial = self.didPassEATutorial;
    NSString *shouldUpdateWebpage = self.shouldUpdateWebpage;
    NSString *closedAppResourceIndicator = self.closedAppResourceIndicator;


    NSString *didSave = @"YES";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:section forKey:@"section"];
    [defaults setObject:semester forKey:@"semester"];
    [defaults setObject:faculty forKey:@"faculty"];
    [defaults setObject:didSave forKey:@"didSave"];
    [defaults setObject:tutorialPass forKey:@"loginTutorialPassed"];
    [defaults setObject:userTypeActive forKey:@"userTypeActive"];
    [defaults setObject:buildingSettingFilter forKey:@"buildingSettingFilter"];
    [defaults setObject:buildingSettingsNearbyConfig forKey:@"buildingSettingsNearbyConfig"];
    [defaults setObject:buildingSettingsRange forKey:@"buildingSettingsRange"];
    [defaults setObject:userNetID forKey:@"userNetID"];
    [defaults setObject:userLoginDate forKey:@"userLoginDate"];
    [defaults setObject:didLogOffNonEng forKey:@"didLogOffNonEng"];
    [defaults setObject:didPassEATutorial forKey:@"didPassEATutorial"];
    [defaults setObject:shouldUpdateWebpage forKey:@"shouldUpdateWebpage"];
    [defaults setObject:closedAppResourceIndicator forKey:@"closedAppResourceIndicator"];



    [defaults synchronize];

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // Here is where we have to reload the table view in the buildings
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateLoc" object:nil];
    // Here is what will update the Solus login if previous load failed
    if (![self.shouldUpdateWebpage isEqualToString:@"NO"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadWebpage" object:nil];
    }
        if ([self.didLogOffNonEng isEqualToString:@"IN PROGRESS"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"checkLogOffProcess" object:nil];
        }
    //}
}

- (void) goBackToMainScreen
{
    NSLog(@"HELLO");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //Data must be saved here but in specific it is just the string of the section and semester that needs to be saved
    NSString *closedAppResourceIndicator = self.closedAppResourceIndicator;
    NSString *section = self.sectionActive;
    NSString *semester = self.semesterActive;
    NSString *faculty = self.facultyActive;
    NSString *tutorialPass = self.loginTutorialPassed;
    NSString *buildingSettingFilter = self.buildingSettingFilter;
    NSString *buildingSettingsNearbyConfig = self.buildingSettingsNearbyConfig;
    NSString *buildingSettingsRange = self.buildingSettingsRange;
    NSString *userTypeActive = self.userTypeActive;
    NSString *userNetID = self.userNetID;
    NSString *userLoginDate = self.userLoginDate;
    NSString *didLogOffNonEng = self.didLogOffNonEng;
    NSString *didPassEATutorial = self.didPassEATutorial;
    NSString *shouldUpdateWebpage = self.shouldUpdateWebpage;


    NSString *didSave = @"YES";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:section forKey:@"section"];
    [defaults setObject:semester forKey:@"semester"];
    [defaults setObject:faculty forKey:@"faculty"];
    [defaults setObject:closedAppResourceIndicator forKey:@"closedAppResourceIndicator"];
    [defaults setObject:didSave forKey:@"didSave"];
    [defaults setObject:tutorialPass forKey:@"loginTutorialPassed"];
    [defaults setObject:userTypeActive forKey:@"userTypeActive"];
    [defaults setObject:buildingSettingFilter forKey:@"buildingSettingFilter"];
    [defaults setObject:buildingSettingsNearbyConfig forKey:@"buildingSettingsNearbyConfig"];
    [defaults setObject:buildingSettingsRange forKey:@"buildingSettingsRange"];
    [defaults setObject:userNetID forKey:@"userNetID"];
    [defaults setObject:userLoginDate forKey:@"userLoginDate"];
    [defaults setObject:didLogOffNonEng forKey:@"didLogOffNonEng"];
    [defaults setObject:didPassEATutorial forKey:@"didPassEATutorial"];
    [defaults setObject:shouldUpdateWebpage forKey:@"shouldUpdateWebpage"];

    
    [defaults synchronize];
}

@end
