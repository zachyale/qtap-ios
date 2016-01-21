//
//  ResourcesViewController.h
//  combinedFramework
//
//  Created by Rony Besprozvanny and Zachary Yale on 2015-03-21.
//  Copyright (c) 2016 QTap Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface ResourcesViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UITableViewCell *semesterCell;
@property (unsafe_unretained, nonatomic) IBOutlet UITableViewCell *sectionCell;
@property (unsafe_unretained, nonatomic) IBOutlet UITableViewCell *facultyCell;
@property (strong, nonatomic) IBOutlet UILabel *facultyLabel;
@property (strong, nonatomic) IBOutlet UILabel *semesterLabel;
@property (strong, nonatomic) IBOutlet UILabel *sectionLabel;
//All the properties necessary for the UI elements
@property (strong, nonatomic) IBOutlet UILabel *sectLbl;
@property (strong, nonatomic) IBOutlet UIButton *btnSect;
@property (strong, nonatomic) IBOutlet UIPickerView *sectPicker;
@property (strong, nonatomic) IBOutlet UIPickerView *facultyPicker;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segSemesterControl;

// For the non-eng one we need to allocate the account info
@property (strong, nonatomic) IBOutlet UILabel *lblNetID;
@property (strong, nonatomic) IBOutlet UILabel *lblFirstSync;


// All the actions needed for the resources section
- (IBAction)semesterChange:(UISegmentedControl *)sender;
- (IBAction)wolframLink:(id)sender;
- (IBAction)moodleLink:(id)sender;
- (IBAction)solusLink:(id)sender;
- (IBAction)d2lLink:(id)sender;
- (IBAction)outlookLink:(id)sender;
- (IBAction)goToSolus:(id)sender;
- (IBAction)goBackToStart:(id)sender;
- (void) navBarColorSet;
@end
