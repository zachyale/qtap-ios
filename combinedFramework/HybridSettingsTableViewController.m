//
//  HybridSettingsTableViewController.m
//  combinedFramework
//
//  Created by Rony Besprozvanny and Zachary Yale on 2015-08-11.
//  Copyright (c) 2016 QTap Project. All rights reserved.
//

#import "HybridSettingsTableViewController.h"
#import "cellClass.h"
#import "AppDelegate.h"

@interface HybridSettingsTableViewController ()
{
    NSArray *userSettings;
    NSArray *userFilters;
    UISwitch *switchVar;
    UISlider *rangeSlider;
    UILabel *sliderVal;
    int count;
}

@end

@implementation HybridSettingsTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create an array of text elements to display to the user - these are the settings options
    userFilters = [[NSArray alloc] initWithObjects:@"Academic Buildings", @"Food Services", nil];
    userSettings = [[NSArray alloc] initWithObjects:@"Nearby", @"Range", nil];

    count = 0;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 1;
    else if (section == 1)
        return [userFilters count];
    else
        return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Set the height of the cells to 60
    if (indexPath.section == 0 || indexPath.section == 2)
        return 22;
    else
        return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Create the sections and corresponding custom cells
    cellClass *cell;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (indexPath.section == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"sectionSplit0" forIndexPath:indexPath];
    }
    else if (indexPath.section == 1) {
        // These are the filters
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
        if ([delegate.buildingSettingFilter isEqualToString:userFilters[indexPath.row]])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
        cell.lblTitle.text = userFilters[indexPath.row];
        NSLog(@"%@", userFilters[indexPath.row]);
    }
    else if (indexPath.section == 2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"blankID" forIndexPath:indexPath];
    }
    else if (indexPath.section == 3)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"sectionSplit1" forIndexPath:indexPath];
    }
    else if (indexPath.section == 4)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"nearbyID" forIndexPath:indexPath];
        cell.lblTitle.text = userSettings[0];
        if ([cell.lblTitle.text isEqualToString:@"Nearby"]) {
            switchVar = cell.nearbySwitch;
            if ([delegate.buildingSettingsNearbyConfig isEqualToString:@"ON"])
                [switchVar setOn:YES animated:YES];
            else
                [switchVar setOn:NO animated:YES];
        }
    }
    else if (indexPath.section == 5)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"rangeID" forIndexPath:indexPath];
        cell.lblTitle.text = userSettings[1];
        if ([cell.lblTitle.text isEqualToString:@"Range"])
        {
            // This is the range
            rangeSlider = cell.slider;
            rangeSlider.minimumValue = 0.100;
            rangeSlider.maximumValue = 10;
            rangeSlider.value = [delegate.buildingSettingsRange doubleValue];
            sliderVal = cell.lblRangeSlider;
            sliderVal.text = [NSString stringWithFormat:@"%@ km", delegate.buildingSettingsRange];
        }
    }
    
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *cells = [tableView visibleCells];
    if (indexPath.section == 1)
    {
        for (int i = 0; i <= 2; i++)
        {
            if (indexPath.row == i)
            {
                // i + 1 b/c first cell is the "Filters" keyword
                cellClass *cellVal = cells[i + 1];
                cellVal.accessoryType = UITableViewCellAccessoryCheckmark;
                // Now go ahead and save the filter to the AppDelegate
                delegate.buildingSettingFilter = cellVal.lblTitle.text;
            }
            else
            {
                cellClass *cellVal = cells[i + 1];
                cellVal.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    }
}



- (IBAction)switchValueChange:(id)sender {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (switchVar.on)
        delegate.buildingSettingsNearbyConfig = @"ON";
    else
        delegate.buildingSettingsNearbyConfig = @"OFF";
}

- (IBAction)sliderValueChange:(id)sender {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    sliderVal.text = [NSString stringWithFormat:@"%.1f km", rangeSlider.value];
    delegate.buildingSettingsRange = [NSString stringWithFormat:@"%.1f", rangeSlider.value];
    
}

@end
