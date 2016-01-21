//
//  HybridSettingsTableViewController.h
//  combinedFramework
//
//  Created by Rony Besprozvanny and Zachary Yale on 2015-08-11.
//  Copyright (c) 2016 QTap Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HybridSettingsTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

- (IBAction)switchValueChange:(id)sender;
- (IBAction)sliderValueChange:(id)sender;

@end
