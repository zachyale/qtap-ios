//
//  ViewController.h
//  
//
//  Created by Zachary Yale and Rony Besprozvanny on 2015-08-10.
//  Copyright (c) 2016 QTap Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actInd;

@end

