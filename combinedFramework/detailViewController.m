//
//  detailViewController.m
//  mapKitR1.0
//
//  Created by Rony Besprozvanny on 2015-06-28.
//  Copyright (c) 2015 Rony. All rights reserved.
//

#import "detailViewController.h"

@implementation detailViewController

//Initialize all the UI elements and corresponding values obtained from the cells passed values from buildingTableViews
@synthesize foodTitle, buildingName, address, mondayHrs, tuesdayHrs, wednesdayHrs, thursdayHrs, fridayHrs, saturdayHrs, sundayHrs, weekdaylblDinning, breakfastlblHours, lunchlblHours, dinnerlblHours, extraBreakfastlblHours, extraDinnerlblHours, extraLunchlblHours, extraWeekdaylblDinning, weekendBreakfastlblHours,weekendDinnerlblHours, weekendlblDinning, weekendLunchlblHours, mondaylbl, tuesdaylbl, wednesdaylbl, thursdaylbl, fridaylbl, saturdaylbl, sundaylbl, banLunch, banDinner, banBreakfast, weekdaylblBreakfast, weekdaylblDinner, weekdaylblLunch, extralblBreakfast, extralblDinner, extralblLunch, weekendlblBreakfast, weekendlblDinner, weekendlblLunch, line01, line02, line03, line04, line05, line, line2, line21, line22, line31, line32, picView, statusLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    //Set the initials - these strings already contain the cells info
    foodTitle.text = self.foodTitleString;
    buildingName.text = self.buildingNameString;
    address.text = self.addressString;
    
    NSCalendar *gregCalend = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComp = [gregCalend components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    int weekdayNum = (int)[dateComp weekday];
    
    NSString *analysisString;
    if (weekdayNum == 2)
        analysisString = self.mondayhrsString;
   else if (weekdayNum == 3)
       analysisString = self.tuesdayhrsString;
    else if (weekdayNum == 4)
        analysisString = self.wednesdayhrsString;
    else if (weekdayNum == 5)
        analysisString = self.thursdayhrsString;
    else if (weekdayNum == 6)
        analysisString = self.fridayhrsString;
    else if (weekdayNum == 7)
        analysisString = self.saturdayhrsString;
    else  // sunday is represented by 1
        analysisString = self.sundayhrsString;
    
    
    // Now grab current time
    NSString *currentHour = [[NSString alloc]init];
    NSString *currentMinute = [[NSString alloc]init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"EEEE"];
    //Get current time
    [dateFormat setDateFormat:@"HH"];
    currentHour = [dateFormat stringFromDate:[NSDate date]];
    [dateFormat setDateFormat:@"mm"];
    currentMinute = [dateFormat stringFromDate:[NSDate date]];
    //Convert values to ints and get correct info
    int currentHourInt = [currentHour intValue];
    currentHourInt = currentHourInt*100;
    int currentMinuteInt = [currentMinute intValue];
    
    int currentTimeInt = currentHourInt + currentMinuteInt;

    NSLog(@"%d", currentTimeInt);
    
    //The following cases are for the dinning halls to control UI elements as they have non-standard hours
    if([self.foodTitleString isEqualToString:@"Leonard Dining Hall"])
    {
        // Check if the caf is open or closed
        statusLabel.text = [self checkTimesForCafs:analysisString currentTime:currentTimeInt];
        
        weekdaylblDinning.text = @"Monday - Thursday";
        breakfastlblHours.text = @"N/A";
        lunchlblHours.text = @"11:00 AM - 2:00 PM";
        dinnerlblHours.text = @"4:30 PM - 8:00 PM";
        //Friday
        extraWeekdaylblDinning.text = @"Friday";
        extraBreakfastlblHours.text = @"N/A";
        extraLunchlblHours.text = @"11:00 AM - 2:00 PM";
        extraDinnerlblHours.text = @"4:30 PM - 7:00 PM";
        //Weekend
        weekendlblDinning.text = @"Saturday - Sunday";
        weekendBreakfastlblHours.text = @"9:30 AM - 11:30 AM";
        weekendLunchlblHours.text = @"11:30 AM - 4:30 PM";
        weekendDinnerlblHours.text = @"4:30 PM - 7:30 PM";
        //Show Lenny photo
        [picView setImage:[UIImage imageNamed:@"Lenny.jpg"]];
        
        //Hide all unused lbls
        mondayHrs.hidden = YES;
        tuesdayHrs.hidden = YES;
        wednesdayHrs.hidden = YES;
        thursdayHrs.hidden = YES;
        fridayHrs.hidden = YES;
        saturdayHrs.hidden = YES;
        sundayHrs.hidden = YES;
        mondaylbl.hidden = YES;
        tuesdaylbl.hidden = YES;
        wednesdaylbl.hidden = YES;
        thursdaylbl.hidden = YES;
        fridaylbl.hidden = YES;
        saturdaylbl.hidden = YES;
        sundaylbl.hidden = YES;
        
        //Hide all unused lines
        line01.hidden = YES;
        line02.hidden = YES;
        line03.hidden = YES;
        line04.hidden = YES;
        line05.hidden = YES;
        
        //Unhide all used lines
        line.hidden = NO;
        line2.hidden = NO;
        line21.hidden = NO;
        line22.hidden = NO;
        line31.hidden = NO;
        line32.hidden = NO;
        
    }
    else if ([self.foodTitleString isEqualToString:@"Ban Righ Dining Hall"])
    {
        // Check if the caf is open or closed
        statusLabel.text = [self checkTimesForCafs:analysisString currentTime:currentTimeInt];

        //Ban Righ Hall
        //Show Ban Righ photo
        [picView setImage:[UIImage imageNamed:@"Ban.jpg"]];
        //Weekday
        weekdaylblDinning.text = @"Monday - Friday";
        breakfastlblHours.text = @"7:30 AM - 10:00 AM";
        lunchlblHours.text = @"11:00 AM - 3:00 PM";
        dinnerlblHours.text = @"4:30 PM - 7:00 PM";
        //Weekend
        weekendlblDinning.hidden = YES;
        weekendBreakfastlblHours.hidden = YES;
        weekendLunchlblHours.hidden = YES;
        weekendDinnerlblHours.hidden = YES;
        //Weekend
        extraWeekdaylblDinning.text = @"Saturday - Sunday";
        extraBreakfastlblHours.text = @"N/A";
        extraLunchlblHours.text = @"N/A";
        extraDinnerlblHours.text = @"N/A";
        
        //Hide all unused lbls
        mondayHrs.hidden = YES;
        tuesdayHrs.hidden = YES;
        wednesdayHrs.hidden = YES;
        thursdayHrs.hidden = YES;
        fridayHrs.hidden = YES;
        saturdayHrs.hidden = YES;
        sundayHrs.hidden = YES;
        mondaylbl.hidden = YES;
        tuesdaylbl.hidden = YES;
        wednesdaylbl.hidden = YES;
        thursdaylbl.hidden = YES;
        fridaylbl.hidden = YES;
        saturdaylbl.hidden = YES;
        sundaylbl.hidden = YES;
        weekendlblLunch.hidden = YES;
        weekendlblDinner.hidden = YES;
        weekendlblBreakfast.hidden = YES;
        
        //Hide all unused lines
        line01.hidden = YES;
        line02.hidden = YES;
        line03.hidden = YES;
        line04.hidden = YES;
        line05.hidden = YES;
        
        
        //Unhide all used lines
        line.hidden = NO;
        line2.hidden = NO;
        line21.hidden = NO;
        line22.hidden = NO;
        line31.hidden = YES;
        line32.hidden = YES;
        
    }
    else if ([self.foodTitleString isEqualToString:@"Jean Royce Dining Hall"])
    {
        // Check if the caf is open or closed
        statusLabel.text = [self checkTimesForCafs:analysisString currentTime:currentTimeInt];

        //Jean Royce Hall
        //Show Lenny photo
        [picView setImage:[UIImage imageNamed:@"Jean.jpg"]];
        //Hide all unused lbls
        mondayHrs.hidden = YES;
        tuesdayHrs.hidden = YES;
        wednesdayHrs.hidden = YES;
        thursdayHrs.hidden = YES;
        fridayHrs.hidden = YES;
        saturdayHrs.hidden = YES;
        sundayHrs.hidden = YES;
        mondaylbl.hidden = YES;
        tuesdaylbl.hidden = YES;
        wednesdaylbl.hidden = YES;
        thursdaylbl.hidden = YES;
        fridaylbl.hidden = YES;
        saturdaylbl.hidden = YES;
        sundaylbl.hidden = YES;
        
        //Hide all unused lines
        line01.hidden = YES;
        line02.hidden = YES;
        line03.hidden = YES;
        line04.hidden = YES;
        line05.hidden = YES;
        
        
        //Unhide all used lines
        line.hidden = NO;
        line2.hidden = NO;
        line21.hidden = NO;
        line22.hidden = NO;
        line31.hidden = NO;
        line32.hidden = NO;
        
        //Dinning Hall
        weekdaylblDinning.text = @"Monday - Thursday";
        breakfastlblHours.text = @"7:30 AM - 9:30 AM";
        lunchlblHours.text = @"11:00 AM - 2:00 PM";
        dinnerlblHours.text = @"4:30 PM - 7:30 PM";
        //Friday
        extraWeekdaylblDinning.text = @"Friday";
        extraBreakfastlblHours.text = @"7:30 AM - 9:30 AM";
        extraLunchlblHours.text = @"11:00 AM - 2:00 PM";
        extraDinnerlblHours.text = @"4:30 PM - 7:00 PM";
        //Weekend
        weekendlblDinning.text = @"Saturday - Sunday";
        weekendBreakfastlblHours.text = @"9:30 AM - 11:30 AM";
        weekendLunchlblHours.text = @"11:30 AM - 2:00 PM";
        weekendDinnerlblHours.text = @"4:30 PM - 7:30 PM";
        weekendlblDinner.text = @"Dinner (Saturday)";
        
    }
    else if ([self.foodTitleString isEqualToString:@"Barista Bar"])
    {
        // Check if the caf is open or closed
        statusLabel.text = [self checkTimesForCafs:analysisString currentTime:currentTimeInt];
        
        //Jean Royce Hall Barista Bar
        //Show Jean Royce photo
        [picView setImage:[UIImage imageNamed:@"Jean2.jpg"]];
        //Hide all unused lbls
        mondayHrs.hidden = YES;
        tuesdayHrs.hidden = YES;
        wednesdayHrs.hidden = YES;
        thursdayHrs.hidden = YES;
        fridayHrs.hidden = YES;
        saturdayHrs.hidden = YES;
        sundayHrs.hidden = YES;
        mondaylbl.hidden = YES;
        tuesdaylbl.hidden = YES;
        wednesdaylbl.hidden = YES;
        thursdaylbl.hidden = YES;
        fridaylbl.hidden = YES;
        saturdaylbl.hidden = YES;
        sundaylbl.hidden = YES;
        
        //Hide all unused lines
        line01.hidden = YES;
        line02.hidden = YES;
        line03.hidden = YES;
        line04.hidden = YES;
        line05.hidden = YES;
        
        //Unhide all used lines
        line.hidden = NO;
        line2.hidden = NO;
        line21.hidden = NO;
        line22.hidden = NO;
        line31.hidden = NO;
        line32.hidden = NO;
        
        //Dinning Hall
        weekdaylblDinning.text = @"Monday - Thursday";
        breakfastlblHours.text = @" 9:30 AM - 11:00 AM";
        lunchlblHours.text = @"2:00 PM - 4:30 PM";
        dinnerlblHours.text = @"7:30 PM - 12:00 AM";
        //Friday
        extraWeekdaylblDinning.text = @"Friday";
        extraBreakfastlblHours.text = @"9:30 AM - 11:00 AM";
        extraLunchlblHours.text = @"2:00 PM - 4:30 PM";
        extraDinnerlblHours.text = @"7:00 PM - 12:00 AM";
        //Weekend
        weekendlblDinning.text = @"Saturday - Sunday";
        weekendlblBreakfast.text = @"Afternoons";
        weekendBreakfastlblHours.text = @"2:00 PM - 4:30 PM";
        weekendlblLunch.text = @"Saturday Evening";
        weekendLunchlblHours.text = @"7:00 PM - 12:00 AM";
        weekendDinnerlblHours.text = @"7:30 PM - 12:00 AM";
        weekendlblDinner.text = @"Sunday Evening";
    }
    //Otherwise if it is not a dinning hall load the corresponding UI elements and map values given from the program to them
    else
    {
        statusLabel.text = [self checkTimesAndImplementOpenFeature:analysisString currentTime:currentTimeInt];
        
        //Hide what is not needed
        weekdaylblDinning.hidden = YES;
        weekdaylblBreakfast.hidden = YES;
        weekdaylblLunch.hidden = YES;
        weekdaylblDinner.hidden = YES;
        extraWeekdaylblDinning.hidden = YES;
        extralblBreakfast.hidden = YES;
        extralblLunch.hidden = YES;
        extralblDinner.hidden = YES;
        weekendlblDinning.hidden = YES;
        weekendlblDinner.hidden = YES;
        weekendlblBreakfast.hidden = YES;
        weekendlblLunch.hidden = YES;
        breakfastlblHours.hidden = YES;
        lunchlblHours.hidden = YES;
        dinnerlblHours.hidden = YES;
        extraDinnerlblHours.hidden = YES;
        extraBreakfastlblHours.hidden = YES;
        extraLunchlblHours.hidden = YES;
        weekendLunchlblHours.hidden = YES;
        weekendBreakfastlblHours.hidden = YES;
        weekendDinnerlblHours.hidden = YES;
        
        //Hide all unused lines
        line01.hidden = NO;
        line02.hidden = NO;
        line03.hidden = NO;
        line04.hidden = NO;
        line05.hidden = NO;
        
        //Unhide all used lines
        line.hidden = YES;
        line2.hidden = YES;
        line21.hidden = YES;
        line22.hidden = YES;
        line31.hidden = YES;
        line32.hidden = YES;
        
        //Get the correct image depending on the building
        if([buildingName.text isEqualToString:@"ARC"])
            //Show ARC photo
            [picView setImage:[UIImage imageNamed:@"qc.jpg"]];
        else if([buildingName.text isEqualToString:@"Bio Science Atrium"]|| [buildingName.text isEqualToString:@"Bio Science Complex"])
            [picView setImage:[UIImage imageNamed:@"bioSci.jpg"]];
        else if ([buildingName.text isEqualToString:@"JDUC"])
            [picView setImage:[UIImage imageNamed:@"JDUC.jpg"]];
        else if([buildingName.text containsString:@"Mac Corry"])
            [picView setImage:[UIImage imageNamed:@"mac1.jpg"]];
        else if ([buildingName.text isEqualToString:@"Victoria Hall"])
            [picView setImage:[UIImage imageNamed:@"lazy.jpg"]];
        else if ([buildingName.text isEqualToString:@"Goodes Hall"])
            [picView setImage:[UIImage imageNamed:@"goodes.jpg"]];
        else if ([buildingName.text isEqualToString:@"Stauffer Library"])
            [picView setImage:[UIImage imageNamed:@"stauff.jpg"]];
        else if ([buildingName.text containsString:@"Gord's Fresh"])
            [picView setImage:[UIImage imageNamed:@"gords.jpg"]];
        else if ([buildingName.text isEqualToString:@"New Medical Building"])
            [picView setImage:[UIImage imageNamed:@"newMed.jpg"]];
        else if ([buildingName.text isEqualToString:@"Botterell Hall"])
            [picView setImage:[UIImage imageNamed:@"botterel.jpg"]];
        //Set the labels text to the passed on cell text
        mondayHrs.text = self.mondayhrsString;
        tuesdayHrs.text = self.tuesdayhrsString;
        wednesdayHrs.text = self.wednesdayhrsString;
        thursdayHrs.text = self.thursdayhrsString;
        fridayHrs.text = self.fridayhrsString;
        saturdayHrs.text = self.saturdayhrsString;
        sundayHrs.text = self.sundayhrsString;
    }
}

- (NSString *) checkTimesAndImplementOpenFeature: (NSString *) analysisString currentTime: (int) currentTimeInt
{
    NSString *outputString = [[NSString alloc]init];
    // First check if the analysis string is closed - if it is just return closed
    if ([analysisString isEqualToString:@"Closed"])
    {
        outputString = @"Closed";
        return outputString;
    }
    
    // We want to now take the string and break it up so that we get start and end time
    NSArray *buildingTimes = [analysisString componentsSeparatedByString:@"-"];
    //Start time
    // Now from here we take and remove the ':'
    NSArray *startTimeArray = [buildingTimes[0] componentsSeparatedByString:@":"];
    // Now I want to join the 0th and 1st index together
    NSString *startHour = startTimeArray[0];
    NSString *startTime = [[NSString alloc] initWithFormat:@"%@%@", startTimeArray[0], startTimeArray[1]];
    NSLog(@"%@", startTime);
    
    startTimeArray = [startTime componentsSeparatedByString:@" "];
    int startTimeValue = [startTimeArray[0] intValue];
    
    if ([startTime rangeOfString:@"PM"].location != NSNotFound || [startTime rangeOfString:@"PM"].location != NSNotFound)
    {
        //If 12 do nothing
        if (![startHour isEqualToString:@"12"])
        {
            // Add 12 hours to total time
            startTimeValue += 1200;
        }
    }
    else if ([startTime containsString:@"AM"] && [startHour isEqualToString:@"12"])
    {
        startTimeValue -= 1200;
    }
    
    NSLog(@"%d", startTimeValue);
    
    // Now repeat and get the end time
    // Now from here we take and remove the ':'
    NSArray *endTimeArray = [buildingTimes[1] componentsSeparatedByString:@":"];
    // Now I want to join the 0th and 1st index together
    NSString *endHour = endTimeArray[0];
    NSString *endTime = [[NSString alloc] initWithFormat:@"%@%@", endTimeArray[0], endTimeArray[1]];
    NSLog(@"%@", endTime);
    // Now we take away the AM/PM from string by parsing until first space
    endTimeArray = [endTime componentsSeparatedByString:@" "];
    int endTimeValue = [endTimeArray[1] intValue];
    
    if ([endTime rangeOfString:@"PM"].location != NSNotFound || [endTime rangeOfString:@"PM"].location != NSNotFound)
    {
        if (![endHour isEqualToString:@"12"])
        {
            // Add 12 hours to total time
            endTimeValue += 1200;
        }
    }
    else if ([endTime rangeOfString:@"AM"].location != NSNotFound && [endHour containsString:@"12"]) //because of space
    {
        endTimeValue -= 1200;
    }
    NSLog(@"%d", endTimeValue);
    
    // Now check to see if the current time is greater than the start time and less than the end timegreater than end time
    
    // If we see that current time is over the 24 hour mark then we go ahead and make another specifal if for it
    if (endTimeValue < startTimeValue && currentTimeInt < endTimeValue) {
        return @"Open";
    }
    if (endTimeValue < startTimeValue  && currentTimeInt > startTimeValue)
    {
        // This means that it goes past midnight so in this case the currentTime has to be less than both
        return @"Open";
    }
    else if (startTimeValue < currentTimeInt && endTimeValue > currentTimeInt) {
        NSLog(@"Open");
        return @"Open";
    }
    else
    {
        NSLog(@"Closed");
        return @"Closed";
    }
}

- (NSString *) checkTimesForCafs: (NSString *) analysisString currentTime: (int) currentTimeInt
{
    
    // For the building status feature
    // First we want to go ahead and spit based on the commas
    NSArray *keyValuesArray = [analysisString componentsSeparatedByString:@","];
    // First val index to be stored here
    int firstVal = 0;
    // Now check the first value that has a space in it - this is a time value
    // This gives amount of keys present
    for (int i = 0; i < keyValuesArray.count; i++) {
        if ([keyValuesArray[i] rangeOfString:@" "].location != NSNotFound && [keyValuesArray[i] containsString:@"-"])
        {
            firstVal = i;
            break;
        }
    }
    NSLog(@"%d", firstVal);
    NSString *outputString = [[NSString alloc] init];
    if (firstVal == 0)
    {
        outputString = @"Closed";
        return outputString;
    }
    
    // Now we want to check all indexes after first index to find the times and if it falls within range
    for (int i = firstVal; i < keyValuesArray.count; i++)
    {
        if ([keyValuesArray[i] rangeOfString:@"N/A"].location == NSNotFound) {
            // Get the start and end time exactly as done below and compare
            outputString = [self checkTimesAndImplementOpenFeature:keyValuesArray[i] currentTime:currentTimeInt];
        }
        if ([outputString containsString:@"Open"])
        {
            return @"Open";
        }
    }
    return outputString;
}

@end
