//
//  moreInfoDashboardTableViewController.h
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-08-26.
//  Copyright (c) 2015 Queen's University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface moreInfoDashboardTableViewController : UITableViewController

@property (nonatomic, assign) NSString *classTitle;
@property (nonatomic, assign) NSString *classLocs;

@property (nonatomic, retain) IBOutlet UINavigationItem *navItem;

@end
