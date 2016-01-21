//
//  settingsViewControllerPrime.m
//  combinedFramework
//
//  Created by Zachary Yale on 2015-07-23.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CellClass.h"
#import "settingsViewControllerPrime.h"

@implementation settingsViewControllerPrime
{
    NSArray *semesterArray;
    NSArray *fallSectionArray;
    NSArray *winterSectionArray;
    NSArray *facultyArray;
    NSArray *returnArry;
}

- (void)viewDidLoad {
        
    semesterArray = [[NSArray alloc]initWithObjects:@"Fall",@"Winter", nil];
    
    fallSectionArray = [[NSArray alloc]initWithObjects:@"00",@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", nil];
    
    winterSectionArray = [[NSArray alloc]initWithObjects:@"00",@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"J", nil];
    
    facultyArray = [[NSArray alloc]initWithObjects:@"Applied Science", @"Arts and Science", @"School of Business", @"School of Music", @"School of Computing", @"Fine Arts", @"School of Nursing", @"Kinesology and Health Sciences", @"Faculty of Education", nil];
    
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSInteger returnVal;
    
    if ([delegate.settingsIdentifier isEqual: @"semester"])
    {
        returnVal = [semesterArray count];
    }
    
    else if ([delegate.settingsIdentifier  isEqual: @"section"])
    {
        if ([delegate.semesterActive isEqualToString:@"Fall"])
        {
            returnVal = [fallSectionArray count];
        }
        else if ([delegate.semesterActive isEqualToString:@"Winter"])
        {
            returnVal = [winterSectionArray count];
        }
    }
    
    else if ([delegate.settingsIdentifier  isEqual: @"faculty"])
    {
        returnVal = [facultyArray count];
    }
    
    return returnVal;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *compareCurrent;
    if ([delegate.settingsIdentifier isEqual: @"semester"])
    {
        returnArry = semesterArray;
        compareCurrent = delegate.semesterActive;
    }
    else if ([delegate.settingsIdentifier  isEqual: @"section"])
    {
        if ([delegate.semesterActive isEqualToString:@"Fall"])
        {
            returnArry = fallSectionArray;
            compareCurrent = delegate.sectionActive;
        }
        else if ([delegate.semesterActive isEqualToString:@"Winter"])
        {
            returnArry = winterSectionArray;
            compareCurrent = delegate.sectionActive;
        }
    }
    else if ([delegate.settingsIdentifier  isEqual: @"faculty"])
    {
        returnArry = facultyArray;
        compareCurrent = delegate.facultyActive;
        // For the faculty theme
    }
    
    static NSString *cellID = @"newCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    //Set the item to the specific cell
    NSString *item = [returnArry objectAtIndex:indexPath.row];
    if ([item isEqualToString:compareCurrent]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    // Do a date compare and only allow winter selection if dates coincide - semester active
    /*NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSDate *endOfFallSem = [dateFormat dateFromString:@"12/05/2015"];
    if ([[NSDate date] compare:endOfFallSem] == NSOrderedAscending) {
        if ([item isEqualToString:@"Winter"]) {
            // disable the cell
            cell.userInteractionEnabled = NO;
            cell.textLabel.enabled = NO;
            UIAlertView *semesterAlert = [[UIAlertView alloc] initWithTitle:@"Note" message:@"You will be able to select the Winter semester and choose your Winter section starting on December 5th, 2015 (when the Fall term classes end)" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [semesterAlert show];
        }
    }
    else if ([[NSDate date] compare:endOfFallSem] == NSOrderedDescending)
    {
        if ([item isEqualToString:@"Winter"]) {
            // disable the cell
            cell.userInteractionEnabled = YES;
            cell.textLabel.enabled = YES;
        }
    }
    else
    {
        if ([item isEqualToString:@"Winter"]) {
            // disable the cell
            cell.userInteractionEnabled = YES;
            cell.textLabel.enabled = YES;
        }
    }*/
    
    if ([facultyArray indexOfObject:item] == TRUE) {
        if ([delegate.didReadFacultyWarning isEqualToString:@"TRUE"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Faculty Theme" message:@"Select a faculty and the corresponding faculty colors will become the theme of QTap" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            delegate.didReadFacultyWarning = @"TRUE";
            [alert show];
        }
    }
    
    //Set the title and subtitle properties
    cell.textLabel.text = item;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If users selects cell get its contents and save it to the AppDelegate
    NSString *item = [returnArry objectAtIndex:indexPath.row];
    NSArray *cells = [tableView visibleCells];
    // Now we set this to the App Delegate's property value
    NSLog(@"%@", item);
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([delegate.settingsIdentifier isEqual: @"semester"])
    {
        delegate.semesterActive = item;
    }
    else if ([delegate.settingsIdentifier  isEqual: @"section"])
    {
        delegate.sectionActive = item;
    }
    else if ([delegate.settingsIdentifier  isEqual: @"faculty"])
    {
        delegate.facultyActive = item;
    }
    
    for (int i = 0; i < cells.count; i++) {
        if (indexPath.row == i)
        {
            UITableViewCell *cellVal = cells[i];
            cellVal.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            UITableViewCell *cellVal = cells[i];
            cellVal.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }
    // Go back to the main settings view
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Set the height of the cells to 44
    return 44;
}

@end
