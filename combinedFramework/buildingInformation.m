//
//  buildingInformation.m
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-03-19.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import "buildingInformation.h"

@interface buildingInformation()

@end

@implementation buildingInformation

//Initialize all the UI elements and corresponding values obtained from the cells passed values from buildingTableViews
@synthesize foodTitle, buildingName, address, mondayHrs, tuesdayHrs, wednesdayHrs, thursdayHrs, fridayHrs, saturdayHrs, sundayHrs, weekdaylblDinning, breakfastlblHours, lunchlblHours, dinnerlblHours, extraBreakfastlblHours, extraDinnerlblHours, extraLunchlblHours, extraWeekdaylblDinning, weekendBreakfastlblHours,weekendDinnerlblHours, weekendlblDinning, weekendLunchlblHours, mondaylbl, tuesdaylbl, wednesdaylbl, thursdaylbl, fridaylbl, saturdaylbl, sundaylbl, banLunch, banDinner, banBreakfast, weekdaylblBreakfast, weekdaylblDinner, weekdaylblLunch, extralblBreakfast, extralblDinner, extralblLunch, weekendlblBreakfast, weekendlblDinner, weekendlblLunch, line01, line02, line03, line04, line05, line, line2, line21, line22, line31, line32, picView;

- (void)viewDidLoad {
    [super viewDidLoad];
    //Set the initials - these strings already contain the cells info
    foodTitle.text = self.foodTitleString;
    buildingName.text = self.buildingNameString;
    address.text = self.addressString;
    //The following cases are for the dinning halls to control UI elements as they have non-standard hours
    if([self.valueDetermine isEqualToString:@"1"])
    {
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
        
        //Leonard Hall
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
        
        
    }
    else if ([self.valueDetermine isEqualToString:@"2"])
    {
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
    else if ([self.valueDetermine isEqualToString:@"3"])
    {
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
    else if ([self.valueDetermine isEqualToString:@"4"])
    {
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
        dinnerlblHours.text = @"7:30 PM - MIDNIGHT";
        //Friday
        extraWeekdaylblDinning.text = @"Friday";
        extraBreakfastlblHours.text = @"9:30 AM - 11:00 AM";
        extraLunchlblHours.text = @"2:00 PM - 4:30 PM";
        extraDinnerlblHours.text = @"7:00 PM - MIDNIGHT";
        //Weekend
        weekendlblDinning.text = @"Saturday - Sunday";
        weekendlblBreakfast.text = @"Afternoons";
        weekendBreakfastlblHours.text = @"2:00 PM - 4:30 PM";
        weekendlblLunch.text = @"Saturday Evening";
        weekendLunchlblHours.text = @"7:00 PM - MIDNIGHT";
        weekendDinnerlblHours.text = @"7:30 PM - MIDNIGHT";
        weekendlblDinner.text = @"Sunday Evening";
    }
    //Otherwise if it is not a dinning hall load the corresponding UI elements and map values given from the program to them
    else
    {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
