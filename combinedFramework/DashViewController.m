//
//  DashViewController.m
//  combinedFramework
//
//  Created by Zachary Yale on 2015-03-19.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import "DashViewController.h"
#import "AppDelegate.h"
#import "TabBarControllerDelegate.h"
#import "ResourcesViewController.h"

@interface DashViewController ()
-(void) displayProperScheduleDay:(int) num;
@end

@implementation DashViewController
{
    NSArray *mondayClass;
    NSArray *mondayRm;
    NSArray *mondayType;
    
    NSArray *tuesdayClass;
    NSArray *tuesdayRm;
    NSArray *tuesdayType;
    
    NSArray *wedClass;
    NSArray *wedRm;
    NSArray *wedType;
    
    NSArray *thursClass;
    NSArray *thursRm;
    NSArray *thursType;
    
    NSArray *friClass;
    NSArray *friRm;
    NSArray *friType;
    
    NSString *buttonTitle;
    
    int day;
    int tempDay;
    int currentTimeInt;
    
}
// Initializing all UI elements
@synthesize currentDayButton, lblRmArray, lblSchedArray, lblTypeArray, forward, navBar, backward,title, imgArry, line1, line2, line3, line4, line5, line6, line7, line8, line9, line10;

// Purpose of function is to retrive and display the users schedule
- (void) displayProperScheduleDay:(int)num
{
    [self getSchedule];
    NSArray *classArray;
    NSArray *roomArry;
    NSArray *typeArry;
    //defines characteristics of iOS devices with screens smaller than the 6
#define IS_IPHONE_LEGACY ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.width - ( double )320 ) < DBL_EPSILON )
    switch(num)
    {
        case 0:
            classArray = [NSArray arrayWithArray:mondayClass];
            roomArry = [NSArray arrayWithArray:mondayRm];
            typeArry = [NSArray arrayWithArray:mondayType];
            break;
        case 1:
            classArray = [NSArray arrayWithArray:tuesdayClass];
            roomArry = [NSArray arrayWithArray:tuesdayRm];
            typeArry = [NSArray arrayWithArray:tuesdayType];
            break;
        case 2:
            classArray = [NSArray arrayWithArray:wedClass];
            roomArry = [NSArray arrayWithArray:wedRm];
            typeArry = [NSArray arrayWithArray:wedType];
            break;
        case 3:
            classArray = [NSArray arrayWithArray:thursClass];
            roomArry = [NSArray arrayWithArray:thursRm];
            typeArry = [NSArray arrayWithArray:thursType];
            break;
        case 4:
            classArray = [NSArray arrayWithArray:friClass];
            roomArry = [NSArray arrayWithArray:friRm];
            typeArry = [NSArray arrayWithArray:friType];
            break;
        default:
            break;
    }
    //Correctly display info in the corresponding labels
    for (int j = 0; j <10; j++)
    {
        UILabel *lblRm = [lblRmArray objectAtIndex:j];
        UILabel *lblType = [lblTypeArray objectAtIndex:j];
        UILabel *lblSched = [lblSchedArray objectAtIndex:j];
        UIImageView *imgClass = [imgArry objectAtIndex:j];
        
        NSString *rmString = [NSString stringWithFormat:@"%@", roomArry[j]];
        NSString *typeString = [NSString stringWithFormat:@"%@", typeArry[j]];
        lblRm.text = rmString;
        lblType.text = typeString;
        NSString *schedString = [NSString stringWithFormat:@"%@", classArray[j]];
        //Color detection - Fall Semester - re-usable
        if([schedString containsString:@"111"])
            imgClass.image = [UIImage imageNamed:@"BlueCircle-64.png"];
        if([schedString containsString:@"131"])
            imgClass.image = [UIImage imageNamed:@"NavyCircle-64.png"];
        if([schedString containsString:@"151"])
            imgClass.image = [UIImage imageNamed:@"GreenCircle-64.png"];
        if([schedString containsString:@"161"])
            imgClass.image = [UIImage imageNamed:@"OrangeCircle-64.png"];
        if([schedString containsString:@"171"])
            imgClass.image = [UIImage imageNamed:@"RedCircle-64.png"];
        //Full Year
        if([schedString containsString:@"100"])
            imgClass.image = [UIImage imageNamed:@"PurpleCircle-64.png"];
        //Color detection - Winter Semester
        if([schedString containsString:@"112"])
            imgClass.image = [UIImage imageNamed:@"BlueCircle-64.png"];
        if([schedString containsString:@"132"])
            imgClass.image = [UIImage imageNamed:@"NavyCircle-64.png"];
        if([schedString containsString:@"142"])
            imgClass.image = [UIImage imageNamed:@"GoldCircle-64.png"];
        if([schedString containsString:@"174"])
            imgClass.image = [UIImage imageNamed:@"TealCircle-64.png"];
        if([schedString containsString:@"172"])
            imgClass.image = [UIImage imageNamed:@"OrangeCircle-64.png"];
        
        lblSched.text = schedString;
        
        if(IS_IPHONE_LEGACY)
        {
            [lblSched setFont:[UIFont systemFontOfSize:16]];
            [lblRm setFont:[UIFont systemFontOfSize:15]];
            [lblType setFont:[UIFont systemFontOfSize:12]];
        }
    }
    //loop through the array and remove the image views that are not used due to empty class slots
    for(int x = 0; x < 10; x++)
    {
        UIImageView *imgClass = [imgArry objectAtIndex:x];
        if ([classArray[x] isEqualToString:@""]) {
            //hide the corresponding image
            imgClass.hidden = YES;
        }
        else
        {
            //enable the correct ones
            imgClass.hidden = NO;
        }
        
        if(IS_IPHONE_LEGACY)
        {
            //remove images if device is an iPhone 5S/Older
            imgClass.hidden = YES;
        }
    }
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
// Called once and once only when the program is initially loaded
- (void) viewDidLoad
{
    [super viewDidLoad];
    //Retrieve the saved data if it is present
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *section = [defaults objectForKey:@"section"];
    NSString *semester = [defaults objectForKey:@"semester"];
    NSString *faculty = [defaults objectForKey:@"faculty"];
    NSString *didSave = [defaults objectForKey:@"didSave"];
    if ([didSave isEqualToString:@"YES"])
    {
        //A saved file is present
        delegate.sectionActive = section;
        delegate.semesterActive = semester;
        delegate.facultyActive = faculty;
        delegate.saved = @"NO";
    }
    //Call the implent Time Line function that will find the current time and display a red line for the specific class slot
    //Initially display the timeline
    [self implementTimeLine];
    //Check for sat/sun occurences and if so kill the timeline
    [self sunSatRemoveTimeline];
    NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitSecond fromDate:[NSDate date]];
    NSInteger second = [components second];
    NSInteger secTillMin = (60 - second) % 60;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self performSelector:@selector(timerBegan) withObject:self afterDelay:secTillMin];
    
}
// Called every time the view appears
-(void)viewWillAppear:(BOOL)animated
{
    //load up the previously saved data if any was present and get the schedule
    [self getSchedule];
    //Get the current day of the week
    NSString *currentDay = [[NSString alloc]init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"EEEE"];
    currentDay = [dateFormat stringFromDate:[NSDate date]];
    //Display the proper day nav label
    if([currentDay isEqualToString:@"Monday"])
    {
        day = 0;
        buttonTitle = @"Monday";
    }
    else if ([currentDay isEqualToString:@"Tuesday"])
    {
        buttonTitle = @"Tuesday";
        day = 1;
    }
    else if ([currentDay isEqualToString:@"Wednesday"])
    {
        buttonTitle = @"Wednesday";
        day = 2;
    }
    else if ([currentDay isEqualToString:@"Thursday"])
    {
        buttonTitle = @"Thursday";
        day = 3;
    }
    else if ([currentDay isEqualToString:@"Friday"])
    {
        buttonTitle = @"Friday";
        day = 4;
    }
    else
    {
        //If it is either sat or sun set day to 0
        day = 0;
        buttonTitle = @"Monday";
        
    }
    
    [UINavigationBar animateWithDuration:10.0f animations:^{[currentDayButton setTitle:buttonTitle forState:UIControlStateNormal];} ];
    tempDay = day;
    [self displayProperScheduleDay:day];
    [self implementTimeLine];
    //Check for sat/sun occurences and if so kill the timeline
    [self sunSatRemoveTimeline];
    
}

//Purpose of function is to retreieve the users schedule based on the section number they chose
- (void) getSchedule
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *path;
    //If no user selection has every been made set the original section to fall 00
    if (delegate.sectionActive == nil)
    {
        path = [[NSBundle mainBundle] pathForResource:@"00Fall" ofType:@"plist"];
        delegate.sectionActive = @"00";
    }
    if (delegate.semesterActive == nil)
    {
        delegate.semesterActive = @"Fall";
    }
    if (delegate.facultyActive == nil)
    {
        delegate.facultyActive = @"Applied Science";
    }
    //Get the users saved selection and store it into the variable path that will be used to later to load up the scehdule
    if ([delegate.semesterActive isEqualToString:@"Fall"])
    {
        if ([delegate.sectionActive isEqualToString:@"00"])
            path = [[NSBundle mainBundle] pathForResource:@"00Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"01"])
            path = [[NSBundle mainBundle] pathForResource:@"01Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"02"])
            path = [[NSBundle mainBundle] pathForResource:@"02Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"03"])
            path = [[NSBundle mainBundle] pathForResource:@"03Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"04"])
            path = [[NSBundle mainBundle] pathForResource:@"04Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"05"])
            path = [[NSBundle mainBundle] pathForResource:@"05Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"06"])
            path = [[NSBundle mainBundle] pathForResource:@"06Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"07"])
            path = [[NSBundle mainBundle] pathForResource:@"07Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"08"])
            path = [[NSBundle mainBundle] pathForResource:@"08Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"10"])
            path = [[NSBundle mainBundle] pathForResource:@"10Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"11"])
            path = [[NSBundle mainBundle] pathForResource:@"11Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"12"])
            path = [[NSBundle mainBundle] pathForResource:@"12Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"13"])
            path = [[NSBundle mainBundle] pathForResource:@"13Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"14"])
            path = [[NSBundle mainBundle] pathForResource:@"14Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"15"])
            path = [[NSBundle mainBundle] pathForResource:@"15Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"16"])
            path = [[NSBundle mainBundle] pathForResource:@"16Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"17"])
            path = [[NSBundle mainBundle] pathForResource:@"17Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"18"])
            path = [[NSBundle mainBundle] pathForResource:@"18Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"20"])
            path = [[NSBundle mainBundle] pathForResource:@"20Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"21"])
            path = [[NSBundle mainBundle] pathForResource:@"21Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"22"])
            path = [[NSBundle mainBundle] pathForResource:@"22Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"23"])
            path = [[NSBundle mainBundle] pathForResource:@"23Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"24"])
            path = [[NSBundle mainBundle] pathForResource:@"24Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"25"])
            path = [[NSBundle mainBundle] pathForResource:@"25Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"26"])
            path = [[NSBundle mainBundle] pathForResource:@"26Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"27"])
            path = [[NSBundle mainBundle] pathForResource:@"27Fall" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"28"])
            path = [[NSBundle mainBundle] pathForResource:@"28Fall" ofType:@"plist"];
    }
    else
    {
        //Winter Semester
        if ([delegate.sectionActive isEqualToString:@"00"])
            path = [[NSBundle mainBundle] pathForResource:@"0020Winter" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"01"])
            path = [[NSBundle mainBundle] pathForResource:@"0121Winter" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"02"])
            path = [[NSBundle mainBundle] pathForResource:@"0222Winter" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"03"])
            path = [[NSBundle mainBundle] pathForResource:@"0323Winter" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"04"])
            path = [[NSBundle mainBundle] pathForResource:@"0424Winter" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"05"])
            path = [[NSBundle mainBundle] pathForResource:@"0525Winter" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"06"])
            path = [[NSBundle mainBundle] pathForResource:@"0626Winter" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"07"])
            path = [[NSBundle mainBundle] pathForResource:@"0727Winter" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"08"])
            path = [[NSBundle mainBundle] pathForResource:@"0828Winter" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"10"])
            path = [[NSBundle mainBundle] pathForResource:@"10Winter" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"11"])
            path = [[NSBundle mainBundle] pathForResource:@"11Winter" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"12"])
            path = [[NSBundle mainBundle] pathForResource:@"12Winter" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"13"])
            path = [[NSBundle mainBundle] pathForResource:@"13Winter" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"14"])
            path = [[NSBundle mainBundle] pathForResource:@"14Winter" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"15"])
            path = [[NSBundle mainBundle] pathForResource:@"15Winter" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"16"])
            path = [[NSBundle mainBundle] pathForResource:@"16Winter" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"17"])
            path = [[NSBundle mainBundle] pathForResource:@"17Winter" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"18"])
            path = [[NSBundle mainBundle] pathForResource:@"18Winter" ofType:@"plist"];
        
        if ([delegate.sectionActive isEqualToString:@"J"])
            path = [[NSBundle mainBundle] pathForResource:@"J" ofType:@"plist"];
    }
    
    // Load the file content and read the data into arrays
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    mondayClass = [dict objectForKey:@"MondayClass"];
    mondayRm = [dict objectForKey:@"MondayRoom"];
    mondayType = [dict objectForKey:@"MondayType"];
    
    tuesdayClass = [dict objectForKey:@"TuesdayClass"];
    tuesdayRm = [dict objectForKey:@"TuesdayRoom"];
    tuesdayType = [dict objectForKey:@"TuesdayType"];
    
    wedClass = [dict objectForKey:@"WedClass"];
    wedRm = [dict objectForKey:@"WedRoom"];
    wedType = [dict objectForKey:@"WedType"];
    
    thursClass = [dict objectForKey:@"ThursClass"];
    thursRm = [dict objectForKey:@"ThursRoom"];
    thursType = [dict objectForKey:@"ThursType"];
    
    friClass = [dict objectForKey:@"FridayClass"];
    friRm = [dict objectForKey:@"FridayRoom"];
    friType = [dict objectForKey:@"FridayType"];
    
}

- (void)implementTimeLine
{
    NSString *currentHour = [[NSString alloc]init];
    NSString *currentMinute = [[NSString alloc]init];
    NSString *morEve = [[NSString alloc]init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"EEEE"];
    //Get current time
    [dateFormat setDateFormat:@"hh"];
    currentHour = [dateFormat stringFromDate:[NSDate date]];
    [dateFormat setDateFormat:@"mm"];
    currentMinute = [dateFormat stringFromDate:[NSDate date]];
    //Convert values to ints and get correct info
    int currentHourInt = [currentHour intValue];
    currentHourInt = currentHourInt*100;
    int currentMinuteInt = [currentMinute intValue];
    currentTimeInt = currentHourInt + currentMinuteInt; //look into the timer func
    
    //Check for AM/PM
    [dateFormat setDateFormat:@"a"];
    morEve = [dateFormat stringFromDate:[NSDate date]];
    
    if ([morEve isEqualToString:@"AM"]|| [morEve isEqualToString:@"am"])
    {
        //MUST FIX PM PROBLEM
        if(currentTimeInt >= 830 && currentTimeInt < 930)
        {
            line1.hidden = NO;
            line2.hidden = YES;
            line3.hidden = YES;
            line4.hidden = YES;
            line5.hidden = YES;
            line6.hidden = YES;
            line7.hidden = YES;
            line8.hidden = YES;
            line9.hidden = YES;
            line10.hidden = YES;
            
            //8:30 Line ACTIVE
        }
        else if(currentTimeInt >= 930 && currentTimeInt < 1030)
        {
            line1.hidden = YES;
            line2.hidden = NO;
            line3.hidden = YES;
            line4.hidden = YES;
            line5.hidden = YES;
            line6.hidden = YES;
            line7.hidden = YES;
            line8.hidden = YES;
            line9.hidden = YES;
            line10.hidden = YES;
            
            //9:30 Line ACTIVE
        }
        else if(currentTimeInt >= 1030 && currentTimeInt < 1130)
        {
            line1.hidden = YES;
            line2.hidden = YES;
            line3.hidden = NO;
            line4.hidden = YES;
            line5.hidden = YES;
            line6.hidden = YES;
            line7.hidden = YES;
            line8.hidden = YES;
            line9.hidden = YES;
            line10.hidden = YES;
            
            //10:30 Line ACTIVE
        }
        else if((currentTimeInt >= 1130 && currentTimeInt <= 1200))
        {
            line1.hidden = YES;
            line2.hidden = YES;
            line3.hidden = YES;
            line4.hidden = NO;
            line5.hidden = YES;
            line6.hidden = YES;
            line7.hidden = YES;
            line8.hidden = YES;
            line9.hidden = YES;
            line10.hidden = YES;
            
            //11:30 Line ACTIVE
        }
        else {
            line1.hidden = YES;
            line2.hidden = YES;
            line3.hidden = YES;
            line4.hidden = YES;
            line5.hidden = YES;
            line6.hidden = YES;
            line7.hidden = YES;
            line8.hidden = YES;
            line9.hidden = YES;
            line10.hidden = YES;
        }
        
    }
    else if([morEve isEqualToString:@"PM"] || [morEve isEqualToString:@"pm"])
    {
        if((currentTimeInt >= 1200 && currentTimeInt < 1230))
        {
            line1.hidden = YES;
            line2.hidden = YES;
            line3.hidden = YES;
            line4.hidden = NO;
            line5.hidden = YES;
            line6.hidden = YES;
            line7.hidden = YES;
            line8.hidden = YES;
            line9.hidden = YES;
            line10.hidden = YES;
            
            //11:30 Line ACTIVE
        }
        
        if((currentTimeInt >= 1230 && currentTimeInt < 130)|| (currentTimeInt >= 1230 && currentTimeInt < 1330))
        {
            line1.hidden = YES;
            line2.hidden = YES;
            line3.hidden = YES;
            line4.hidden = YES;
            line5.hidden = NO;
            line6.hidden = YES;
            line7.hidden = YES;
            line8.hidden = YES;
            line9.hidden = YES;
            line10.hidden = YES;
            
            //12:30 Line ACTIVE
        }
        else if((currentTimeInt >= 130 && currentTimeInt < 230)||(currentTimeInt >= 1330 && currentTimeInt < 1430))
        {
            line1.hidden = YES;
            line2.hidden = YES;
            line3.hidden = YES;
            line4.hidden = YES;
            line5.hidden = YES;
            line6.hidden = NO;
            line7.hidden = YES;
            line8.hidden = YES;
            line9.hidden = YES;
            line10.hidden = YES;
            
            //1:30 Line ACTIVE
        }
        else if((currentTimeInt >= 230 && currentTimeInt < 330)|| (currentTimeInt >= 1430 && currentTimeInt < 1530))
        {
            line1.hidden = YES;
            line2.hidden = YES;
            line3.hidden = YES;
            line4.hidden = YES;
            line5.hidden = YES;
            line6.hidden = YES;
            line7.hidden = NO;
            line8.hidden = YES;
            line9.hidden = YES;
            line10.hidden = YES;
            
            //2:30 Line ACTIVE
        }
        else if((currentTimeInt >= 330 && currentTimeInt < 430)||(currentTimeInt >= 1530 && currentTimeInt < 1630))
        {
            line1.hidden = YES;
            line2.hidden = YES;
            line3.hidden = YES;
            line4.hidden = YES;
            line5.hidden = YES;
            line6.hidden = YES;
            line7.hidden = YES;
            line8.hidden = NO;
            line9.hidden = YES;
            line10.hidden = YES;
            
            //3:30 Line ACTIVE
        }
        else if((currentTimeInt >= 430 && currentTimeInt < 530)||(currentTimeInt >= 1630 && currentTimeInt < 1730))
        {
            line1.hidden = YES;
            line2.hidden = YES;
            line3.hidden = YES;
            line4.hidden = YES;
            line5.hidden = YES;
            line6.hidden = YES;
            line7.hidden = YES;
            line8.hidden = YES;
            line9.hidden = NO;
            line10.hidden = YES;
            
            //4:30 Line ACTIVE
        }
        else if((currentTimeInt >= 530 && currentTimeInt < 630) || (currentTimeInt >= 1730 && currentTimeInt < 1830))
        {
            line1.hidden = YES;
            line2.hidden = YES;
            line3.hidden = YES;
            line4.hidden = YES;
            line5.hidden = YES;
            line6.hidden = YES;
            line7.hidden = YES;
            line8.hidden = YES;
            line9.hidden = YES;
            line10.hidden = NO;
            
            //5:30 Line ACTIVE
        }
        else {
            line1.hidden = YES;
            line2.hidden = YES;
            line3.hidden = YES;
            line4.hidden = YES;
            line5.hidden = YES;
            line6.hidden = YES;
            line7.hidden = YES;
            line8.hidden = YES;
            line9.hidden = YES;
            line10.hidden = YES;
        }
        
    }
    else
    {
        line1.hidden = YES;
        line2.hidden = YES;
        line3.hidden = YES;
        line4.hidden = YES;
        line5.hidden = YES;
        line6.hidden = YES;
        line7.hidden = YES;
        line8.hidden = YES;
        line9.hidden = YES;
        line10.hidden = YES;
    }
    
}

- (IBAction)changeDaySchedule:(id)sender
{
    if (day == 4)
        day = -1;
    day++;
    [self displayProperScheduleDay:day];
    [self displayProperTitleAndTime];
}

- (IBAction)changeDayCurrent:(id)sender
{
    day = tempDay;
    [self displayProperScheduleDay:day];
    [self displayProperTitleAndTime];
}
- (IBAction)changeDayScheduleBackward:(id)sender
{
    if (day == 0)
        day = 5;
    day--;
    [self displayProperScheduleDay:day];
    [self displayProperTitleAndTime];
}

- (void) displayProperTitleAndTime
{
    switch (day) {
        case 0:
            buttonTitle = @"Monday";
            break;
        case 1:
            buttonTitle = @"Tuesday";
            break;
        case 2:
            buttonTitle = @"Wednesday";
            break;
        case 3:
            buttonTitle = @"Thursday";
            break;
        case 4:
            buttonTitle = @"Friday";
            break;
            
        default:
            break;
    }
    
    [UINavigationBar animateWithDuration:10.0f animations:^{[currentDayButton setTitle:buttonTitle forState:UIControlStateNormal];} ];
    [self implementTimeLine];
    //Check for sat/sun occurences and if so kill the timeline
    [self sunSatRemoveTimeline];
    if(tempDay != day)
    {
        line1.hidden = YES;
        line2.hidden = YES;
        line3.hidden = YES;
        line4.hidden = YES;
        line5.hidden = YES;
        line6.hidden = YES;
        line7.hidden = YES;
        line8.hidden = YES;
        line9.hidden = YES;
        line10.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sunSatRemoveTimeline {
    //Get the current day
    //Get the current day of the week
    NSString *currentDay = [[NSString alloc]init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"EEEE"];
    currentDay = [dateFormat stringFromDate:[NSDate date]];
    
    if ([currentDay isEqualToString:@"Saturday"] || [currentDay isEqualToString:@"Sunday"]) {
        
        line1.hidden = YES;
        line2.hidden = YES;
        line3.hidden = YES;
        line4.hidden = YES;
        line5.hidden = YES;
        line6.hidden = YES;
        line7.hidden = YES;
        line8.hidden = YES;
        line9.hidden = YES;
        line10.hidden = YES;
    }
}

- (void) timerBegan {
    [NSTimer scheduledTimerWithTimeInterval:60.0 target:self
                                   selector:@selector(implementTimeLine) userInfo:nil repeats:YES];
}


@end