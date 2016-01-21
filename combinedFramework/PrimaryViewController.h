//
//  PrimaryViewController.h
//  webViewTest
//
//  Created by Rony Besprozvanny and Zachary Yale on 2015-08-14.
//  Copyright (c) 2016 QTap Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EAIntroView/EAIntroView.h>

@interface PrimaryViewController : UIViewController <EAIntroDelegate>

- (IBAction)goToLoginView:(id)sender;
- (IBAction)goToEngineeringSection:(id)sender;

@end
