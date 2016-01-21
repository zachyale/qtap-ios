//
//  buildingsTableViews.m
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-03-19.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import "buildingsTableViews.h"
#import "buildingInformation.h"
#import "FoodClass.h"
#import "cellClass.h"
#import "AppDelegate.h"

@interface buildingsTableViews()
{
    NSArray *titlearray;
    NSArray *subtitlearray;
    NSArray *mondayHours;
    NSArray *tuesdayHours;
    NSArray *wednesdayHours;
    NSArray *thursdayHours;
    NSArray *fridayHours;
    NSArray *saturdayHours;
    NSArray *sundayHours;
    
    NSString *titleString;
    NSString *buildingString;
    NSString *addressString;
    NSString *mondayHoursString;
    NSString *tuesdayHoursString;
    NSString *wednesdayHoursString;
    NSString *thursdayHoursString;
    NSString *fridayHoursString;
    NSString *saturdayHoursString;
    NSString *sundayHoursString;
    NSMutableArray *newArry;
    NSArray *address;
    
}

@end

@implementation buildingsTableViews
@synthesize results;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"buildingHours" ofType:@"plist"];
    
    // Load the file content and read the data into arrays
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    titlearray = [dict objectForKey:@"Food Service"];
    subtitlearray = [dict objectForKey:@"Buildings"];
    address = [dict  objectForKey:@"Addresses"];
    mondayHours = [dict objectForKey:@"Monday Hours"];
    tuesdayHours = [dict objectForKey:@"Tuesday Hours"];
    wednesdayHours = [dict  objectForKey:@"Wednesday Hours"];
    thursdayHours = [dict objectForKey:@"Thursday Hours"];
    fridayHours = [dict objectForKey:@"Friday Hours"];
    saturdayHours = [dict objectForKey:@"Saturday Hours"];
    sundayHours = [dict objectForKey:@"Sunday Hours"];
    
    //searching allocation of array
    self.results = [[NSArray alloc]init];
    newArry = [[NSMutableArray alloc]init];
    for (int i = 0; i <titlearray.count; i++) {
        FoodClass *foodItem = [FoodClass new];
        foodItem.foodService = titlearray[i];
        foodItem.buildingLocation = subtitlearray[i];
        foodItem.address = address[i];
        foodItem.mndHrs = mondayHours[i];
        foodItem.tuesdayHours = tuesdayHours[i];
        foodItem.wednesdayHours = wednesdayHours[i];
        foodItem.thursdayHours = thursdayHours[i];
        foodItem.fridayHours = fridayHours[i];
        foodItem.saturdayHours = saturdayHours[i];
        foodItem.sundayHours = sundayHours[i];
        [newArry addObject:foodItem];
    }
    //Sort the array in ascending order
    NSArray *sortedArray = [newArry sortedArrayUsingComparator:^(FoodClass *one, FoodClass *two) {
        return [one.foodService caseInsensitiveCompare:two.foodService];
    }];
    
    //Replace and the newArry will contain the sorted array
    newArry = [[NSMutableArray alloc] initWithArray:sortedArray];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //If searching return the amount of results available
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.results count];
    }
    //Otherwise return the amount of items in the newArry
    return [newArry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cellClass *cell = (cellClass *)[tableView dequeueReusableCellWithIdentifier:@"cellClass"];
    
    if(!cell){
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellClass"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    FoodClass *item = nil;
    //If the user is viewing the search results
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        //Show the corresponding cells with the proper strings
        item = [results objectAtIndex:indexPath.row];
        NSString *output = [NSString alloc];
        output = [NSString stringWithFormat:@"%@ at %@", item.foodService, item.buildingLocation];
        cell.textLabel.text = output;
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue Light" size:18.0];
    }
    //Otherwise if the user is just viewing the cells wthout searching
    else
    {
        //Set the item to the specific cell
        item = [newArry objectAtIndex:indexPath.row];
    }
    //Set the title and subtitle properties
    cell.lblTitle.text = item.foodService;
    cell.lblSubtitle.text = item.buildingLocation;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //If the user selects a search cell perform the ShowDetail segue - defined in the prepareForSegue func
    if(self.searchDisplayController.isActive)
    {
        [self performSegueWithIdentifier:@"ShowDetail" sender:self];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Set the height of the cells to 60
    return 60;
}

//Called when user selected a cell either search cell or regular and the specific cell "sub-view" needs to be pushed
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *countPass = [[NSString alloc]init];
    FoodClass *item = nil;
    NSIndexPath *indexPath = nil;
    if ([[segue identifier] isEqualToString:@"ShowDetail"])
    {
        //If the search was active
        if(self.searchDisplayController.isActive)
        {
            //Obtain the item that correspondings to the users selected search cell
            indexPath = [[self.searchDisplayController searchResultsTableView] indexPathForSelectedRow];
            item = [results objectAtIndex:indexPath.row];
        }
        //Othwerise if the user was not searching and just hit a specific cell
        else
        {
            //Obtain that item
            indexPath = [self.tableView indexPathForSelectedRow];
            item = [newArry objectAtIndex:indexPath.row];
        }
        //These are for the dinning hall cases
        //CountPass is given a specific value per cafeteria and this is passed on to the destination view
        //CountPass is used in the destination controller to control specific dinning hall visual features
        if ([item.foodService isEqualToString:@"Leonard Dining Hall"])
        {
            item.buildingLocation = @"Leonard Hall";
            countPass = @"1";
            [[segue destinationViewController] setValueDetermine:countPass];
            
        }
        if([item.foodService isEqualToString:@"Ban Righ Dining Hall"])
        {
            countPass = @"2";
            item.buildingLocation = @"Ban Righ Hall";
            [[segue destinationViewController] setValueDetermine:countPass];
            
        }
        if ([item.foodService isEqualToString:@"Jean Royce Dining Hall"]) {
            countPass = @"3";
            item.buildingLocation = @"Jean Royce Hall";
            [[segue destinationViewController] setValueDetermine:countPass];
            
        }
        if ([item.foodService isEqualToString:@"Barista Bar"]) {
            countPass = @"4";
            item.buildingLocation = @"Jean Royce Hall";
            [[segue destinationViewController] setValueDetermine:countPass];
            
        }
        //Set the correspoding strings
        titleString = item.foodService;
        buildingString = item.buildingLocation;
        addressString = item.address;
        mondayHoursString = item.mndHrs;
        tuesdayHoursString = item.tuesdayHours;
        wednesdayHoursString = item.wednesdayHours;
        thursdayHoursString = item.thursdayHours;
        fridayHoursString = item.fridayHours;
        saturdayHoursString = item.saturdayHours;
        sundayHoursString = item.sundayHours;
        
        //Pass all the corresponding strings to the destination controller so that they can be used
        [[segue destinationViewController] setBuildingNameString: buildingString];
        [[segue destinationViewController] setAddressString: addressString];
        [[segue destinationViewController] setMondayhrsString:mondayHoursString];
        [[segue destinationViewController] setFoodTitleString: titleString];
        [[segue destinationViewController] setTuesdayhrsString:tuesdayHoursString];
        [[segue destinationViewController] setWednesdayhrsString:wednesdayHoursString];
        [[segue destinationViewController] setThursdayhrsString:thursdayHoursString];
        [[segue destinationViewController] setFridayhrsString:fridayHoursString];
        [[segue destinationViewController] setSaturdayhrsString:saturdayHoursString];
        [[segue destinationViewController] setSundayhrsString:sundayHoursString];
        
    }
}

#pragma search
- (void) filterContentForSeachText: (NSString *) searchText scope:(NSString *)scope
{
    //The search works for "beginswith" meaning it will show results that contain what the user is typing
    //This can be changed to just display results that are EQUAL to the users current text but the beginswith is the most common type
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"foodService beginswith[c] %@", searchText];
    self.results = [newArry filteredArrayUsingPredicate:predict];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSeachText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}


@end
