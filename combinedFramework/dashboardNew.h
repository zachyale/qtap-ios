//
//  dashboardNew.h
//  webViewTest
//
//  Created by Zachary Yale and Rony Besprozvanny on 2015-08-14.
//  Copyright (c) 2016 QTap Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@interface dashboardNew : UITableViewController

@property (weak, nonatomic) IBOutlet UIButton *dayTitle;
//String contains the student specific section from other view controllers
// Allows program to retrieve section number when user exits and enters app as well
@property (strong, nonatomic) NSString *sectNumber;
@property (strong, nonatomic) NSString *sectString; //Fall or Winter
// retrieves the users schedule
- (void)getSchedule;
// function that will display the propoer user schedule based on the current day as an int
- (void) displayProperScheduleDay:(int)num;
- (IBAction)changeDayCurrent:(id)sender;
- (IBAction)goToNext:(id)sender;
- (IBAction)goBack:(id)sender;

@end
