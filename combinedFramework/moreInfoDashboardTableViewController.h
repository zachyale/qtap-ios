//
//  moreInfoDashboardTableViewController.h
//  combinedFramework
//
//  Created by Rony Besprozvanny and Zachary Yale on 2015-08-26.
//  Copyright (c) 2016 QTap Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface moreInfoDashboardTableViewController : UITableViewController

@property (nonatomic, assign) NSString *classTitle;
@property (nonatomic, assign) NSString *classLocs;

@property (nonatomic, retain) IBOutlet UINavigationItem *navItem;

@end
