//
//  AppDelegate.h
//  combinedFramework
//
//  Created by Zachary Yale on 2015-03-19.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *userTypeActive;
@property (strong, nonatomic) NSString *applicationDefaultCheck;
@property (strong, nonatomic) NSString *sectionActive;
@property (strong, nonatomic) NSString *semesterActive;
@property (strong, nonatomic) NSString *settingsIdentifier;
@property (strong, nonatomic) NSString *facultyActive;
@property (strong, nonatomic) NSString *saved;
@property (strong, nonatomic) NSString *loginTutorialPassed;
@property (strong, nonatomic) NSString *buildingSettingFilter;
@property (strong, nonatomic) NSString *buildingSettingsNearbyConfig;
@property (strong, nonatomic) NSString *buildingSettingsRange;
@property (strong, nonatomic) NSString *userNetID;
@property (strong, nonatomic) NSString *userLoginDate;
@property (strong, nonatomic) NSString *didLogOffNonEng;
@property (strong, nonatomic) NSString *didPassEATutorial;
@property (strong, nonatomic) NSString *didReadFacultyWarning;
@property (strong, nonatomic) NSString *shouldUpdateWebpage;
@property (strong, nonatomic) NSString *closedAppResourceIndicator;

@end

