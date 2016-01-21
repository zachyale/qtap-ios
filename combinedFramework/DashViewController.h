
//
//  DashViewController.h
//  combinedFramework
//
//  Created by Zachary Yale on 2015-03-19.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashViewController : UITableViewController

//Arrays of labels to be used to display schedule datat
@property (retain, nonatomic)IBOutletCollection(UILabel) NSMutableArray *lblRmArray;
@property (retain, nonatomic)IBOutletCollection(UILabel) NSMutableArray *lblSchedArray;
@property (retain, nonatomic)IBOutletCollection(UILabel) NSMutableArray *lblTypeArray;
@property (retain, nonatomic)IBOutletCollection(UIImageView) NSMutableArray *imgArry;
//Nav buttons for moving between days
@property (retain, nonatomic) IBOutlet UINavigationItem *navBar;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *forward;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *backward;
//Views used to indicate to the user the current class slot using the red line
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIView *line5;
@property (weak, nonatomic) IBOutlet UIView *line6;
@property (weak, nonatomic) IBOutlet UIView *line7;
@property (weak, nonatomic) IBOutlet UIView *line8;
@property (weak, nonatomic) IBOutlet UIView *line9;
@property (weak, nonatomic) IBOutlet UIView *line10;
//Button to bring the user back to the current day
@property (weak, nonatomic) IBOutlet UIButton *currentDayButton;
//String that contains the student specific section from other view controllers
// Allows program to retrieve section number when user exits and enters app as well
@property (strong, nonatomic) NSString *sectNumber;
@property (strong, nonatomic) NSString *sectString; //Fall or Winter
// Methods to be used to switch to the current day and also the forward and back days
- (IBAction)changeDayCurrent:(id)sender;
- (IBAction)changeDaySchedule:(id)sender;
- (IBAction)changeDayScheduleBackward:(id)sender;
// retrieves the users schedule
- (void)getSchedule;
// function that will display the propoer user schedule based on the current day as an int
- (void) displayProperScheduleDay:(int)num;

@end