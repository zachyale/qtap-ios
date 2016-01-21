//
//  settingsViewControllerPrime.h
//  combinedFramework
//
//  Created by Zachary Yale on 2015-07-23.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface settingsViewControllerPrime : UITableViewController

@property (strong, nonatomic) IBOutlet UILabel *facultyLabel;
@property (strong, nonatomic) IBOutlet UILabel *semesterLabel;
@property (strong, nonatomic) IBOutlet UILabel *sectionLabel;

@property (strong, nonatomic) NSString *identifierString;

//All the properties necessary for the UI elements
@property (strong, nonatomic) IBOutlet UILabel *sectLbl;
@property (strong, nonatomic) IBOutlet UIButton *btnSect;

@end