//
//  dashboardNew.m
//  webViewTest
//
//  Created by Zachary Yale and Rony Besprozvanny on 2015-08-14.
//  Copyright (c) 2016 QTap Project. All rights reserved.
//

#define IS_IPHONE_LEGACY ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.width - ( double )320 ) < DBL_EPSILON )

#import "dashboardNew.h"
#import "dashboardCell.h"
#import "AppDelegate.h"
#import "moreInfoDashboardTableViewController.h"

@interface dashboardNew ()
{
    // Non-engineering specific
    EKCalendar *subCal;
    NSString *codeDate;
    
    NSMutableArray *classImgArry;
    NSArray *imgArry;
    
    NSMutableArray *classSchedTodayBeforeMultipleCalculate;
    // Engineering specific
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
    
    NSArray *times;
    
    NSArray *classArray;
    NSArray *roomArry;
    NSArray *typeArry;
    
    int day;
    int tempDay;
    NSString *buttonTitle;
}

@property (nonatomic, strong) NSMutableArray *classSchedToday;
@property (nonatomic, strong) EKEventStore *eventStore;


@end

@implementation dashboardNew

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![delegate.loginTutorialPassed isEqualToString:@"YES"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome to QTap" message:@"Please note that it may take up to 10 seconds for your schedule to appear upon first use. If it does not appear please press the next button in the Dashboard" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        // Also set the date
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM/dd/yyyy"];
            
        delegate.userLoginDate = [dateFormat stringFromDate:[NSDate date]];
        // Set to YES to not see this again until the conditions become true
        delegate.loginTutorialPassed = @"YES";
    }
    self.eventStore = [[EKEventStore alloc] init];
    self.classSchedToday = [[NSMutableArray alloc]init];
    classSchedTodayBeforeMultipleCalculate = [[NSMutableArray alloc] init];
    codeDate = [[NSString alloc] init];
    imgArry = [[NSArray alloc] initWithObjects:@"NavyCircle-64.png",@"GreenCircle-64.png",@"OrangeCircle-64.png",@"RedCircle-64.png",@"PurpleCircle-64.png", @"BlueCircle-64.png",@"GoldCircle-64.png",@"TealCircle-64.png", @"NavyCircle-64.png",@"GreenCircle-64.png",@"OrangeCircle-64.png",@"RedCircle-64.png",@"PurpleCircle-64.png", @"BlueCircle-64.png", nil];

    classImgArry = [[NSMutableArray alloc] init];
   
    NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitSecond fromDate:[NSDate date]];
    NSInteger second = [components second];
    NSInteger secTillMin = (60 - second) % 60;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self performSelector:@selector(timerBegan) withObject:self afterDelay:secTillMin];
}

- (void) viewDidAppear:(BOOL)animated
{
    NSLog(@"%@", codeDate);
    [super viewDidAppear:YES];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // Check for permissions and grab events if access granted otherwise alert user
    [self checkAuthorization];
    [self continueWithApp];
    
    // Update if its winter or fall sem

    // More permanent solution
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

    
        /*

        // Check which semester and update
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //if ([delegate.userTypeActive isEqualToString:@"non-engineering"]) {
        if (self.classSchedToday.count == 0 || self.classSchedToday == nil) {
            return 1;
        }
        else
            
            return self.classSchedToday.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (self.classSchedToday.count == 0 || self.classSchedToday == nil) {
            // Regular cell to be displayed with no class today contents
            return 55;
        }
        else if ([[self.classSchedToday objectAtIndex:indexPath.row] isKindOfClass:[NSString class]] == TRUE) {
            // Regular size to return 50
            return 55;
        }
        else
        {
            // Could be either 1, 2 or three hour cell
            NSDate *stDate = [[self.classSchedToday objectAtIndex:indexPath.row]startDate];
            NSDate *endDate = [[self.classSchedToday objectAtIndex:indexPath.row]endDate];
            
            // Dev test - Get the difference between the two dates
            NSTimeInterval diffStEnd = [endDate timeIntervalSinceDate:stDate];
            if (diffStEnd <= 3600) {
                // Initialize regular cell
                return 55;
            }
            else if (diffStEnd > 3600 && diffStEnd <= 7200)
            {
                // THIS IS THE 2 HOUR CELL - IF SIZE CHANGED IN STORYBOARD CHANGE IT HERE
                return 110;
            }
            else
            {
                // THIS IS THE 3 HOUR CELL - IF SIZE CHANGED IN STORYBOARD CHANGE IT HERE
                return 165;
            }
        }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    dashboardCell *cell;
    cell.singleLine.hidden = NO;
    cell.doubleLine.hidden = NO;
    cell.tripleLine.hidden = NO;
    if (self.classSchedToday.count == 0 || self.classSchedToday == nil)
    {
        // Regular cell display for no synced days
        cell = [tableView dequeueReusableCellWithIdentifier:@"dashCell" forIndexPath:indexPath];
        cell.lblClass.text = @"";
        cell.lblClassType.text = @"";
        cell.lblStart.text = @"";
        cell.lblEnd.text = @"";
        cell.lblLocation.text = @"";
        cell.lblLocationEngineering.hidden = YES;
        cell.lineView.hidden = YES;
        cell.courseImg.hidden = YES;
        cell.singleLine.hidden = YES;
        cell.doubleLine.hidden = YES;
        cell.tripleLine.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lblNoClass.text = @"You have no events synced today!";
        return cell;
    }
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    // Get the current time
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    
    NSString *currentHour = [[NSString alloc] init];
    NSString *currentMinute = [[NSString alloc] init];
    int currentHourInt = 0;
    int currentMinuteInt = 0;
    int currentTimeInt = 0;
    [dateFormat setDateFormat:@"EEEE"];
    //Get current time
    [dateFormat setDateFormat:@"HH"];
    currentHour = [dateFormat stringFromDate:[NSDate date]];
    [dateFormat setDateFormat:@"mm"];
    currentMinute = [dateFormat stringFromDate:[NSDate date]];
    //Convert values to ints and get correct info
    currentHourInt = [currentHour intValue];
    currentHourInt = currentHourInt*100;
    currentMinuteInt = [currentMinute intValue];
    currentTimeInt = currentHourInt + currentMinuteInt;
    
    // For holding the start and end time date objects
    NSDate *stDate = [[NSDate alloc] init];
    NSDate *endDate = [[NSDate alloc] init];
    if ([[self.classSchedToday objectAtIndex:indexPath.row] isKindOfClass:[NSString class]] == TRUE) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"dashCell" forIndexPath:indexPath];
        cell.lblClass.text = @"";
        cell.lblLocation.text = @"";
        cell.lblLocationEngineering.text = @"";
        cell.lblClassType.text = @"";
        cell.lineView.hidden = YES;
        cell.courseImg.hidden = YES;
        cell.singleLine.hidden = NO;
        cell.doubleLine.hidden = NO;
        cell.tripleLine.hidden = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *stEndTimesBlank = [[self.classSchedToday objectAtIndex:indexPath.row] componentsSeparatedByString:@","];
        // For the blank cells convert the start and end times of the cell to date objects and get their hour min int values
        [dateFormat setDateFormat:@"HH:mm"];
        stDate = [dateFormat dateFromString:stEndTimesBlank[0]];
        endDate = [dateFormat dateFromString:stEndTimesBlank[1]];
        [dateFormat setDateFormat:@"hh"];
        // This will parse out the "0" if present in the day
        int startHour = [[dateFormat stringFromDate:stDate] intValue];
        // Get the minutes as a string
        [dateFormat setDateFormat:@"mm"];
        NSString *startMinutes = [dateFormat stringFromDate:stDate];
        // Now get the full string
        NSString *startTime = [[NSString alloc] initWithFormat:@"%d:%@", startHour, startMinutes];
        // Repeat for end time
        [dateFormat setDateFormat:@"hh"];
        // This will parse out the "0" if present in the day
        int endHour = [[dateFormat stringFromDate:endDate] intValue];
        // Get the minutes as a string
        [dateFormat setDateFormat:@"mm"];
        NSString *endMinutes = [dateFormat stringFromDate:endDate];
        NSString *endTime = [[NSString alloc] initWithFormat:@"%d:%@", endHour, endMinutes];
        
        cell.lblStart.text = startTime;
        cell.lblEnd.text = endTime;
    }
    else
    {
        NSString *classTitle = [[self.classSchedToday objectAtIndex:indexPath.row]title];
        
        NSArray *spaceSeperate = [classTitle componentsSeparatedByString:@" "];
        // We want to go until the second space
        NSString *classTitleProp = [[NSString alloc] initWithFormat:@"%@ %@", spaceSeperate[0], spaceSeperate[1]];
        NSLog(@"%@", classTitleProp);
        EKStructuredLocation *location = [[self.classSchedToday objectAtIndex:indexPath.row] structuredLocation];
        
        stDate = [[self.classSchedToday objectAtIndex:indexPath.row]startDate];
        endDate = [[self.classSchedToday objectAtIndex:indexPath.row]endDate];
        
        // Dev test - Get the difference between the two dates
        NSTimeInterval diffStEnd = [endDate timeIntervalSinceDate:stDate];
        if (diffStEnd <= 3600) {
            // Initialize regular cell
            cell = [tableView dequeueReusableCellWithIdentifier:@"dashCell" forIndexPath:indexPath];
        }
        else if (diffStEnd > 3600 && diffStEnd <= 7200)
        {
            // Initialize the two hour cell
            cell = [tableView dequeueReusableCellWithIdentifier:@"dashCellTwoHour" forIndexPath:indexPath];
            
        }
        else
        {
            // Initialize the 3+ hour cell
            cell = [tableView dequeueReusableCellWithIdentifier:@"dashCellThreeHour" forIndexPath:indexPath];
        }
        
        // For the detail disclosure button
        BOOL isDisclosure = NO;
        if ((indexPath.row + 1) < classSchedTodayBeforeMultipleCalculate.count) {
            if ([[classSchedTodayBeforeMultipleCalculate objectAtIndex:(indexPath.row + 1)]isKindOfClass:[NSString class]] == TRUE) {
                // Check if its a blank or if its a location store
                if ([[classSchedTodayBeforeMultipleCalculate objectAtIndex:(indexPath.row + 1) ] rangeOfString:@":"].location == NSNotFound) {
                    // This is the correct string - add detail disclosure and add the selection ability
                    isDisclosure = YES;
                }
            }
        }
        
        // Populate cell contents
        cell.lblClass.text = classTitleProp;
        if (isDisclosure == YES) {
            cell.lblLocation.text = @"Various Rooms";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        }
        else
        {
            cell.lblLocation.text = location.title;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        cell.lblLocationEngineering.hidden = YES;
        
        // Format for 12 HR time display to users
        
        [dateFormat setDateFormat:@"hh"];
        // This will parse out the "0" if present in the day
        int startHour = [[dateFormat stringFromDate:stDate] intValue];
        // Get the minutes as a string
        [dateFormat setDateFormat:@"mm"];
        NSString *startMinutes = [dateFormat stringFromDate:stDate];
        // Now get the full string
        NSString *startTime = [[NSString alloc] initWithFormat:@"%d:%@", startHour, startMinutes];
        // Repeat for end time
        [dateFormat setDateFormat:@"hh"];
        // This will parse out the "0" if present in the day
        int endHour = [[dateFormat stringFromDate:endDate] intValue];
        // Get the minutes as a string
        [dateFormat setDateFormat:@"mm"];
        NSString *endMinutes = [dateFormat stringFromDate:endDate];
        NSString *endTime = [[NSString alloc] initWithFormat:@"%d:%@", endHour, endMinutes];
        
        cell.lblStart.text = startTime;
        cell.lblEnd.text = endTime;
        
        cell.lblClassType.text = @"";
        
        // Check if the class is in the array and if it is then assign it the proper image
        if ([classImgArry containsObject:classTitleProp]) {
            // Get the index of occurence
            NSUInteger ind = [classImgArry indexOfObject:classTitleProp];
            // Add the corresponding image
            cell.courseImg.hidden = NO;
            cell.courseImg.image = [UIImage imageNamed:[imgArry objectAtIndex:ind]];
        }
        else
            cell.courseImg.hidden = YES;
        
        if(IS_IPHONE_LEGACY)
        {
            //remove images if device is an iPhone 5S/Older
            cell.singleClassConstraint.constant = 8;
            cell.doubleClassConstraint.constant = 8;
            cell.tripleClassConstraint.constant = 8;
            cell.courseImg.hidden = YES;
        }
    }
    
    // Disable the no class label
    cell.lblNoClass.text = @"";
    // This is for the timeline - applicable to both
    // ONLY ALLOW TIMELINE IF ON THE CURRENT DAY - FOR NON-ENGINEERING CHECK FULL DATE AND FOR ENGINEERING JUST CHECK DAY
    BOOL allowTimeline = NO;
        // Grab the current date and format it to a string
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSString *curDate = [dateFormat stringFromDate:[NSDate date]];
        if ([curDate isEqualToString:codeDate]) {
            // Allow timeline
            allowTimeline = YES;
        }
    
    if (allowTimeline == YES) {
        // Calculate if the current time lies within the start and end time of the cell
        // Grab the start time and end time as an int
        // Grab the hours
        [dateFormat setDateFormat:@"HH"];
        int startHour = [[dateFormat stringFromDate:stDate] intValue] * 100;
        int endHour = [[dateFormat stringFromDate:endDate] intValue] * 100;
        // Grab the minutes
        [dateFormat setDateFormat:@"mm"];
        int startMin = [[dateFormat stringFromDate:stDate] intValue];
        int endMin = [[dateFormat stringFromDate:endDate] intValue];
        
        int startTimeInt = startHour + startMin;
        int endTimeInt = endHour + endMin;
        
        // Compare
        if (currentTimeInt >= startTimeInt && currentTimeInt < endTimeInt)
        {
            cell.lineView.hidden = NO;
        }
        else
        {
            cell.lineView.hidden = YES;
        }
    }
    else
        // Hide the line
        cell.lineView.hidden = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //If the user selects a search cell perform the detailViewSegue segue - defined in the prepareForSegue func
    // Get the correct cell
    //dashboardCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ((indexPath.row + 1) < classSchedTodayBeforeMultipleCalculate.count) {
        if ([[classSchedTodayBeforeMultipleCalculate objectAtIndex:(indexPath.row + 1)]isKindOfClass:[NSString class]] == TRUE) {
            // Check if its a blank or if its a location store
            if ([[classSchedTodayBeforeMultipleCalculate objectAtIndex:(indexPath.row + 1) ] rangeOfString:@":"].location == NSNotFound) {
                // This is the correct cell so go ahead and set its selection style
                dashboardCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                // Now go ahead and prep the segue
                [self performSegueWithIdentifier:@"moreClassInfo" sender:self];
            }
        }
    }
}

//Called when user selected a cell either search cell or regular and the specific cell "sub-view" needs to be pushed
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"moreClassInfo"])
    {
        NSLog(@"TRANSITIONING TO NEW VIEW");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        // The correct cell info would be 1 more
        NSString *locations = [classSchedTodayBeforeMultipleCalculate objectAtIndex:(indexPath.row + 1)];
        NSString *classTitle = [[classSchedTodayBeforeMultipleCalculate objectAtIndex:indexPath.row] title];
        
        [[segue destinationViewController] setClassTitle:classTitle];
        [[segue  destinationViewController] setClassLocs:locations];
        
    }
}


- (void) calculateBlanks
{
    
    NSMutableArray *todaysClassesComplete = [[NSMutableArray alloc] init];
    int blankCount = 0;
    
    if (self.classSchedToday.count == 0 || self.classSchedToday == nil)
    {
        return;
    }
    
    // Check if user has a class from 8:30 - index 0
    NSDate *startTimeFirstClass = [[self.classSchedToday objectAtIndex:0] startDate];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    NSString *startTimeFirstClassStr = [dateFormat stringFromDate:startTimeFirstClass];
    NSDate *startOfNextEvent = startTimeFirstClass;
    [dateFormat setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSString *eightThirtyStrForm = [[NSString alloc]initWithFormat:@"%@ 08:30", codeDate];
    NSDate *eightThirtyDate = [dateFormat dateFromString:eightThirtyStrForm];
    
    if (![startTimeFirstClassStr isEqualToString:@"08:30"])
    {
        // This is where we will insert the blanks
        // In seconds
        NSTimeInterval diffDates = [startTimeFirstClass timeIntervalSinceDate:eightThirtyDate];
        if (diffDates >= 3600)
        {
            NSLog(@"1 hour or more diff");
            // Add the item here
            int spaceAmount = diffDates/ 3600;
            NSLog(@"%d", spaceAmount);
            if (spaceAmount == 1)
            {
                NSLog(@"1 space");
                NSString *blankString = [[NSString alloc] initWithFormat:@"08:30,%@", startTimeFirstClassStr];
                [todaysClassesComplete addObject:blankString];
                blankCount ++;
            }
            else
            {
                for (int j = 0; j < spaceAmount; j++) {
                    // For adding the hours in between for the cells
                    // Get the startTime of previous in minutes
                    [dateFormat setDateFormat:@"mm"];
                    int timeInterval = 0;
                    // ALWAYS CHECK THE CURRENT REMAINING TIME FOR THE LAST CELL
                    if (spaceAmount - j == 1) {
                        // NVM if its the last blank just go ahead and add the times
                        //eightthirtydate is the current time and startTimeFirstClass is the start of the next event
                        [dateFormat setDateFormat:@"HH:mm"];
                        NSString *stTime = [dateFormat stringFromDate:eightThirtyDate];
                        NSString *endTime = [dateFormat stringFromDate:startOfNextEvent];
                        NSString *blankString = [[NSString alloc] initWithFormat:@"%@,%@", stTime, endTime];
                        [todaysClassesComplete addObject:blankString];
                        blankCount++;
                        break;
                        
                    }
                    int stLastMinVal = [[dateFormat stringFromDate:eightThirtyDate] intValue];
                    if (stLastMinVal == 00)
                        // Go to the 30 of next hour
                        timeInterval = 5400;
                    else if (stLastMinVal == 15)
                        timeInterval = 4500;
                    else if (stLastMinVal == 30)
                        timeInterval = 3600;
                    else if (stLastMinVal == 45)
                        timeInterval = 2700;
                    // Get the next start time as a XX:30 date
                    // The end time will always be one hour away for the transition cells
                    startTimeFirstClass = [eightThirtyDate dateByAddingTimeInterval:timeInterval];
                    // Convert to NSString
                    [dateFormat setDateFormat:@"HH:mm"];
                    NSString *stTime = [dateFormat stringFromDate:eightThirtyDate];
                    NSString *endTimeVal = [dateFormat stringFromDate:startTimeFirstClass];
                    NSString *blankString = [[NSString alloc] initWithFormat:@"%@,%@", stTime, endTimeVal];
                    [todaysClassesComplete addObject:blankString];
                    eightThirtyDate = startTimeFirstClass;
                    blankCount++;
                }
            }
        }
        else if (diffDates > 0 && diffDates < 3600)
        {
            // Just one cell
            NSString *blankString = [[NSString alloc] initWithFormat:@"08:30,%@", startTimeFirstClassStr];
            [todaysClassesComplete addObject:blankString];
            blankCount ++;
        }
    }
    
    for (int i = 0; i < 15; i++)
    {
        // Exception check
        if ((todaysClassesComplete.count - blankCount) == self.classSchedToday.count)
            break;
        
        NSDate *stDate = [[self.classSchedToday objectAtIndex:i]startDate];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"HH:mm"];
        NSString *startTime = [dateFormat stringFromDate:stDate];
        NSLog(@"%@", startTime);
        
        NSDate *endDate = [[self.classSchedToday objectAtIndex:i]endDate];
        NSString *endTime = [dateFormat stringFromDate:endDate];
        NSLog(@"%@", endTime);
        
        // Check if next class exists - exception
        if ((i + 1) >= self.classSchedToday.count) {
            [todaysClassesComplete addObject:self.classSchedToday[i]];
            break;
        }
        // Next class
        NSDate *stDateNext = [[self.classSchedToday objectAtIndex:(i + 1)]startDate];
        [dateFormat setDateFormat:@"HH:mm"];
        NSString *startTime2 = [dateFormat stringFromDate:stDateNext];
        NSLog(@"%@", startTime2);
        
        // In seconds
        NSTimeInterval diffDates = [stDateNext timeIntervalSinceDate:endDate];
        if (diffDates == 0) {
            NSLog(@"0 time diff");
            // Add the item here
            [todaysClassesComplete addObject:self.classSchedToday[i]];
        }
        else
        {
            int spaceAmount = diffDates/ 3600;
            // Space needs to be inserted
            // Get amount of hours
            if (spaceAmount == 1 || spaceAmount == 0) {
                NSLog(@"1 space");
                // Add the class and then the blank
                [todaysClassesComplete addObject:self.classSchedToday[i]];
                NSString *blankString = [[NSString alloc] initWithFormat:@"%@,%@", endTime, startTime2];
                [todaysClassesComplete addObject:blankString];
                blankCount ++;
            }
            else
            {
                NSLog(@"%d", spaceAmount);
                NSDate *startTimePrev = [dateFormat dateFromString:endTime];
                NSDate *endTimeNext;
                NSDate *startOfNextEvent = [dateFormat dateFromString:startTime2];
                [todaysClassesComplete addObject:self.classSchedToday[i]];
                for (int j = 0; j < spaceAmount; j++) {
                    // For adding the hours in between for the cells
                    // Get the startTime of previous in minutes
                    [dateFormat setDateFormat:@"mm"];
                    int timeInterval = 0;
                    // ALWAYS CHECK THE CURRENT REMAINING TIME FOR THE LAST CELL
                    if (spaceAmount - j == 1) {
                        // NVM if its the last blank just go ahead and add the times
                        //eightthirtydate is the current time and startTimeFirstClass is the start of the next event
                        [dateFormat setDateFormat:@"HH:mm"];
                        NSString *stTime = [dateFormat stringFromDate:startTimePrev];
                        NSString *endTime = [dateFormat stringFromDate:startOfNextEvent];
                        NSString *blankString = [[NSString alloc] initWithFormat:@"%@,%@", stTime, endTime];
                        [todaysClassesComplete addObject:blankString];
                        blankCount++;
                        break;
                        
                    }
                    int stLastMinVal = [[dateFormat stringFromDate:startTimePrev] intValue];
                    if (stLastMinVal == 00)
                        // Go to the 30 of next hour
                        timeInterval = 5400;
                    else if (stLastMinVal == 15)
                        timeInterval = 4500;
                    else if (stLastMinVal == 30)
                        timeInterval = 3600;
                    else if (stLastMinVal == 45)
                        timeInterval = 2700;
                    // Get the next start time as a XX:30 date
                    // The end time will always be one hour away for the transition cells
                    endTimeNext = [startTimePrev dateByAddingTimeInterval:timeInterval];
                    // Convert to NSString
                    [dateFormat setDateFormat:@"HH:mm"];
                    NSString *stTime = [dateFormat stringFromDate:startTimePrev];
                    NSString *endTimeVal = [dateFormat stringFromDate:endTimeNext];
                    NSString *blankString = [[NSString alloc] initWithFormat:@"%@,%@", stTime, endTimeVal];
                    [todaysClassesComplete addObject:blankString];
                    startTimePrev = endTimeNext;
                    blankCount++;
                }
            }
        }
        
    }
    // Now replace the contents of the class sched array with this complete array
    // For the images - add all classes to the image array
    for (int j = 0; j < todaysClassesComplete.count; j++) {
        if ([[todaysClassesComplete objectAtIndex:j] isKindOfClass:[NSString class]] == FALSE) {
            NSString *classTitle = [todaysClassesComplete[j]title];
            // Parse out the 001 and mtg
            NSArray *spaceSeperate = [classTitle componentsSeparatedByString:@" "];
            // We want to go until the second space
            NSString *classTitleProp = [[NSString alloc] initWithFormat:@"%@ %@", spaceSeperate[0], spaceSeperate[1]];
            NSLog(@"%@", classTitleProp);
            if (classImgArry == nil || [classImgArry count] == 0) {
                [classImgArry addObject:classTitleProp];
            }
            
            if (![classImgArry containsObject:classTitleProp]) {
                // Add the proper class to the class image array
                [classImgArry addObject:classTitleProp];
            }
            
        }
    }
    self.classSchedToday = todaysClassesComplete;
}


- (void) checkAuthorization
{
    EKAuthorizationStatus stat = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    if (stat == EKAuthorizationStatusAuthorized) {
        [self continueWithApp];
    }
    else if (stat == EKAuthorizationStatusNotDetermined)
    {
        // Request permission
        [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted,NSError* error)
         {
             if (granted) {
                 NSLog(@"Access Granted");
             }
         }];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"You have not granted permission for this app to use your calendar.\nPlease go to Settings -> QTap and allow QTap to use your calendar as otherwise the app will not contain the Dashboard feature." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

- (void) continueWithApp
{
    // Go grab the events
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *currentDate;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    if ([codeDate isEqualToString:@""] || codeDate == nil)
        currentDate = [NSDate date];
    else
        currentDate = [dateFormat dateFromString: codeDate];
    
    NSDate *startDate = [dateFormat dateFromString:@"14/09/2015"];
    NSString *dateToDisplay = [[NSString alloc] init];
    if ([currentDate compare:startDate] == NSOrderedAscending) {
        NSLog(@"Start date bigger");
        dateToDisplay = @"14/09/2015";
    }
    else if ([currentDate compare:startDate] == NSOrderedDescending)
    {
        NSLog(@"Current date bigger");
        dateToDisplay = [dateFormat stringFromDate:currentDate];
    }
    else
    {
        NSLog(@"Dates are the same");
        dateToDisplay = [dateFormat stringFromDate:currentDate];
    }
    // Get events and continue
    self.classSchedToday = [self getTodaySched:dateToDisplay];
    [self calculateBlanks];
    classSchedTodayBeforeMultipleCalculate = [[NSMutableArray alloc] initWithArray:self.classSchedToday];
    [self multipleClassFindSolve];
    // Reload the table view
    [self.tableView reloadData];

}

- (NSMutableArray *) getTodaySched: (NSString *) date
{
    // Delegate to be used for storing users NetID
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *str = date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *stDate = [dateFormat dateFromString: str];
    
    // Generate date components for the start date so it will ouput current day and month and use in the day title bar item
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSCalendarUnitDay| NSCalendarUnitMonth| NSCalendarUnitYear | NSCalendarUnitWeekday fromDate:stDate];
    NSInteger day = [comps day];
    NSInteger month = [comps month];
    NSInteger weekday = [comps weekday];
    
    NSString *currentMonth = [[NSString alloc] init];
    NSString *currentWeekday = [[NSString alloc] init];
    
    // Find the current month
    switch (month) {
        case 1:
            currentMonth = @"January";
            break;
        case 2:
            currentMonth = @"February";
            break;
        case 3:
            currentMonth = @"March";
            break;
        case 4:
            currentMonth = @"April";
            break;
        case 5:
            currentMonth = @"May";
            break;
        case 6:
            currentMonth = @"June";
            break;
        case 7:
            currentMonth = @"July";
            break;
        case 8:
            currentMonth = @"August";
            break;
        case 9:
            currentMonth = @"September";
            break;
        case 10:
            currentMonth = @"October";
            break;
        case 11:
            currentMonth = @"November";
            break;
        case 12:
            currentMonth = @"December";
            break;
        default:
            break;
    }
    
    // Find the current weekday
    switch (weekday) {
        case 1:
            if (IS_IPHONE_LEGACY)
                currentWeekday = @"Sun";
            else
                currentWeekday = @"Sunday";
            break;
        case 2:
            if (IS_IPHONE_LEGACY)
                currentWeekday = @"Mon";
            else
                currentWeekday = @"Monday";
            break;
        case 3:
            if (IS_IPHONE_LEGACY)
                currentWeekday = @"Tues";
            else
                currentWeekday = @"Tuesday";
            break;
        case 4:
            if (IS_IPHONE_LEGACY)
                currentWeekday = @"Wed";
            else
                currentWeekday = @"Wednesday";
            break;
        case 5:
            if (IS_IPHONE_LEGACY)
                currentWeekday = @"Thurs";
            else
                currentWeekday = @"Thursday";
            break;
        case 6:
            if (IS_IPHONE_LEGACY)
                currentWeekday = @"Fri";
            else
                currentWeekday = @"Friday";
            break;
        case 7:
            if (IS_IPHONE_LEGACY)
                currentWeekday = @"Sat";
            else
                currentWeekday = @"Saturday";
            break;
        default:
            break;
    }
    
    NSString *dayTitleString = [[NSString alloc]initWithFormat:@"%@, %@ %ld", currentWeekday, currentMonth, day];
    // code date used across various functions as it gives the current date in dd/mm/yyyy form
    codeDate = str;
    [UINavigationBar animateWithDuration:10.0f animations:^{[self.dayTitle setTitle:dayTitleString forState:UIControlStateNormal];} ];
    
    //Create the end date components
    NSDateComponents *tmrwDateComps = [[NSDateComponents alloc] init];
    tmrwDateComps.day = 1;
    
    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:tmrwDateComps
                                                                    toDate:stDate
                                                                   options:0];
    
    EKEntityType type = EKEntityTypeEvent;
    NSArray *calArry = [self.eventStore calendarsForEntityType:type];
    NSMutableArray *correctCal = [[NSMutableArray alloc] init];
    
    // Now find the just created subscribed one
    for (int i = 0; i < calArry.count; i++) {
        EKCalendar *curCal = [calArry objectAtIndex:i];
        if (curCal.type == EKCalendarTypeSubscription) {
            if ([curCal.title rangeOfString:@"Class Schedule"].location != NSNotFound) {
                NSLog(@"This is the correct calendar. Read events from here");
                [correctCal addObject:curCal];
                // Find the NetID from the title
                NSUInteger ind = [curCal.title rangeOfString:@"Class Schedule"].location;
                delegate.userNetID = [curCal.title substringToIndex:ind];
                break;
            }
        }
    }
    // Conver the mutable array to nsarray
    NSArray *correctCalender = [[NSArray alloc]initWithArray:correctCal];
    // predicate
    NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:stDate endDate:endDate calendars:correctCalender];
    // Grab the events of the day
    // Fetch all events that match the predicate
    NSMutableArray *events = [NSMutableArray arrayWithArray:[self.eventStore eventsMatchingPredicate:predicate]];
    
    return events;
    
}

- (void) multipleClassFindSolve
{
    // Step 1
    int stIndex = 0;
    BOOL hasInit = false;
    int count = 0;
    NSMutableArray *multipleIndCountArry = [[NSMutableArray alloc] init];
    // loop through class array
    for (int i = 0; i < classSchedTodayBeforeMultipleCalculate.count; i++) {
        // Get the two start times and check equality
        // Before check all exceptions
        if ((i+1) >= classSchedTodayBeforeMultipleCalculate.count) {
            if (hasInit == true) {
                // Matches counted - add to multiple array and reset
                NSString *startCountStr = [[NSString alloc] initWithFormat:@"%d,%d", stIndex, count];
                [multipleIndCountArry addObject:startCountStr];
                stIndex = 0;
                count = 0;
            }
            continue;
        }
        if ([classSchedTodayBeforeMultipleCalculate[i] isKindOfClass:[NSString class]] == TRUE || [classSchedTodayBeforeMultipleCalculate[i+1] isKindOfClass:[NSString class]] == TRUE) {
            continue;
        }
        NSDate *stDate = [[classSchedTodayBeforeMultipleCalculate objectAtIndex:i] startDate];
        NSDate *stDate2 = [[classSchedTodayBeforeMultipleCalculate objectAtIndex:(i + 1)] startDate];
        NSTimeInterval diffTimes = [stDate2 timeIntervalSinceDate:stDate];
        if (diffTimes == 0) {
            // MATCH - not that its zero but if it hasn't previously been initialized
            if (hasInit == false) {
                stIndex = i;
                hasInit = true;
            }
            count++;
        }
        else
        {
            if (stIndex != 0) {
                // Matches counted - add to multiple array and reset
                NSString *startCountStr = [[NSString alloc] initWithFormat:@"%d,%d", stIndex, count];
                [multipleIndCountArry addObject:startCountStr];
                stIndex = 0;
                count = 0;
            }
        }
    }
    // Step 2
    NSString *locationsStore = [[NSString alloc] init];
    for (int i = 0; i < multipleIndCountArry.count; i--) {
        // Get the start index and count for the specific element
        NSArray *stIndCountSpecific = [[multipleIndCountArry objectAtIndex:i] componentsSeparatedByString:@","];
        // Ind 0 is start index and ind 1 is count
        int startIndexCur = [stIndCountSpecific[0] intValue];
        int durCur = [stIndCountSpecific[1] intValue];
        // Inner loop
        for (int j = startIndexCur; j <= (startIndexCur + durCur); j++) {
            // Get the current location
            NSString *curString;
            EKStructuredLocation *curLoc = [[classSchedTodayBeforeMultipleCalculate objectAtIndex:j] structuredLocation];
            if (![locationsStore isEqualToString:@""]) {
                curString = [[NSString alloc] initWithFormat:@"%@,%@",locationsStore, curLoc.title];
            }
            else
                curString = curLoc.title;
            
            locationsStore = curString;
        }
        // Now we have the full string so we need to go ahead and delete the dur items and keep the first occurence. After first occurence add the locationsStore string
        NSLog(@"HELLO");
        // Delete from the dur
        for (int x = (durCur + startIndexCur); x > startIndexCur; x--) {
            [classSchedTodayBeforeMultipleCalculate removeObjectAtIndex:x];
            // Delete the objects from regular schedule as well so that it will reflect in cell creation
            [self.classSchedToday removeObjectAtIndex:x];
        }
        // Add in the new locations object
        [classSchedTodayBeforeMultipleCalculate insertObject:locationsStore atIndex:(startIndexCur + 1)];
    }
    NSLog(@"TEST");
    
}

- (IBAction)goToNext:(id)sender {
        NSLog(@"HIT NEXT");
        // We go ahead and change the current day to the next day
        NSString *currentDate = codeDate;
        // Convert to a date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSDate *curDate = [dateFormat dateFromString:currentDate];
        
        // Check if the current date is a friday - if so then go two days ahead
        NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSCalendarUnitDay| NSCalendarUnitMonth| NSCalendarUnitYear | NSCalendarUnitWeekday fromDate:curDate];
        NSInteger weekday = [comps weekday];
        
        // Now we get tomorrow's date
        NSDateComponents *tmrwDateComps = [[NSDateComponents alloc] init];
        // Check happens here
        // To avoid saturday's and sundays
        if (weekday == 6)
        {
            // Friday was the current day so starting date should be three days away
            tmrwDateComps.day = 3;
        }
        else
        {
            // For all other weekdays go to next date
            tmrwDateComps.day = 1;
        }
        
        NSDate *tmrwDate = [[NSCalendar currentCalendar] dateByAddingComponents:tmrwDateComps
                                                                         toDate:curDate
                                                                        options:0];
        NSString *tmrwDateStr = [dateFormat stringFromDate:tmrwDate];
        // Call the fetch schedule method with the proper starting date
        self.classSchedToday = [self getTodaySched:tmrwDateStr];
        [self calculateBlanks];
        classSchedTodayBeforeMultipleCalculate = [[NSMutableArray alloc] initWithArray:self.classSchedToday];
        [self multipleClassFindSolve];
        // Reload the table view
        [self.tableView reloadData];
}

- (IBAction)goBack:(id)sender {
    // We go ahead and change the current day to the previous day
    NSString *currentDate = codeDate;
    // Convert to a date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSDate *curDate = [dateFormat dateFromString:currentDate];
    
    // Check if the current date is a friday - if so then go two days ahead
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSCalendarUnitDay| NSCalendarUnitMonth| NSCalendarUnitYear | NSCalendarUnitWeekday fromDate:curDate];
    NSInteger weekday = [comps weekday];
    
    // Now we get yesterday's date
    NSDateComponents *yesterdayDateComps = [[NSDateComponents alloc] init];
    if (weekday == 2) {
        // This is monday so we need to go back to friday, hence decrease by 3
        yesterdayDateComps.day = -3;
    }
    else
    {
        yesterdayDateComps.day = -1;
    }
    
    NSDate *yesterdayDate = [[NSCalendar currentCalendar] dateByAddingComponents:yesterdayDateComps toDate:curDate options:0];
    NSString *yesterdayDateStr = [dateFormat stringFromDate:yesterdayDate];
    // Call the fetch schedule method with the proper starting date
    self.classSchedToday = [self getTodaySched:yesterdayDateStr];
    [self calculateBlanks];
    classSchedTodayBeforeMultipleCalculate = [[NSMutableArray alloc] initWithArray:self.classSchedToday];
    [self multipleClassFindSolve];
    // Reload the table view
    [self.tableView reloadData];
}

- (IBAction)changeDayCurrent:(id)sender
{
    // Convert to a date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *curDate = [dateFormat stringFromDate:[NSDate date]];
    // Call appropriate methods and update
    self.classSchedToday = [self getTodaySched:curDate];
    [self calculateBlanks];
    classSchedTodayBeforeMultipleCalculate = [[NSMutableArray alloc] initWithArray:self.classSchedToday];
    [self multipleClassFindSolve];
    [self.tableView reloadData];
}


- (void) timerBegan {
    [NSTimer scheduledTimerWithTimeInterval:60.0 target:self
                                   selector:@selector(tableReload) userInfo:nil repeats:YES];
}

- (void) tableReload {
    [self.tableView reloadData];
}


@end
