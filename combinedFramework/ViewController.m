//
//  ViewController.m
//  
//
//  Created by Rony Besprozvanny and Zachary Yale on 2015-08-10.
//  Copyright (c) 2016 QTap Project. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize webView, actInd;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    webView.delegate = self;
    // Notification to be used in error handling
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadInitialWebpage:) name:@"loadWebpage" object:nil];

    // load in the my.queensu.com url
    NSURL *url = [NSURL URLWithString:@"https://my.queensu.ca/software-centre"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:20];
    
    [self.webView loadRequest:request];


}

- (void) loadInitialWebpage: (NSNotification *)notif
{
    
    // load in the my.queensu.com url
    NSURL *url = [NSURL URLWithString:@"https://my.queensu.ca/software-centre"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:20];
    
    [self.webView loadRequest:request];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) webViewDidStartLoad: (UIWebView *)web
{
    actInd.hidden = NO;
    [actInd performSelectorInBackground:@selector(startAnimating) withObject:nil];
}

- (void)webView:(UIWebView *)web didFailLoadWithError:(NSError *)error
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.shouldUpdateWebpage = @"YES";
    actInd.hidden = YES;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The My Queens Login page cannot be loaded. Please check your internet connection, re-open the app and try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert setTag:1];
    [alert show];
}


-(void)webViewDidFinishLoad:(UIWebView *)web {
    
    // Stop the activity indicator
    [actInd performSelectorInBackground:@selector(stopAnimating) withObject:nil];
    actInd.hidden = YES;
    NSString *htmlContent = [web stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
    // Hide the webview once user hits login
    // Withint the login HTML is a post method with the following link "https://my.queensu.ca/Shibboleth.sso/SAML2/POST"
    // Once the program finds this link in the HTML it will hide the webview thus avoiding users seeing the Student Centre flash
    if ([htmlContent rangeOfString:@"https://my.queensu.ca/Shibboleth.sso/SAML2/POST"].location != NSNotFound) {
        // Hide the webview from now on
        webView.hidden = YES;
    }
    else if ([htmlContent rangeOfString:@".ics"].location != NSNotFound)
    {
        // Only in use if user is still logged into a current session and is resyncing
        webView.hidden = YES;
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:@"loadWebpage"
                                                      object:nil];
        NSLog(@"FOUND!!");
        // Now we want to go ahead and parse the string out
        NSRange ind = [htmlContent rangeOfString:@"https://mytimetable.queensu.ca/"];
        NSRange ind2 = [htmlContent rangeOfString:@".ics"];
        // 4 is the length of the .ics
        NSString *classSchedLink = [htmlContent substringWithRange:NSMakeRange(ind.location, ind2.location - ind.location + (4))];

        NSLog(@"%@", classSchedLink);
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        delegate.shouldUpdateWebpage = @"NO";
        // Now we need to go ahead and download the links contents
        NSURL *classURL = [NSURL URLWithString:classSchedLink];
        
        [[UIApplication sharedApplication]openURL:classURL];
        // Buffer to allow for schedule to be added
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(displayAlert) userInfo:self repeats:NO];
    }
    
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag != 1)
    {
        if (buttonIndex == [alertView cancelButtonIndex])
        {
            [self goToDashboard];
        }
    }
}

- (void) displayAlert
{
    // Show the redirection alert view and proceed to the Dashboard
    UIAlertView *alertTest = [[UIAlertView alloc]initWithTitle:@"Complete!" message:@"Your schedule has been added to your local calendar." delegate:self cancelButtonTitle:@"Go" otherButtonTitles: nil];
    [alertTest setTag:0];
    [alertTest show];
}

- (void) goToDashboard
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([delegate.userTypeActive isEqualToString:@"non-engineering"]) {
        [self performSegueWithIdentifier:@"goToNonEng" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"goToEng" sender:self];
    }

}

@end
