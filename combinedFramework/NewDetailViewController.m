//
//  NewDetailViewController.m
//  combinedFramework
//
//  Created by Rony Besprozvanny and Zachary Yale on 2015-08-19.
//  Copyright (c) 2016 QTap Project. All rights reserved.
//

#import "NewDetailViewController.h"
#import "detailViewCells.h"
#import "AppDelegate.h"
#import <MapKit/MapKit.h>

@interface NewDetailViewController ()
{
    NSString *analysisStringVar;
}

@end

@implementation NewDetailViewController
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tableView.delegate = self;
    tableView.dataSource = self;
}


# pragma mark - Table View Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([delegate.buildingSettingFilter isEqualToString:@"Food Services"]) {
        return 4;
    }
    else
    {
        //Academic Buildings
        return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([delegate.buildingSettingFilter isEqualToString:@"Food Services"]) {
        if ([self.buildingNameString containsString:@"Leonard"] || [self.buildingNameString containsString:@"Ban Righ"] || [self.buildingNameString containsString:@"Jean Royce"] || [self.buildingNameString containsString:@"Barista"]) {
            // So index 0 is still 60, index 2 is 363
            if (indexPath.section == 3) {
                if ([self.buildingNameString containsString:@"Jean Royce"] || [self.buildingNameString containsString:@"Barista"] || [self.buildingNameString containsString:@"Leonard"]) {
                    // THIS IS THE HEIGHT OF THE EXTENDED HOURS (SPECIAL) CELL (THE ONE THAT HAS MON-THURS) - IF YOU CHANGED HEIGHTS IN STORYBOARD PLEASE ADJUST
                    return 479;
                }
                else
                {
                    // THIS IS THE HEIGHT OF THE EXTENDED HOURS (SPECIAL) 2 CELL (THE ONE THAT HAS MON-FRI) - IF YOU CHANGED HEIGHTS IN STORYBOARD PLEASE ADJUST
                    return 363;
                }
            }
            else if (indexPath.section == 2) {
                // THIS IS THE CURRENT HOURS CELL FOR THE CAFETERIAS - IF YOU CHANGED HEIGHTS IN STORYBOARD PLEASE ADJUST
                return 113;
            }
            else if (indexPath.section == 1)
            {
                // THIS IS THE HEIGHT OF THE ADDRESS CELL - IF YOU CHANGED HEIGHTS IN STORYBOARD PLEASE ADJUST
                return 60;
            }
            else
            {
                // This is the header cell
                return 200;
            }
        }
        else
        {
            //Set the height of the cells to 60
            if (indexPath.section == 1 || indexPath.section == 2)
                // THIS IS THE HEIGHT OF THE ADDRESS CELL AND INDEXPATH.SECTION == 1 IS THE CURRENT HOURS CELL (NOT SPECIAL) - IF YOU CHANGED HEIGHTS IN STORYBOARD PLEASE ADJUST
                return 60;
            else if (indexPath.section == 3)
                // THIS IS THE HEIGHT OF THE EXTENDED HOURS (REGULAR) CELL - IF YOU CHANGED HEIGHTS IN STORYBOARD PLEASE ADJUST
                return 215;
            else
                // This is the header cell
                return 200;
        }
    }
    else
    {
        // Academic buildings
        if (indexPath.section == 2) {
            // THIS IS THE HEIGHT OF THE BIO CELL - IF YOU CHANGED HEIGHTS IN STORYBOARD PLEASE ADJUST
            return 450;
        }
        else if (indexPath.section == 1)
            // THIS IS THE HEIGHT OF THE ADDRESS CELL - IF YOU CHANGED HEIGHTS IN STORYBOARD PLEASE ADJUST
            return 60;
        else
            // This is the header cell
            return 200;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    detailViewCells *cell;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // Regardless of filter the address cell and the header cell are always present and is always section 0 and 1
    if (indexPath.section == 0)
    {
        // Display the address
        cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell" forIndexPath:indexPath];
        cell.lblTitle.text = self.foodTitleString;
        cell.lblSubtitle.text = self.buildingNameString;
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        if ([delegate.buildingSettingFilter isEqualToString:@"Food Services"])
        {
            //Get the correct image depending on the building
            if([self.buildingNameString isEqualToString:@"ARC"])
                //Show ARC photo
                [cell.picView setImage:[UIImage imageNamed:@"qc.jpg"]];
            else if([self.buildingNameString isEqualToString:@"David C. Smith House"])
                [cell.picView setImage:[UIImage imageNamed:@"Smith-House-Exterior.jpg"]];
            else if([self.buildingNameString isEqualToString:@"Beamish Munro Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"Tea Room.jpeg"]];
            else if([self.buildingNameString isEqualToString:@"Bio Science Atrium"]|| [self.buildingNameString isEqualToString:@"Bio Science Complex"])
                [cell.picView setImage:[UIImage imageNamed:@"bioSci.jpg"]];
            else if ([self.buildingNameString isEqualToString:@"JDUC"])
                [cell.picView setImage:[UIImage imageNamed:@"JDUC.jpg"]];
            else if([self.buildingNameString containsString:@"Mac Corry"])
                [cell.picView setImage:[UIImage imageNamed:@"mac1.jpg"]];
            else if ([self.buildingNameString isEqualToString:@"Victoria Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"lazy.jpg"]];
            else if ([self.buildingNameString isEqualToString:@"Goodes Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"goodes.jpg"]];
            else if ([self.buildingNameString isEqualToString:@"Stauffer Library"])
                [cell.picView setImage:[UIImage imageNamed:@"stauff.jpg"]];
            else if ([self.buildingNameString containsString:@"Gord's Fresh"])
                [cell.picView setImage:[UIImage imageNamed:@"gords.jpg"]];
            else if ([self.buildingNameString isEqualToString:@"New Medical Building"])
                [cell.picView setImage:[UIImage imageNamed:@"newMed.jpg"]];
            else if ([self.buildingNameString isEqualToString:@"Botterell Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"botterel.jpg"]];
            else if ([self.buildingNameString containsString:@"Leonard"])
                [cell.picView setImage:[UIImage imageNamed:@"Lenny.jpg"]];
            else if ([self.buildingNameString containsString:@"Ban Righ"])
                [cell.picView setImage:[UIImage imageNamed:@"Ban.jpg"]];
            else if ([self.buildingNameString containsString:@"Jean Royce"])
                [cell.picView setImage:[UIImage imageNamed:@"Jean.jpg"]];
            else if ([self.buildingNameString containsString:@"Barista"])
                [cell.picView setImage:[UIImage imageNamed:@"Jean2.jpg"]];
            
            // Current time and open/close feature
            NSCalendar *gregCalend = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *dateComp = [gregCalend components:NSCalendarUnitWeekday fromDate:[NSDate date]];
            int weekdayNum = (int)[dateComp weekday];
            
            if (weekdayNum == 2)
                analysisStringVar = self.mondayhrsString;
            else if (weekdayNum == 3)
                analysisStringVar = self.tuesdayhrsString;
            else if (weekdayNum == 4)
                analysisStringVar = self.wednesdayhrsString;
            else if (weekdayNum == 5)
                analysisStringVar = self.thursdayhrsString;
            else if (weekdayNum == 6)
                analysisStringVar = self.fridayhrsString;
            else if (weekdayNum == 7)
                analysisStringVar = self.saturdayhrsString;
            else  // sunday is represented by 1
                analysisStringVar = self.sundayhrsString;
            
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
            
            // Check open status and display information
            if ([self.buildingNameString containsString:@"Leonard"] || [self.buildingNameString containsString:@"Ban Righ"] || [self.buildingNameString containsString:@"Jean Royce"] || [self.buildingNameString containsString:@"Barista"])
            {
                NSString *outputString = [self checkTimesForCafs:analysisStringVar currentTime:currentTimeInt];
                //Check if it says open or closed
                if ([outputString containsString:@"Open"]) {
                    cell.lblStatus.textColor = [UIColor colorWithRed:(66/255.0) green:(213/255.0) blue:(82/255.0) alpha:1.0];
                }
                else
                {
                    cell.lblStatus.textColor = [UIColor redColor];
                }
                cell.lblStatus.text = outputString;
            }
            else
            {
                NSString *outputString = [self checkTimesAndImplementOpenFeature:analysisStringVar currentTime:currentTimeInt];
                //Check if it says open or closed
                if ([outputString containsString:@"Open"]) {
                    cell.lblStatus.textColor = [UIColor colorWithRed:(66/255.0) green:(213/255.0) blue:(82/255.0) alpha:1.0];
                }
                else
                {
                    cell.lblStatus.textColor = [UIColor redColor];
                }
                cell.lblStatus.text = outputString;
            }
        }
        else
        {
            // Academic buildings
            cell.lblStatus.text = @"";
            
            // Now for the Academic Buildings Filter - The foodTitleString is actually the service name in this case its the building name
            if([self.foodTitleString isEqualToString:@"ASUS Core"])
                [cell.picView setImage:[UIImage imageNamed:@"ASUS.png"]];
            else if([self.foodTitleString isEqualToString:@"Abramsky Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"abramskyhall.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Adelaide Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"adelaide-hall1.jpg"]];
            else if([self.buildingNameString isEqualToString:@"Queens Recreation Centre"])
                [cell.picView setImage:[UIImage imageNamed:@"qc.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Agnes Etherington Art Centre"])
                [cell.picView setImage:[UIImage imageNamed:@"outsidenight.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Beamish-Munro Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"eng-ilc.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Biosciences Complex"])
                [cell.picView setImage:[UIImage imageNamed:@"BioScience Complex.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Botterell Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"botterell.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Brant House Residence"])
                [cell.picView setImage:[UIImage imageNamed:@"BrantRes.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Bruce Wing"])
                [cell.picView setImage:[UIImage imageNamed:@"BruceMiller.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Carruthers Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"carruthers.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Cataraqui Building"])
                [cell.picView setImage:[UIImage imageNamed:@"cataraqui.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Chernoff Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"ChernoffHall.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Chown Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"chown.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Craine Building"])
                [cell.picView setImage:[UIImage imageNamed:@"AB_CraineBuilding.jpg"]];
            else if([self.foodTitleString isEqualToString:@"David C. Smith House Residence"])
                [cell.picView setImage:[UIImage imageNamed:@"Smith-House-Exterior.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Donald Gordon Centre"])
                [cell.picView setImage:[UIImage imageNamed:@"DonaldGordon.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Douglas Library"])
                [cell.picView setImage:[UIImage imageNamed:@"DouglasLibrary.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Duncan McArthur Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"DuncanMcArthur.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Dunning Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"DunningHall.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Dupuis Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"DupuisHall.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Earl Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"earlHall.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Ellis Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"EllisHall.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Etherington Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"etherington.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Goodes Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"goodes.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Goodwin Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"goodwin.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Gordon Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"gordon-hall.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Gordon-Brockington Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"gordon-brock.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Grant Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"Granthall.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Harkness International Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"harkness.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Harrison-LeCaine Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"b-harris.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Humphrey Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"HumphreyHall.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Jackson Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"JacksonHall.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Jeffery Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"jeffery.jpg"]];
            else if([self.foodTitleString isEqualToString:@"John Deutsch University Centre"])
                [cell.picView setImage:[UIImage imageNamed:@"JDUC.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Joseph S. Stauffer Library"])
                [cell.picView setImage:[UIImage imageNamed:@"stauffer.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Kingston Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"KingstonHall.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Lasalle Building"])
                [cell.picView setImage:[UIImage imageNamed:@"lasalle-building.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Leggett Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"LeggettHall.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Louis D. Action Building"])
                [cell.picView setImage:[UIImage imageNamed:@"louisDActon.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Mackintosh-Corry Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"MacCorry.jpg"]];
            else if([self.foodTitleString isEqualToString:@"McLaughlin Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"MclaughinHall.jpg"]];
            else if([self.foodTitleString isEqualToString:@"McNeill House"])
                [cell.picView setImage:[UIImage imageNamed:@"McNeillHouse.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Miller Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"BruceMiller.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Morris Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"MorrisHall.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Nicol Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"NicolHall.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Old Medical Building"])
                [cell.picView setImage:[UIImage imageNamed:@"OldMedBuilding.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Ontario Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"ontariohall.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Rideau Building"])
                [cell.picView setImage:[UIImage imageNamed:@"rideau.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Robert Sutherland Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"RobertSutherlandHall.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Sir John A. Macdonald Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"macdonald.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Stirling Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"Stirling1.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Waldron Tower"])
                [cell.picView setImage:[UIImage imageNamed:@"Waldron.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Walter Light Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"WalterLight.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Watson Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"WatsonHall.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Watts Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"WattsRes.jpg"]];
            else if([self.foodTitleString isEqualToString:@"Victoria Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"vic-hall.jpg"]];
            else if ([self.foodTitleString isEqualToString:@"Leonard Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"Lenny.jpg"]];
            else if ([self.foodTitleString isEqualToString:@"Ban Righ Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"Ban.jpg"]];
            else if ([self.foodTitleString isEqualToString:@"Jean Royce Hall"])
                [cell.picView setImage:[UIImage imageNamed:@"Jean.jpg"]];
            else
                // SET ALL OTHERS TO QUEENS LOGO
                [cell.picView setImage:[UIImage imageNamed:@"QueensLogo.png"]];
        }

    }
    if (indexPath.section == 1)
    {
        // Display the address
        cell = [tableView dequeueReusableCellWithIdentifier:@"addressCell" forIndexPath:indexPath];
        cell.lblAddress.text = self.addressString;
    }
    if ([delegate.buildingSettingFilter isEqualToString:@"Food Services"])
    {
        if ([self.buildingNameString containsString:@"Leonard"] || [self.buildingNameString containsString:@"Ban"] || [self.buildingNameString containsString:@"Jean Royce"] || [self.buildingNameString containsString:@"Barista"]) {
            
            if (indexPath.section == 2) {
                // Current cafeteria hours
                cell = [tableView dequeueReusableCellWithIdentifier:@"curHoursCellSpecial" forIndexPath:indexPath];
                // First we want to go ahead and spit based on the commas
                NSArray *keyValuesArray = [analysisStringVar componentsSeparatedByString:@","];
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
                    if ([keyValuesArray[i] rangeOfString:@"N/A"].location != NSNotFound) {
                        firstVal = i;
                        break;
                    }
                }
                int count = 0;
                // Now we want to check all indexes after first index to find the times and if it falls within range
                for (int i = firstVal; i < keyValuesArray.count; i++)
                {
                    if ([keyValuesArray[i] rangeOfString:@"N/A"].location == NSNotFound) {
                        // Get the start and end time exactly as done below and compare
                        switch (count) {
                            case 0:
                                cell.lblCurBreakfastTimes.text = keyValuesArray[i];
                                cell.lblCurBreakfast.text = keyValuesArray[i-firstVal];
                                // Account for the empties
                                if ([cell.lblCurBreakfast.text isEqualToString:@"EMPTY"]) {
                                    cell.lblCurBreakfast.text = @"";
                                    cell.lblCurBreakfastTimes.text = @"";
                                }
                                
                                break;
                            case 1:
                                cell.lblCurLunchTimes.text = keyValuesArray[i];
                                cell.lblCurLunch.text = keyValuesArray[i-firstVal];
                                // Account for the empties
                                if ([cell.lblCurLunch.text isEqualToString:@"EMPTY"]) {
                                    cell.lblCurLunch.text = @"";
                                    cell.lblCurLunchTimes.text = @"";
                                }

                                break;
                            case 2:
                                cell.lblCurDinnerTimes.text = keyValuesArray[i];
                                cell.lblCurDinner.text = keyValuesArray[i-firstVal];
                                // Account for the empties
                                if ([cell.lblCurDinner.text isEqualToString:@"EMPTY"]) {
                                    cell.lblCurDinner.text = @"";
                                    cell.lblCurDinnerTimes.text = @"";
                                }
                            default:
                                break;
                        }
                        count ++;
                    }
                    else
                    {
                        switch (count) {
                            case 0:
                                cell.lblCurBreakfastTimes.text = @"N/A";
                                cell.lblCurBreakfast.text = keyValuesArray[i-firstVal];

                                break;
                            case 1:
                                cell.lblCurLunchTimes.text = @"N/A";
                                cell.lblCurLunch.text = keyValuesArray[i-firstVal];
                                
                                break;
                            case 2:
                                cell.lblCurDinnerTimes.text = @"N/A";
                                cell.lblCurDinner.text = keyValuesArray[i-firstVal];
                                
                                break;
                                
                            default:
                                break;
                        }
                        count++;
                    }
                }
            }
            else if (indexPath.section == 3)
            {
                // Extended cafeteria hours
                // Varies between special 1 and special 2
                // ONLY FOR BAN IS MON-FRI ALL OTHERS ARE MON-THURS
                if ([self.buildingNameString containsString:@"Jean Royce"] || [self.buildingNameString containsString:@"Barista"] || [self.buildingNameString containsString:@"Leonard"]) {
                    cell = [tableView dequeueReusableCellWithIdentifier:@"regHoursSpecial" forIndexPath:indexPath];
                }
                else
                    cell = [tableView dequeueReusableCellWithIdentifier:@"regHoursSpecial2" forIndexPath:indexPath];
                
                // Here is where we need to go through each day and get the corresponding times for it
                // Create an array that contains all strings and then loop through each
                NSArray *everydayTimes = [[NSArray alloc] initWithObjects:self.mondayhrsString, self.tuesdayhrsString, self.wednesdayhrsString, self.thursdayhrsString, self.fridayhrsString, self.saturdayhrsString, self.sundayhrsString, nil];
                int x = 0;
                while (x < everydayTimes.count)
                {
                    // Inner loop
                    // First we want to go ahead and spit based on the commas
                    NSArray *keyValuesArray = [everydayTimes[x] componentsSeparatedByString:@","];
                    // First val index to be stored here
                    int firstVal = 0;
                    // Now check the first value that has a space in it - this is a time value
                    // This gives amount of keys present
                    for (int i = 0; i < keyValuesArray.count; i++)
                    {
                        if ([keyValuesArray[i] rangeOfString:@" "].location != NSNotFound && [keyValuesArray[i] containsString:@"-"])
                        {
                            firstVal = i;
                            break;
                        }
                        if ([keyValuesArray[i] rangeOfString:@"N/A"].location != NSNotFound) {
                            firstVal = i;
                            break;
                        }
                    }
                    int count = 0;
                    // For the Monday-Friday ones -> Ban Righ and Lenny
                    // Now we want to check all indexes after first index to find the times and if it falls within range
                    for (int i = firstVal; i < keyValuesArray.count; i++)
                    {
                        if ([keyValuesArray[i] rangeOfString:@"N/A"].location == NSNotFound)
                        {
                            // Get the start and end time exactly as done below and compare
                            switch (count) {
                                case 0:
                                    if ([self.buildingNameString containsString:@"Jean Royce"] || [self.buildingNameString containsString:@"Barista"] || [self.buildingNameString containsString:@"Leonard"])
                                    {
                                        if (x <= 3)
                                        {
                                            // Mon - Thurs
                                            cell.lblBreakfastMonThursTimes.text = keyValuesArray[i];
                                            cell.lblBreakfastMonThurs.text = keyValuesArray[i-firstVal];
                                            break;
                                        }
                                        else if (x == 4)
                                        {
                                            // Friday
                                            cell.lblBreakfastFridayTimes.text = keyValuesArray[i];
                                            cell.lblBreakfastFriday.text = keyValuesArray[i-firstVal];
                                            break;
                                        }
                                    }
                                    else
                                    {
                                        if (x <= 4)
                                        {
                                            // Mon- Fri
                                            cell.lblBreakfastWeekdayTimes.text = keyValuesArray[i];
                                            cell.lblBreakfastWeekday.text = keyValuesArray[i-firstVal];
                                            break;
                                        }

                                    }
                                    // Weekends - universal to both types of extended cafeteria hours
                                    if (x == 5)
                                    {
                                        // Saturday
                                        cell.lblSatBreakfastTimes.text = keyValuesArray[i];
                                        cell.lblSatBreakfast.text = keyValuesArray[i-firstVal];
                                        break;
                                    }
                                    else
                                    {
                                        // Sunday
                                        cell.lblSunBreakfastTimes.text = keyValuesArray[i];
                                        cell.lblSunBreakfast.text = keyValuesArray[i-firstVal];
                                        break;
                                    }
                                case 1:
                                    if ([self.buildingNameString containsString:@"Jean Royce"] || [self.buildingNameString containsString:@"Barista"] || [self.buildingNameString containsString:@"Leonard"])
                                    {
                                        if (x <= 3)
                                        {
                                            // Mon - Thurs
                                            cell.lblLunchMonThursTimes.text = keyValuesArray[i];
                                            cell.lblLunchMonThurs.text = keyValuesArray[i-firstVal];
                                            break;
                                        }
                                        else if (x == 4)
                                        {
                                            // Friday
                                            cell.lblLunchFridayTimes.text = keyValuesArray[i];
                                            cell.lblLunchFriday.text = keyValuesArray[i-firstVal];
                                            break;
                                        }
                                    }
                                    else
                                    {
                                        if (x <= 4)
                                        {
                                            // Mon- Fri
                                            cell.lblLunchWeekdayTimes.text = keyValuesArray[i];
                                            cell.lblLunchWeekday.text = keyValuesArray[i-firstVal];
                                            break;
                                        }
                                        
                                    }
                                    // Weekends - universal to both types of extended cafeteria hours
                                    if (x == 5)
                                    {
                                        // Saturday
                                        cell.lblSatLunchTimes.text = keyValuesArray[i];
                                        cell.lblSatLunch.text = keyValuesArray[i-firstVal];
                                        break;
                                    }
                                    else
                                    {
                                        // Sunday
                                        cell.lblSunLunchTimes.text = keyValuesArray[i];
                                        cell.lblSunLunch.text = keyValuesArray[i-firstVal];
                                        // Account for the empties
                                        if ([cell.lblSunLunch.text isEqualToString:@"EMPTY"]) {
                                            cell.lblSunLunch.text = @"";
                                            cell.lblSunLunchTimes.text = @"";
                                        }
                                        break;
                                    }
                                case 2:
                                    if ([self.buildingNameString containsString:@"Jean Royce"] || [self.buildingNameString containsString:@"Barista"] || [self.buildingNameString containsString:@"Leonard"])
                                    {
                                        if (x <= 3)
                                        {
                                            // Mon - Thurs
                                            cell.lblDinnerMonThursTimes.text = keyValuesArray[i];
                                            cell.lblDinnerMonThurs.text = keyValuesArray[i-firstVal];
                                            break;
                                        }
                                        else if (x == 4)
                                        {
                                            // Friday
                                            cell.lblDinnerFridayTimes.text = keyValuesArray[i];
                                            cell.lblDinnerFriday.text = keyValuesArray[i-firstVal];
                                            break;
                                        }
                                    }
                                    else
                                    {
                                        if (x <= 4)
                                        {
                                            // Mon- Fri
                                            cell.lblDinnerWeekdayTimes.text = keyValuesArray[i];
                                            cell.lblDinnerWeekday.text = keyValuesArray[i-firstVal];
                                            break;
                                        }
                                        
                                    }
                                    // Weekends - universal to both types of extended cafeteria hours
                                    if (x == 5)
                                    {
                                        // Saturday
                                        cell.lblSatDinnerTimes.text = keyValuesArray[i];
                                        cell.lblSatDinner.text = keyValuesArray[i-firstVal];
                                        // Account for the empties
                                        if ([cell.lblSatDinnerTimes.text isEqualToString:@"EMPTY"]) {
                                            cell.lblSatDinner.text = @"";
                                            cell.lblSatDinnerTimes.text = @"";
                                        }
                                        break;
                                    }
                                    else
                                    {
                                        // Sunday
                                        cell.lblSunDinnerTimes.text = keyValuesArray[i];
                                        cell.lblSunDinner.text = keyValuesArray[i-firstVal];
                                        // Account for the empties
                                        if ([cell.lblSunDinnerTimes.text isEqualToString:@"EMPTY"]) {
                                            cell.lblSunDinner.text = @"";
                                            cell.lblSunDinnerTimes.text = @"";
                                        }
                                        break;
                                    }
                                default:
                                    break;
                            }
                            count ++;
                        }
                        else
                        {
                            switch (count) {
                                case 0:
                                    if ([self.buildingNameString containsString:@"Jean Royce"] || [self.buildingNameString containsString:@"Barista"] || [self.buildingNameString containsString:@"Leonard"])
                                    {
                                        if (x <= 3)
                                        {
                                            // Mon - Thurs
                                            cell.lblBreakfastMonThursTimes.text = @"N/A";
                                            cell.lblBreakfastMonThurs.text = keyValuesArray[i-firstVal];
                                            break;
                                        }
                                        else if (x == 4)
                                        {
                                            // Friday
                                            cell.lblBreakfastFridayTimes.text = @"N/A";
                                            cell.lblBreakfastFriday.text = keyValuesArray[i-firstVal];
                                            break;
                                        }
                                    }
                                    else
                                    {
                                        if (x <= 4)
                                        {
                                            // Mon- Fri
                                            cell.lblBreakfastWeekdayTimes.text = @"N/A";
                                            cell.lblBreakfastWeekday.text = keyValuesArray[i-firstVal];
                                            break;
                                        }
                                        
                                    }
                                    // Weekends - universal to both types of extended cafeteria hours
                                    if (x == 5)
                                    {
                                        // Saturday
                                        cell.lblSatBreakfastTimes.text = @"N/A";
                                        cell.lblSatBreakfast.text = keyValuesArray[i-firstVal];
                                        break;
                                    }
                                    else
                                    {
                                        // Sunday
                                        cell.lblSunBreakfastTimes.text = @"N/A";
                                        cell.lblSunBreakfast.text = keyValuesArray[i-firstVal];
                                        break;
                                    }
                                    break;
                                case 1:
                                    if ([self.buildingNameString containsString:@"Jean Royce"] || [self.buildingNameString containsString:@"Barista"] || [self.buildingNameString containsString:@"Leonard"])
                                    {
                                        if (x <= 3)
                                        {
                                            // Mon - Thurs
                                            cell.lblLunchMonThursTimes.text = @"N/A";
                                            cell.lblLunchMonThurs.text = keyValuesArray[i-firstVal];
                                            break;
                                        }
                                        else if (x == 4)
                                        {
                                            // Friday
                                            cell.lblLunchFridayTimes.text = @"N/A";
                                            cell.lblBreakfastFriday.text = keyValuesArray[i-firstVal];
                                            break;
                                        }
                                    }
                                    else
                                    {
                                        if (x <= 4)
                                        {
                                            // Mon- Fri
                                            cell.lblLunchWeekdayTimes.text = @"N/A";
                                            cell.lblLunchWeekday.text = keyValuesArray[i-firstVal];
                                            break;
                                        }
                                        
                                    }
                                    // Weekends - universal to both types of extended cafeteria hours
                                    if (x == 5)
                                    {
                                        // Saturday
                                        cell.lblSatLunchTimes.text = @"N/A";
                                        cell.lblSatLunch.text = keyValuesArray[i-firstVal];
                                        break;
                                    }
                                    else
                                    {
                                        // Sunday
                                        cell.lblSunLunchTimes.text = @"N/A";
                                        cell.lblSunLunch.text = keyValuesArray[i-firstVal];
                                        break;
                                    }
                                case 2:
                                    if ([self.buildingNameString containsString:@"Jean Royce"] || [self.buildingNameString containsString:@"Barista"] || [self.buildingNameString containsString:@"Leonard"])
                                    {
                                        if (x <= 3)
                                        {
                                            // Mon - Thurs
                                            cell.lblDinnerMonThursTimes.text = @"N/A";
                                            cell.lblDinnerMonThurs.text = keyValuesArray[i-firstVal];
                                            break;
                                        }
                                        else if (x == 4)
                                        {
                                            // Friday
                                            cell.lblDinnerFridayTimes.text = @"N/A";
                                            cell.lblDinnerFriday.text = keyValuesArray[i-firstVal];
                                            break;
                                        }
                                    }
                                    else
                                    {
                                        if (x <= 4)
                                        {
                                            // Mon- Fri
                                            cell.lblDinnerWeekdayTimes.text = @"N/A";
                                            cell.lblDinnerWeekday.text = keyValuesArray[i-firstVal];
                                            break;
                                        }
                                        
                                    }
                                    // Weekends - universal to both types of extended cafeteria hours
                                    if (x == 5)
                                    {
                                        // Saturday
                                        cell.lblSatDinnerTimes.text = @"N/A";
                                        cell.lblSatDinner.text = keyValuesArray[i-firstVal];
                                        break;
                                    }
                                    else
                                    {
                                        // Sunday
                                        cell.lblSunDinnerTimes.text = @"N/A";
                                        cell.lblSunDinner.text = keyValuesArray[i-firstVal];
                                        break;
                                    }
                                default:
                                    break;
                            }
                            count++;
                        }
                    }
                    x++;
                }
            }
        }
        else
        {
            // Not a cafeteria so section 1 is the current day hours for the food service and section 2 is the daily Mon-Sun hours
            if (indexPath.section == 2) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"curHoursCellNormal" forIndexPath:indexPath];
                cell.lblCurHours.text = analysisStringVar;
            }
            else if (indexPath.section == 3)
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"regHoursNormal" forIndexPath:indexPath];
                cell.lblMonHrs.text = self.mondayhrsString;
                cell.lblTuesHrs.text = self.tuesdayhrsString;
                cell.lblWedHrs.text = self.wednesdayhrsString;
                cell.lblThursHrs.text = self.thursdayhrsString;
                cell.lblFriHrs.text = self.fridayhrsString;
                cell.lblSatHrs.text = self.saturdayhrsString;
                cell.lblSunHrs.text = self.sundayhrsString;
            }

        }
    }
    else
    {
        // Academic Building
        if (indexPath.section == 2) {
            // This is the bio
            cell = [tableView dequeueReusableCellWithIdentifier:@"bioCell" forIndexPath:indexPath];
            cell.txtBio.text = self.bioString;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // No matter what filter and what option always indexPath.section will be 1 for the address
    if (indexPath.section == 1) {
        // Grab the coordinate - 0 is lat - 1 is long
        // Grab the cell as well to be used for displaying the title in maps
        detailViewCells *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSArray *coordVal = [self.coordStr componentsSeparatedByString:@","];
        double lat = [coordVal[0] doubleValue];
        double longVal = [coordVal[1] doubleValue];
        // Redirect and open the address in maps
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(lat, longVal);
        MKPlacemark *place = [[MKPlacemark alloc] initWithCoordinate:coord addressDictionary:nil];
        MKMapItem *mpItem = [[MKMapItem alloc] initWithPlacemark:place];
        [mpItem setName:self.foodTitleString];
        [mpItem openInMapsWithLaunchOptions:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *) checkTimesAndImplementOpenFeature: (NSString *) analysisString currentTime: (int) currentTimeInt
{
    // IF THE STRING IS EMPTY RETURN CLOSED
    if ([analysisString isEqualToString:@"EMPTY"])
    {
        return @"Status: Closed";
    }
    NSString *outputString = [[NSString alloc]init];
    // First check if the analysis string is closed - if it is just return closed
    if ([analysisString isEqualToString:@"Closed"])
    {
        outputString = @"Status: Closed";
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
        return @"Status: Open";
    }
    if (endTimeValue < startTimeValue  && currentTimeInt > startTimeValue)
    {
        // This means that it goes past midnight so in this case the currentTime has to be less than both
        return @"Status: Open";
    }
    else if (startTimeValue <= currentTimeInt && endTimeValue > currentTimeInt) {
        NSLog(@"Open");
        return @"Status: Open";
    }
    else
    {
        NSLog(@"Closed");
        return @"Status: Closed";
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
        outputString = @"Status: Closed";
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
            return @"Status: Open";
        }
    }
    return outputString;
}

@end
