//
//  buildingInformation.h
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-03-19.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface buildingInformation : UITableViewController

//All the UI elements and correponding value elements that will be needed for each food service to map them to each other correctly
//Most values are obtained from the buildingsTableView when the cell info is passed on here such as valueDetermine, foodTitleString, etc..
@property (weak, nonatomic) IBOutlet UINavigationItem *mytableview;
@property (strong, nonatomic) IBOutlet UILabel *foodTitle;
@property (strong, nonatomic) IBOutlet UILabel *buildingName;
@property (strong, nonatomic) IBOutlet UITextView *address;
@property (strong, nonatomic) IBOutlet UILabel *mondayHrs;
@property (strong, nonatomic) IBOutlet UILabel *tuesdayHrs;
@property (strong, nonatomic) IBOutlet UILabel *wednesdayHrs;
@property (strong, nonatomic) IBOutlet UILabel *thursdayHrs;
@property (strong, nonatomic) IBOutlet UILabel *fridayHrs;
@property (strong, nonatomic) IBOutlet UILabel *saturdayHrs;
@property (strong, nonatomic) IBOutlet UILabel *sundayHrs;

//Regular label titles
@property (strong, nonatomic) IBOutlet UILabel *mondaylbl;
@property (strong, nonatomic) IBOutlet UILabel *tuesdaylbl;
@property (strong, nonatomic) IBOutlet UILabel *wednesdaylbl;
@property (strong, nonatomic) IBOutlet UILabel *thursdaylbl;
@property (strong, nonatomic) IBOutlet UILabel *fridaylbl;
@property (strong, nonatomic) IBOutlet UILabel *saturdaylbl;
@property (strong, nonatomic) IBOutlet UILabel *sundaylbl;

//exclusive label titles
@property (strong, nonatomic) IBOutlet UILabel *banBreakfast;
@property (strong, nonatomic) IBOutlet UILabel *banLunch;
@property (strong, nonatomic) IBOutlet UILabel *banDinner;

//Dinning Halls
@property (strong, nonatomic) IBOutlet UILabel *weekdaylblDinning;
@property (strong, nonatomic) IBOutlet UILabel *breakfastlblHours;
@property (strong, nonatomic) IBOutlet UILabel *lunchlblHours;
@property (strong, nonatomic) IBOutlet UILabel *dinnerlblHours;
@property (strong, nonatomic) IBOutlet UILabel *weekdaylblBreakfast;
@property (strong, nonatomic) IBOutlet UILabel *weekdaylblLunch;
@property (strong, nonatomic) IBOutlet UILabel *weekdaylblDinner;

@property (strong, nonatomic) IBOutlet UILabel *extralblBreakfast;
@property (strong, nonatomic) IBOutlet UILabel *extralblLunch;
@property (strong, nonatomic) IBOutlet UILabel *extralblDinner;
@property (strong, nonatomic) IBOutlet UILabel *weekendlblBreakfast;
@property (strong, nonatomic) IBOutlet UILabel *weekendlblLunch;
@property (strong, nonatomic) IBOutlet UILabel *weekendlblDinner;

@property (strong, nonatomic) IBOutlet UILabel *extraWeekdaylblDinning;
@property (strong, nonatomic) IBOutlet UILabel *extraBreakfastlblHours;
@property (strong, nonatomic) IBOutlet UILabel *extraLunchlblHours;
@property (strong, nonatomic) IBOutlet UILabel *extraDinnerlblHours;

@property (strong, nonatomic) IBOutlet UILabel *weekendlblDinning;
@property (strong, nonatomic) IBOutlet UILabel *weekendBreakfastlblHours;
@property (strong, nonatomic) IBOutlet UILabel *weekendLunchlblHours;
@property (strong, nonatomic) IBOutlet UILabel *weekendDinnerlblHours;

@property (strong, nonatomic) NSString *foodTitleString;
@property (strong, nonatomic) NSString *buildingNameString;
@property (strong, nonatomic) NSString *addressString;
@property (strong, nonatomic) NSString *valueDetermine;

@property (strong, nonatomic) NSString *mondayhrsString;
@property (strong, nonatomic) NSString *tuesdayhrsString;
@property (strong, nonatomic) NSString *wednesdayhrsString;
@property (strong, nonatomic) NSString *thursdayhrsString;
@property (strong, nonatomic) NSString *fridayhrsString;
@property (strong, nonatomic) NSString *saturdayhrsString;
@property (strong, nonatomic) NSString *sundayhrsString;

//Aesthetic lining views
    //regular
@property (weak, nonatomic) IBOutlet UIView *line01;
@property (weak, nonatomic) IBOutlet UIView *line02;
@property (weak, nonatomic) IBOutlet UIView *line03;
@property (weak, nonatomic) IBOutlet UIView *line04;
@property (weak, nonatomic) IBOutlet UIView *line05;

    //dining halls
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line21;
@property (weak, nonatomic) IBOutlet UIView *line22;
@property (weak, nonatomic) IBOutlet UIView *line31;
@property (weak, nonatomic) IBOutlet UIView *line32;

@property (strong, nonatomic) IBOutlet UIImageView *picView;



@end
