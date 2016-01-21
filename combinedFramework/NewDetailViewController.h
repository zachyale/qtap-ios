//
//  NewDetailViewController.h
//  combinedFramework
//
//  Created by Rony Besprozvanny and Zachary Yale on 2015-08-19.
//  Copyright (c) 2016 QTap Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tableView;
// Data that will be passed on
@property (strong, nonatomic) NSString *foodTitleString;
@property (strong, nonatomic) NSString *buildingNameString;
@property (strong, nonatomic) NSString *addressString;

@property (strong, nonatomic) NSString *mondayhrsString;
@property (strong, nonatomic) NSString *tuesdayhrsString;
@property (strong, nonatomic) NSString *wednesdayhrsString;
@property (strong, nonatomic) NSString *thursdayhrsString;
@property (strong, nonatomic) NSString *fridayhrsString;
@property (strong, nonatomic) NSString *saturdayhrsString;
@property (strong, nonatomic) NSString *sundayhrsString;
@property (strong, nonatomic) NSString *coordStr;
// Academic Buildings
@property (strong, nonatomic) NSString *bioString;


// The three labels before the table view and the image view
@property (strong, nonatomic) IBOutlet UILabel *lblServiceName;
@property (strong, nonatomic) IBOutlet UILabel *lblBuildingName;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;

- (NSString *) checkTimesAndImplementOpenFeature: (NSString *) analysisString currentTime: (int) currentTimeInt;

@end
