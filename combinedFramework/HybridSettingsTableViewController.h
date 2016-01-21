//
//  HybridSettingsTableViewController.h
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-08-11.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HybridSettingsTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

- (IBAction)switchValueChange:(id)sender;
- (IBAction)sliderValueChange:(id)sender;

@end
