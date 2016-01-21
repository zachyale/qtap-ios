//
//  ViewController.h
//  webViewTest
//
//  Created by Rony Besprozvanny on 2015-08-10.
//  Copyright (c) 2015 Rony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actInd;

@end

