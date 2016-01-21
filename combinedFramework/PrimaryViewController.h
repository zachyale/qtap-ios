//
//  PrimaryViewController.h
//  webViewTest
//
//  Created by Rony Besprozvanny on 2015-08-14.
//  Copyright (c) 2015 Rony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EAIntroView/EAIntroView.h>

@interface PrimaryViewController : UIViewController <EAIntroDelegate>

- (IBAction)goToLoginView:(id)sender;
- (IBAction)goToEngineeringSection:(id)sender;

@end
