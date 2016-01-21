//
//  HybridSettingsViewController.h
//  combinedFramework
//
//  Created by Rony Besprozvanny and Zachary Yale on 2015-08-11.
//  Copyright (c) 2016 QTap Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HybridSettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *submitSettings;
@property (weak, nonatomic) IBOutlet UIView *containerView;

- (IBAction)confirmAndExit:(id)sender;

@end
