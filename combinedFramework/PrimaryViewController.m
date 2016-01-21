//
//  PrimaryViewController.m
//  webViewTest
//
//  Created by Rony Besprozvanny on 2015-08-14.
//  Copyright (c) 2015 Rony. All rights reserved.
//

#import "PrimaryViewController.h"
#import "AppDelegate.h"
#import <EAIntroView/EAIntroView.h>

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

static NSString * const sampleDescription1 = @"To learn more about QTap's features, swipe to the right!";
static NSString * const sampleDescription2 = @"View your schedule in real-time, and see what classes you have coming up";
static NSString * const sampleDescription3 = @"Find building hours for nearby campus eateries, and see what's still open";
static NSString * const sampleDescription4 = @"Get the helpful resources that you need, all in one place";

@interface PrimaryViewController (){
    UIView *rootView;
    EAIntroView *_intro;
}
@end

@implementation PrimaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    rootView = self.view;
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // For Non-Eng - if user just logged out do not show the tutorial
    // Check log off progress in past - if so then reset
    if ([delegate.didLogOffNonEng isEqualToString:@"YES"]) {
        delegate.didLogOffNonEng = nil;
    }
    
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Welcome to QTap";
    page1.desc = sampleDescription1;
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iTunesArtwork"]];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"Dashboard";
    page2.desc = sampleDescription2;
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DashboardTutorialFinal.png"]];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"Building Info";
    page3.desc = sampleDescription3;
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BuildingTutorialFinal.png"]];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"Resources";
    page4.desc = sampleDescription4;
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ResourcesTutorialFinal.png"]];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:rootView.bounds andPages:@[page1,page2,page3,page4]];
    intro.bgImage = [UIImage imageNamed:@"original_BG.png"];
    intro.bgViewContentMode = UIViewContentModeScaleAspectFill;
    
    intro.pageControlY = 80.f;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"Get Started" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [btn setBackgroundColor:[UIColor colorWithRed:66.0/255.0f green:213.0/255.0f blue:82.0/255.0f alpha:1.0]];
    [btn setFrame:CGRectMake(0, 0, self.view.frame.size.width, 60.f)];
    
    
    if(IS_IPHONE_4_OR_LESS)
    {
        NSLog(@"IS_IPHONE_4_OR_LESS");
        
        [page1.titleIconView setFrame:CGRectMake((self.view.frame.size.width/2) - ((self.view.frame.size.width-60)/2),80, self.view.frame.size.width-60, 180)];
        page1.titleIconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [page2.titleIconView setFrame:CGRectMake((self.view.frame.size.width/2) - ((self.view.frame.size.width-60)/2),20, self.view.frame.size.width-60, 290)];
        page2.titleIconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [page3.titleIconView setFrame:CGRectMake((self.view.frame.size.width/2) - ((self.view.frame.size.width-60)/2),20, self.view.frame.size.width-60, 290)];
        page3.titleIconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [page4.titleIconView setFrame:CGRectMake((self.view.frame.size.width/2) - ((self.view.frame.size.width-60)/2),20, self.view.frame.size.width-60, 290)];
        page4.titleIconView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    if(IS_IPHONE_5)
    {
        NSLog(@"IS_IPHONE_5");
        
        [page1.titleIconView setFrame:CGRectMake((self.view.frame.size.width/2) - ((self.view.frame.size.width-60)/2),80, self.view.frame.size.width-60, 180)];
        page1.titleIconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [page2.titleIconView setFrame:CGRectMake((self.view.frame.size.width/2) - ((self.view.frame.size.width-60)/2),-90, self.view.frame.size.width-60, 614)];
        page2.titleIconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [page3.titleIconView setFrame:CGRectMake((self.view.frame.size.width/2) - ((self.view.frame.size.width-60)/2),-90, self.view.frame.size.width-60, 614)];
        page3.titleIconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [page4.titleIconView setFrame:CGRectMake((self.view.frame.size.width/2) - ((self.view.frame.size.width-60)/2),-90, self.view.frame.size.width-60, 614)];
        page4.titleIconView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    if(IS_IPHONE_6)
    {
        NSLog(@"IS_IPHONE_6");
        
        [page1.titleIconView setFrame:CGRectMake((self.view.frame.size.width/2) - ((self.view.frame.size.width-60)/2),80, self.view.frame.size.width-60, 180)];
        page1.titleIconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [page2.titleIconView setFrame:CGRectMake((self.view.frame.size.width/2) - ((self.view.frame.size.width-60)/2),-40, self.view.frame.size.width-60, 614)];
        page2.titleIconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [page3.titleIconView setFrame:CGRectMake((self.view.frame.size.width/2) - ((self.view.frame.size.width-60)/2),-40, self.view.frame.size.width-60, 614)];
        page3.titleIconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [page4.titleIconView setFrame:CGRectMake((self.view.frame.size.width/2) - ((self.view.frame.size.width-60)/2),-40, self.view.frame.size.width-60, 614)];
        page4.titleIconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    if(IS_IPHONE_6P)
    {
        NSLog(@"IS_IPHONE_6P");
        
        [page1.titleIconView setFrame:CGRectMake((self.view.frame.size.width/2) - ((self.view.frame.size.width-60)/2),120, self.view.frame.size.width-60, 250)];
        page1.titleIconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [page2.titleIconView setFrame:CGRectMake((self.view.frame.size.width/2) - ((self.view.frame.size.width-60)/2),-10, self.view.frame.size.width-60, 614)];
        page2.titleIconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [page3.titleIconView setFrame:CGRectMake((self.view.frame.size.width/2) - ((self.view.frame.size.width-60)/2),-10, self.view.frame.size.width-60, 614)];
        page3.titleIconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [page4.titleIconView setFrame:CGRectMake((self.view.frame.size.width/2) - ((self.view.frame.size.width-60)/2),-10, self.view.frame.size.width-60, 614)];
        page4.titleIconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    //20, 290  4S
    //-90 614  5S
    //-40 614  6
    //-19 614  6+
    intro.skipButton = btn;
    intro.skipButtonY = 60.f;
    intro.skipButtonAlignment = EAViewAlignmentCenter;
    
    intro.backgroundColor = [UIColor colorWithRed:0.f green:0.49f blue:0.96f alpha:1.f]; //iOS7 dark blue
    [intro setDelegate:self];
    
    if([delegate.didPassEATutorial isEqualToString:@""] || delegate.didPassEATutorial == nil)
    {
        [intro showInView:rootView animateDuration:0.3];
    }
}

- (void)introDidFinish:(EAIntroView *)introView {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"introDidFinish callback");
    delegate.didPassEATutorial = @"PASSED";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToLoginView:(id)sender {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.userTypeActive = @"non-engineering";
    [self performSegueWithIdentifier:@"goToLoginNonEng" sender:self];

}

- (IBAction)goToEngineeringSection:(id)sender
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.userTypeActive = @"engineering";
    // Figure out the semester
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSDate *fallSemMarginSet = [dateFormat dateFromString:@"09/01/2015"];
    NSDate *winterSemMarginSet = [dateFormat dateFromString:@"01/01/2016"];
    if ([[NSDate date] compare:fallSemMarginSet] == NSOrderedDescending && [[NSDate date] compare:winterSemMarginSet] == NSOrderedAscending) {
        NSLog(@"Bigger than fall and smaller than winter margin");
        delegate.semesterActive = @"Fall";
    }
    else
    {
        delegate.semesterActive = @"Winter";
    }

    // Before go to eng now go to login
    [self performSegueWithIdentifier:@"goToLoginEng" sender:self];
}

@end
