//
//  ViewController.m
//  homeworkView
//
//  Created by Zachary Yale on 2015-03-18.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import "HomeworkViewController.h"
#import "AppDelegate.h"

@interface HomeworkViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *homeworkView;
- (IBAction)loadWebPage:(UIBarButtonItem *)sender;
- (IBAction)loadWebPageBACK:(UIBarButtonItem *)sender;
- (IBAction)loadWebPageFOR:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forward;

@end

@implementation HomeworkViewController
{
    NSArray *homeworkSemesterURLs;
    NSArray *semesterActivateDates;
    NSArray *homeworkWeeks;
    int weeksActive;
    int currentWeek;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    // Logic is if users semester is fall load in the fall related entries from the .plist
    // activate the next button when the date is equal to or greater than the date plist
    // Account for Week 1 no homework
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Semester check
    /*
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
    }*/
    
    NSDate *curDate = [NSDate date];
    
    // Generate date components for the start date so it will ouput current day and month and use in the day title bar item
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSCalendarUnitDay| NSCalendarUnitMonth| NSCalendarUnitYear | NSCalendarUnitWeekday fromDate:curDate];
    NSInteger month = [comps month];
    
    // Find the current month
    switch (month)
    {
        case 1: // January
            delegate.semesterActive = @"Winter";
            break;
        case 2: // February
            delegate.semesterActive = @"Winter";
            break;
        case 3: // March
            delegate.semesterActive = @"Winter";
            break;
        case 4: // April
            delegate.semesterActive = @"Winter";
            break;
        case 5: // May
            delegate.semesterActive = @"Fall";
            break;
        case 6: // June
            delegate.semesterActive = @"Fall";
            break;
        case 7: // July
            delegate.semesterActive = @"Fall";
            break;
        case 8: // August
            delegate.semesterActive = @"Fall";
            break;
        case 9: // September
            delegate.semesterActive = @"Fall";
            break;
        case 10: // October
            delegate.semesterActive = @"Fall";
            break;
        case 11: // November
            delegate.semesterActive = @"Fall";
            break;
        case 12: // December
            delegate.semesterActive = @"Fall";
            break;
        default:
            break;
    }

    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"homeworkURL" ofType:@"plist"];
    // Load the file content and read the data into arrays
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    if ([delegate.semesterActive isEqualToString:@"Fall"]) {
        homeworkSemesterURLs = [dict objectForKey:@"FallHomeworkURLs"];
        semesterActivateDates = [dict objectForKey:@"FallWeeksToActivate"];
    }
    else
    {
        homeworkSemesterURLs = [dict objectForKey:@"WinterHomeworkURLs"];
        semesterActivateDates = [dict objectForKey:@"WinterWeeksToActivate"];
    }
    // Week 1 to 12
    homeworkWeeks = [dict objectForKey:@"HomeworkWeeks"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    weeksActive = -1;
    currentWeek = 0;
    // We need to do a check to see which weeks homework is active
    for (int i = 0; i < homeworkWeeks.count; i++) {
        // Convert current index to a date
        NSDate *currentWeekStr = [dateFormat dateFromString:semesterActivateDates[i]];
        if ([[NSDate date] compare:currentWeekStr] == NSOrderedAscending) {
            NSLog(@"Current week saturday is bigger");
        }
        else if ([[NSDate date] compare:currentWeekStr] == NSOrderedDescending)
        {
            NSLog(@"Current date bigger");
            weeksActive ++;
            
        }
        else
        {
            NSLog(@"Dates are the same");
            weeksActive ++;
        }
    }
    
    // Now we know we can active from Week 1 to Week X
    
    //drawing the first week title
    NSString *weekTitle = homeworkWeeks[0];
    self.navigationItem.title = weekTitle;
    //first web-page load
    if (weeksActive == -1) {
        // Show alert
        self.forward.enabled = NO;
        self.back.enabled = NO;
        // Initial conditions
        if ([[NSDate date] compare:[dateFormat dateFromString:@"09/14/2015"]]== NSOrderedDescending && [delegate.semesterActive isEqualToString:@"Fall"]) {
            NSLog(@"Current date bigger");
            // Alert users
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Unfortunately there is no homework upload in Week 1. Homework will be uploaded weekly starting Week 2. Please check back every Saturday starting Week 2 to see the new homework upload" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else if ([[NSDate date] compare:[dateFormat dateFromString:@"01/04/2016"]]== NSOrderedDescending && [delegate.semesterActive isEqualToString:@"Winter"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome Back" message:@"Week 1 homework will be uploaded and can be viewed on Saturday." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            UIAlertView *homeworkAlert = [[UIAlertView alloc] initWithTitle:@"Note" message:@"No homework available yet. Please check back at the start of term. Please make sure you have also selected your semester and section for the corresponding term, otherwise the homework will not be displayed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [homeworkAlert show];
            NSLog(@"Homework Not yet ready");
        }
    }
    else
    {
        self.forward.enabled = YES;
        self.back.enabled = YES;
        if (![delegate.semesterActive isEqualToString:@"Fall"]) {
            // Load in the first week
            NSString *weekTitle = homeworkWeeks[currentWeek];
            self.navigationItem.title = weekTitle;
            NSString *urlAddress = homeworkSemesterURLs[0];
            NSURL *url = [NSURL URLWithString:urlAddress];
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            
            [self.homeworkView loadRequest:request];
        }
        else
        {
            if (weeksActive == 0) {
                // Alert users
                self.forward.enabled = NO;
                self.back.enabled = NO;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Unfortunately there is no homework upload in Week 1. Homework will be uploaded weekly starting Week 2. Please check back every Saturday starting Week 2 to see the new homework upload" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else
            {
                // More than one week available so set the first week as the second week
                if ([delegate.semesterActive isEqualToString:@"Fall"]) {
                    if (weeksActive == 1) {
                        self.back.enabled = NO;
                    }
                }
                currentWeek = 1;
                NSString *weekTitle = homeworkWeeks[currentWeek];
                self.navigationItem.title = weekTitle;
                NSString *urlAddress = homeworkSemesterURLs[1];
                NSURL *url = [NSURL URLWithString:urlAddress];
                
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                
                [self.homeworkView loadRequest:request];
            }
            
        }
    }

}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // If failed then we want to go ahead and set the next button to disabled
    self.forward.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadWebPageBACK:(UIButton *)sender {
    self.forward.enabled = YES;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // For the fall exception
    BOOL loadHomework = YES;
    if ([delegate.semesterActive isEqualToString:@"Fall"]) {
        // Disable the week 1
        if ((currentWeek - 1) == 0) {
            self.back.enabled = NO;
            loadHomework = NO;
        }
    }
    if (loadHomework == YES)
    {
        if ((currentWeek - 1) <= weeksActive) {
            // All good
            if (currentWeek - 1 == -1) {
                self.back.enabled = NO;
            }
            else
            {
                currentWeek--;
                // Also enable the forward button
                self.forward.enabled = YES;
                [self loadHomework];
            }
        }
        else
        {
            //Do not go to next
            self.back.enabled = NO;
        }
    }
}

- (IBAction)loadWebPageFOR:(UIButton *)sender {
    self.back.enabled = YES;
    if (currentWeek + 1 == 12) {
        self.forward.enabled = NO;
    }
    else if ((currentWeek + 1) <= weeksActive) {
        // All good
        currentWeek++;
        [self loadHomework];
    }
    else
    {
        //Do not go to next
        self.forward.enabled = NO;
        UIAlertView *homeworkAlert = [[UIAlertView alloc] initWithTitle:@"Note" message:@"Next weeks homework is not up yet. Please check back on Saturday." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [homeworkAlert show];
    }
}

- (void) loadHomework
{
    NSString *weekTitle = homeworkWeeks[currentWeek];
    self.navigationItem.title = weekTitle;
    NSString *urlAddress = homeworkSemesterURLs[currentWeek];
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [self.homeworkView loadRequest:request];
}

@end
