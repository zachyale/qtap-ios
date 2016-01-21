//
//  detailViewCells.h
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-08-19.
//  Copyright (c) 2015 Queen's University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailViewCells : UITableViewCell

// Header cell
@property (nonatomic, retain) IBOutlet UILabel *lblTitle;
@property (nonatomic, retain) IBOutlet UILabel *lblSubtitle;
@property (nonatomic, retain) IBOutlet UILabel *lblStatus;
@property (strong, nonatomic) IBOutlet UIImageView *picView;

// 
@property (nonatomic, retain) IBOutlet UILabel *lblAddress;
@property (nonatomic, retain) IBOutlet UILabel *lblCurHours;
@property (nonatomic, retain) IBOutlet UILabel *lblMonHrs;
@property (nonatomic, retain) IBOutlet UILabel *lblTuesHrs;
@property (nonatomic, retain) IBOutlet UILabel *lblWedHrs;
@property (nonatomic, retain) IBOutlet UILabel *lblThursHrs;
@property (nonatomic, retain) IBOutlet UILabel *lblFriHrs;
@property (nonatomic, retain) IBOutlet UILabel *lblSatHrs;
@property (nonatomic, retain) IBOutlet UILabel *lblSunHrs;

// Cafeterias
// Current day
@property (nonatomic, retain) IBOutlet UILabel *lblCurBreakfast;
@property (nonatomic, retain) IBOutlet UILabel *lblCurLunch;
@property (nonatomic, retain) IBOutlet UILabel *lblCurDinner;
@property (nonatomic, retain) IBOutlet UILabel *lblCurBreakfastTimes;
@property (nonatomic, retain) IBOutlet UILabel *lblCurLunchTimes;
@property (nonatomic, retain) IBOutlet UILabel *lblCurDinnerTimes;
// Extended view special2 - Lenny and Ban Righ
@property (nonatomic, retain) IBOutlet UILabel *lblBreakfastWeekday;
@property (nonatomic, retain) IBOutlet UILabel *lblLunchWeekday;
@property (nonatomic, retain) IBOutlet UILabel *lblDinnerWeekday;
@property (nonatomic, retain) IBOutlet UILabel *lblBreakfastWeekdayTimes;
@property (nonatomic, retain) IBOutlet UILabel *lblLunchWeekdayTimes;
@property (nonatomic, retain) IBOutlet UILabel *lblDinnerWeekdayTimes;
// Extended view special - Jean Royce and Barista
@property (nonatomic, retain) IBOutlet UILabel *lblBreakfastMonThurs;
@property (nonatomic, retain) IBOutlet UILabel *lblLunchMonThurs;
@property (nonatomic, retain) IBOutlet UILabel *lblDinnerMonThurs;
@property (nonatomic, retain) IBOutlet UILabel *lblBreakfastMonThursTimes;
@property (nonatomic, retain) IBOutlet UILabel *lblLunchMonThursTimes;
@property (nonatomic, retain) IBOutlet UILabel *lblDinnerMonThursTimes;

@property (nonatomic, retain) IBOutlet UILabel *lblBreakfastFriday;
@property (nonatomic, retain) IBOutlet UILabel *lblLunchFriday;
@property (nonatomic, retain) IBOutlet UILabel *lblDinnerFriday;
@property (nonatomic, retain) IBOutlet UILabel *lblBreakfastFridayTimes;
@property (nonatomic, retain) IBOutlet UILabel *lblLunchFridayTimes;
@property (nonatomic, retain) IBOutlet UILabel *lblDinnerFridayTimes;

// Universal across all cafs
@property (nonatomic, retain) IBOutlet UILabel *lblSatBreakfast;
@property (nonatomic, retain) IBOutlet UILabel *lblSatLunch;
@property (nonatomic, retain) IBOutlet UILabel *lblSatDinner;
@property (nonatomic, retain) IBOutlet UILabel *lblSatBreakfastTimes;
@property (nonatomic, retain) IBOutlet UILabel *lblSatLunchTimes;
@property (nonatomic, retain) IBOutlet UILabel *lblSatDinnerTimes;

@property (nonatomic, retain) IBOutlet UILabel *lblSunBreakfast;
@property (nonatomic, retain) IBOutlet UILabel *lblSunLunch;
@property (nonatomic, retain) IBOutlet UILabel *lblSunDinner;
@property (nonatomic, retain) IBOutlet UILabel *lblSunBreakfastTimes;
@property (nonatomic, retain) IBOutlet UILabel *lblSunLunchTimes;
@property (nonatomic, retain) IBOutlet UILabel *lblSunDinnerTimes;


@property (nonatomic, retain) IBOutlet UITextView *txtBio;

@end
