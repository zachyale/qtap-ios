//
//  ResourceMapHybridController.m
//  combinedFramework
//
//  Created by Zachary Yale on 2015-08-06.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import "ResourceMapHybridController.h"
#import "annotations.h"
#import "detailViewController.h"
#import "NewDetailViewController.h"
#import "cellClass.h"
#import "AppDelegate.h"

@interface ResourceMapHybridController ()
{
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
    NSString *coordString;
    // Academic Buildings
    NSString *bioString;
    
    NSMutableArray *newArry;
    NSArray *address;
    NSArray *coordinate;
    
    //For the new .plist
    NSArray *IDArray;
    NSArray *buildingNameArray;
    NSArray *addressArray;
    NSArray *coordinateArray;
    NSArray *serviceNameArray;
    NSArray *monHoursArray;
    NSArray *tuesHoursArray;
    NSArray *wedHoursArray;
    NSArray *thursHoursArray;
    NSArray *friHoursArray;
    NSArray *satHoursArray;
    NSArray *sunHoursArray;
    NSArray *facultyArray;
    NSArray *bioArry;
    
    NSArray *results;
    MKCoordinateRegion currentRegion;
    MKCoordinateRegion regionOverall;
    
    // For checking filter and when to go into viewDidAppear
    NSString *prevFilter;
    int runCount;
    
    // For the tap fast issue
    BOOL didReload;
    
}
@end

@implementation ResourceMapHybridController
@synthesize mainMap, tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Create a reload tableview selector and to reupdate location
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableCells:) name:@"updateCells" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callUpdateLocation:) name:@"updateLoc" object:nil];
    
    //Map Related Initial Initialization
    self.mainMap.delegate = self;
    self.locManage = [[CLLocationManager alloc]init];
    self.locManage.delegate = self;
    //Check for SW Version
    if(osVersion >= 8.0)
    {
        [self.locManage requestWhenInUseAuthorization];
    }
    [self.locManage startUpdatingLocation];
    
    //set the distance monitoring update
    self.locManage.desiredAccuracy= kCLLocationAccuracyHundredMeters;
    self.locManage.distanceFilter = 50;
    mainMap.showsUserLocation = YES;
    [mainMap setMapType:MKMapTypeStandard];
    [mainMap setZoomEnabled:YES];
    [mainMap setScrollEnabled:YES];
    
    //filter test
    // For now we have a 0-3 filter
    // Filter will be populated here
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *didSave = [defaults objectForKey:@"didSave"];
    
    if ([didSave isEqualToString:@"YES"])
    {
        delegate.buildingSettingFilter = [defaults objectForKey:@"buildingSettingFilter"];
        delegate.buildingSettingsNearbyConfig = [defaults objectForKey:@"buildingSettingsNearbyConfig"];
        delegate.buildingSettingsRange = [defaults objectForKey:@"buildingSettingsRange"];
        delegate.saved = @"NO";
    }
    
    prevFilter = delegate.buildingSettingFilter;
    if (prevFilter == nil) {
        delegate.buildingSettingFilter = @"Food Services";
        prevFilter = delegate.buildingSettingFilter;
    }
    runCount = 0;
    // Initially set the region to the Queens 1 KM center region
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(44.226694, -76.495634);
    currentRegion = MKCoordinateRegionMakeWithDistance(coord, 1000, 1000);
    [self.mainMap setRegion:currentRegion animated:YES];
    
    // Also create a big region around Queens, where if a user is located within it it would show their specific sector and any related stores buidings to them otherwise if they are not in the region at all it will default to showing a 1 km by 1 km region of Queens
    regionOverall = MKCoordinateRegionMakeWithDistance(coord, 20000, 20000);
    
    // [Max Cells - Until 5 Cells] Cell Offset
        //self.tableView.contentOffset = CGPointMake(0, -280);
    // [4 Cells] Cell Offset
    // [3 Cells] Cell Offset
        //self.tableView.contentOffset = CGPointMake(0, -380);
    
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.contentInset = UIEdgeInsetsMake(self.mainMap.frame.size.height-1, 0, 0, 0);
}

- (void) callUpdateLocation: (NSNotification *)notif
{
    [self viewDidAppear:YES];
    [self.locManage startUpdatingLocation];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y < self.mainMap.frame.size.height*-1 ) {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, self.mainMap.frame.size.height*-1)];
    }
}

#pragma mark - Map Related Functions
- (void)viewDidAppear:(BOOL)animated
{
    // Here disable the search controller if it is active
    
    // Before anything check if the search controller is active and if it is turn it off
    if (self.searchDisplayController.isActive == YES) {
        [self.searchDisplayController setActive:NO animated:NO];
    }
    didReload = NO;
    if (runCount != 0)
    {
        // First deselect all cells
        NSArray *cellClassArray = [tableView visibleCells];
        for (int i = 0; i < cellClassArray.count; i++) {
            cellClass *cell = cellClassArray[i];
            NSIndexPath *indexPath = [tableView indexPathForCell:cell];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }
    
    if (runCount == 0)
    {
        runCount = 1;
    }
    // Update the hybrid
    [self updateCompleteHybrid];
    
}

- (void) updateCompleteHybrid {
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainMap removeAnnotations:mainMap.annotations];
    //Load in the new .plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"buildings" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    IDArray = [dict objectForKey:@"ID"];
    buildingNameArray = [dict objectForKey:@"Building Name"];
    addressArray = [dict  objectForKey:@"Address"];
    monHoursArray = [dict objectForKey:@"Monday Hours"];
    tuesHoursArray = [dict objectForKey:@"Tuesday Hours"];
    wedHoursArray = [dict  objectForKey:@"Wednesday Hours"];
    thursHoursArray = [dict objectForKey:@"Thursday Hours"];
    friHoursArray = [dict objectForKey:@"Friday Hours"];
    satHoursArray = [dict objectForKey:@"Saturday Hours"];
    sunHoursArray = [dict objectForKey:@"Sunday Hours"];
    coordinateArray = [dict objectForKey:@"Coordinate"];
    serviceNameArray = [dict objectForKey:@"Service Name"];
    facultyArray = [dict objectForKey:@"Faculty"];
    bioArry = [dict objectForKey:@"Bio"];
    
    //filter test
    // For now we have a 0-3 filter
    // Filter will be populated here
    NSString *filter = delegate.buildingSettingFilter;
    NSString *filterProg = [[NSString alloc]init];
    /*if (filter == nil) {
     filter = @"Food Services";
     delegate.buildingSettingFilter = filter;
     }*/
    if ([filter isEqualToString:@"Food Services"]) {
        filterProg = @"0";
    }
    else if ([filter isEqualToString:@"Academic Buildings"])
    {
        filterProg = @"1";
    }
    else
        // Can only be local stores
        filterProg = @"2";
    int count = -1;
    int startElement = 0;
    
    for (int i=0; i<IDArray.count; i++)
    {
        NSString *IDFilter = [IDArray[i] substringWithRange:NSMakeRange(0, 1)];
        if ([IDFilter isEqualToString:filterProg])
        {
            if (count == -1)
            {
                startElement = i;
                count++;
            }
            else
            {
                // due to the array starting from 0
                count++;
            }
        }
    }
    NSLog(@"%d", startElement);
    NSLog(@"%d", count);
    
    
    //Initialize the results array and the newArry
    // newArry is for the filter contents same as in the annotations and the results array is for the search entries
    results = [[NSArray alloc]init];
    newArry = [[NSMutableArray alloc]init];
    
    // Now we loop through again with only those indexes and get the needed data
    // Before check implement filter specific commands
    for (int i = startElement; i <= (startElement + count); i++) {
        
        NSArray *coordinateVal = [coordinateArray[i] componentsSeparatedByString:@","];
        double latVal = [coordinateVal[0] doubleValue];
        double longVal = [coordinateVal[1] doubleValue];
        CLLocationCoordinate2D coordVal = CLLocationCoordinate2DMake(latVal,longVal);
        annotations *annotAdd;
        if ([filterProg isEqualToString:@"0"])
        {
            annotAdd = [[annotations alloc] initWithTitle:serviceNameArray[i] initWithFacultyService:buildingNameArray[i] initWithAddress:addressArray[i] initWithMonHrs:monHoursArray[i] initWithTuesHrs:tuesHoursArray[i] initWithWedHrs:wedHoursArray[i] initWithThursHrs:thursHoursArray[i] initWithFriHrs:friHoursArray[i] initWithSatHrs:satHoursArray[i] initWithSunHrs:sunHoursArray[i] Location:coordVal];
            
            // We also want to create this specific item into the array to be displayed in the table
            FoodClass *foodItem = [FoodClass new];
            foodItem.foodService = serviceNameArray[i];
            foodItem.buildingLocation = buildingNameArray[i];
            foodItem.address = addressArray[i];
            foodItem.mndHrs = monHoursArray[i];
            foodItem.tuesdayHours = tuesHoursArray[i];
            foodItem.wednesdayHours = wedHoursArray[i];
            foodItem.thursdayHours = thursHoursArray[i];
            foodItem.fridayHours = friHoursArray[i];
            foodItem.saturdayHours = satHoursArray[i];
            foodItem.sundayHours = sunHoursArray[i];
            foodItem.coordinate = coordinateArray[i];
            foodItem.ID = IDArray[i];
            [newArry addObject:foodItem];
        }
        else
        {
            //Don't load in food service name but instead loada in the corresponding faculty
            annotAdd = [[annotations alloc]initWithTitle:buildingNameArray[i] initWithFacultyService:facultyArray[i] initWithAddress:addressArray[i] initWithBio:bioArry[i] Location:coordVal];
            
            // We also add the item to the array but if it is an academic building - filter 1 then there are no hours only bio - add in bio string to it and coordinate string. This will be used for proximity with location check
            FoodClass *foodItem = [FoodClass new];
            foodItem.foodService = buildingNameArray[i];
            foodItem.buildingLocation = facultyArray[i];
            foodItem.address = addressArray[i];
            foodItem.bio = bioArry[i];
            foodItem.coordinate = coordinateArray[i];
            foodItem.ID = IDArray[i];
            [newArry addObject:foodItem];
            
        }
        
        [mainMap addAnnotation:annotAdd];
        
    }
    // Set the location back to main if anything
    if (didReload == NO)
    {
        NSLog(@"No location");
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        //CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(44.226694, -76.495634);
        //currentRegion = MKCoordinateRegionMakeWithDistance(coord, 1000, 1000);
        //[self.mainMap setRegion:currentRegion animated:YES];
        NSMutableArray *tempArry = [[NSMutableArray alloc]init];
        for (int i = 0; i < newArry.count; i++) {
            //Grab the coordinate
            FoodClass *item = [[FoodClass alloc] init];
            // Add the items here
            // Relative dist of 0 for both
            item.relativeDist = 0;
            // Specific variable allocations
            if ([delegate.buildingSettingFilter isEqualToString:@"Food Services"]) {
                item.foodService = [newArry[i] valueForKey:@"foodService"];
                item.buildingLocation = [newArry[i] valueForKey:@"buildingLocation"];
                item.address = [newArry[i] valueForKey:@"address"];
                item.mndHrs = [newArry[i] valueForKey:@"mndHrs"];
                item.tuesdayHours = [newArry[i] valueForKey:@"tuesdayHours"];
                item.wednesdayHours = [newArry[i] valueForKey:@"wednesdayHours"];
                item.thursdayHours = [newArry[i] valueForKey:@"thursdayHours"];
                item.fridayHours = [newArry[i] valueForKey:@"fridayHours"];
                item.saturdayHours = [newArry[i] valueForKey:@"saturdayHours"];
                item.sundayHours = [newArry[i] valueForKey:@"sundayHours"];
                item.coordinate = [newArry[i] valueForKey:@"coordinate"];
                item.ID = [newArry[i] valueForKey:@"ID"];
            }
            else if ([delegate.buildingSettingFilter isEqualToString:@"Academic Buildings"])
            {
                item.foodService = [newArry[i] valueForKey:@"foodService"];
                item.buildingLocation = [newArry[i] valueForKey:@"buildingLocation"];
                item.address = [newArry[i] valueForKey:@"address"];
                item.bio = [newArry[i] valueForKey:@"bio"];
                item.coordinate = [newArry[i] valueForKey:@"coordinate"];
                item.ID = [newArry[i] valueForKey:@"ID"];
            }
            
            // Add the item to the temp list
            [tempArry addObject:item];
        }
        // Now sort the array based on this key
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"foodService" ascending:YES];
        [tempArry sortUsingDescriptors:@[sort]];
        newArry = tempArry;
        
        // For the content offset
        if ([delegate.closedAppResourceIndicator isEqualToString:@"NEW"]) {
            if (newArry.count <= 3) {
                // [3 Cells] Cell Offset
                self.tableView.contentOffset = CGPointMake(0, -380);
            }
            else if (newArry.count == 4)
            {
                // [4 Cells] Cell Offset
                self.tableView.contentOffset = CGPointMake(0, -340);
            }
            else
            {
                // Greater than 4
                // [Max Cells - Until 5 Cells] Cell Offset
                self.tableView.contentOffset = CGPointMake(0, -280);
            }
            delegate.closedAppResourceIndicator = @"OLD";
        }
        [tableView reloadData];
    }
    [self.locManage startUpdatingLocation];
    didReload = YES;
}



-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"No location");
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(44.226694, -76.495634);
    currentRegion = MKCoordinateRegionMakeWithDistance(coord, 1000, 1000);
    [self.mainMap setRegion:currentRegion animated:YES];
    NSMutableArray *tempArry = [[NSMutableArray alloc]init];
    for (int i = 0; i < newArry.count; i++) {
        //Grab the coordinate
        FoodClass *item = [[FoodClass alloc] init];
        // Add the items here
        // Relative dist of 0 for both
        item.relativeDist = 0;
        // Specific variable allocations
        if ([delegate.buildingSettingFilter isEqualToString:@"Food Services"]) {
            item.foodService = [newArry[i] valueForKey:@"foodService"];
            item.buildingLocation = [newArry[i] valueForKey:@"buildingLocation"];
            item.address = [newArry[i] valueForKey:@"address"];
            item.mndHrs = [newArry[i] valueForKey:@"mndHrs"];
            item.tuesdayHours = [newArry[i] valueForKey:@"tuesdayHours"];
            item.wednesdayHours = [newArry[i] valueForKey:@"wednesdayHours"];
            item.thursdayHours = [newArry[i] valueForKey:@"thursdayHours"];
            item.fridayHours = [newArry[i] valueForKey:@"fridayHours"];
            item.saturdayHours = [newArry[i] valueForKey:@"saturdayHours"];
            item.sundayHours = [newArry[i] valueForKey:@"sundayHours"];
            item.coordinate = [newArry[i] valueForKey:@"coordinate"];
            item.ID = [newArry[i] valueForKey:@"ID"];
        }
        else if ([delegate.buildingSettingFilter isEqualToString:@"Academic Buildings"])
        {
            item.foodService = [newArry[i] valueForKey:@"foodService"];
            item.buildingLocation = [newArry[i] valueForKey:@"buildingLocation"];
            item.address = [newArry[i] valueForKey:@"address"];
            item.bio = [newArry[i] valueForKey:@"bio"];
            item.coordinate = [newArry[i] valueForKey:@"coordinate"];
            item.ID = [newArry[i] valueForKey:@"ID"];
        }
        
        // Add the item to the temp list
        [tempArry addObject:item];
    }
    // Now sort the array based on this key
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"foodService" ascending:YES];
    [tempArry sortUsingDescriptors:@[sort]];
    newArry = tempArry;
    
    // For the content offset
    if (newArry.count <= 3) {
        // [3 Cells] Cell Offset
        self.tableView.contentOffset = CGPointMake(0, -380);
    }
    else if (newArry.count == 4)
    {
        // [4 Cells] Cell Offset
        self.tableView.contentOffset = CGPointMake(0, -340);
    }
    else
    {
        // Greater than 4
        // [Max Cells - Until 5 Cells] Cell Offset
        self.tableView.contentOffset = CGPointMake(0, -280);
    }
    
    [tableView reloadData];
    didReload = YES;
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *coord = [locations lastObject];
    CLLocationCoordinate2D coordVal = coord.coordinate;
    //Check if users coordinate lies within the region
    BOOL isWithin = [self coord:coordVal inArea:regionOverall];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (isWithin == YES)
    {
        // Create the new current region
        currentRegion = MKCoordinateRegionMakeWithDistance(coordVal, 1000, 1000); //1 km
        [self.mainMap setRegion:currentRegion animated:YES];
        if (delegate.buildingSettingsNearbyConfig == nil) {
            delegate.buildingSettingsNearbyConfig = @"ON";
        }
        // We want to go ahead and grab distances between the users location and the prospective points
        // Create a temp array that will be used to store the new data
        NSMutableArray *tempArry = [[NSMutableArray alloc]init];
        for (int i = 0; i < newArry.count; i++)
        {
            //Grab the coordinate
            FoodClass *item = [[FoodClass alloc] init];
            if ([delegate.buildingSettingsNearbyConfig isEqualToString:@"ON"])
            {
                NSString *coordBuilding = [newArry[i] valueForKey:@"coordinate"];
                // We split by comma
                NSArray *coordinateVal = [coordBuilding componentsSeparatedByString:@","];
                double latVal = [coordinateVal[0] doubleValue];
                double longVal = [coordinateVal[1] doubleValue];
                
                CLLocation *buildingCoordinate = [[CLLocation alloc]initWithLatitude:latVal longitude:longVal];
                CLLocation *userLocation = [[CLLocation alloc]initWithLatitude:coordVal.latitude longitude:coordVal.longitude];
                CLLocationDistance distVal = [userLocation distanceFromLocation:buildingCoordinate];
                item.relativeDist = distVal;
            }
            else
                item.relativeDist = 0;
            // Add the items here
            if ([delegate.buildingSettingFilter isEqualToString:@"Food Services"])
            {
                item.foodService = [newArry[i] valueForKey:@"foodService"];
                item.buildingLocation = [newArry[i] valueForKey:@"buildingLocation"];
                item.address = [newArry[i] valueForKey:@"address"];
                item.mndHrs = [newArry[i] valueForKey:@"mndHrs"];
                item.tuesdayHours = [newArry[i] valueForKey:@"tuesdayHours"];
                item.wednesdayHours = [newArry[i] valueForKey:@"wednesdayHours"];
                item.thursdayHours = [newArry[i] valueForKey:@"thursdayHours"];
                item.fridayHours = [newArry[i] valueForKey:@"fridayHours"];
                item.saturdayHours = [newArry[i] valueForKey:@"saturdayHours"];
                item.sundayHours = [newArry[i] valueForKey:@"sundayHours"];
                item.coordinate = [newArry[i] valueForKey:@"coordinate"];
                item.ID = [newArry[i] valueForKey:@"ID"];
            }
            else if ([delegate.buildingSettingFilter isEqualToString:@"Academic Buildings"])
            {
                item.foodService = [newArry[i] valueForKey:@"foodService"];
                item.buildingLocation = [newArry[i] valueForKey:@"buildingLocation"];
                item.address = [newArry[i] valueForKey:@"address"];
                item.bio = [newArry[i] valueForKey:@"bio"];
                item.coordinate = [newArry[i] valueForKey:@"coordinate"];
                item.ID = [newArry[i] valueForKey:@"ID"];
            }
            if (delegate.buildingSettingsRange == nil)
                delegate.buildingSettingsRange = @"2.0";
            double buildingRange = [delegate.buildingSettingsRange doubleValue] * 1000;
            if (item.relativeDist <= buildingRange && [delegate.buildingSettingsNearbyConfig isEqualToString:@"ON"])
            {
                // Add the item to the temp list
                [tempArry addObject:item];
            }
            else if ([delegate.buildingSettingsNearbyConfig isEqualToString:@"OFF"])
            {
                [tempArry addObject:item];
            }
            // Always add the blank one
            else if (item.buildingLocation == nil)
                [tempArry addObject:item];
        }
        if ([delegate.buildingSettingsNearbyConfig isEqualToString:@"ON"]) {
            // Now sort the array based on this key
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"relativeDist" ascending:YES];
            [tempArry sortUsingDescriptors:@[sort]];
        }
        else
        {
            // Now sort the array based on this key
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"foodService" ascending:YES];
            [tempArry sortUsingDescriptors:@[sort]];
        }
        newArry = tempArry;
    }
    else
    {
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(44.226694, -76.495634);
        currentRegion = MKCoordinateRegionMakeWithDistance(coord, 1000, 1000);
        [self.mainMap setRegion:currentRegion animated:YES];
        NSMutableArray *tempArry = [[NSMutableArray alloc]init];
        for (int i = 0; i < newArry.count; i++) {
            //Grab the coordinate
            FoodClass *item = [[FoodClass alloc] init];
            // Add the items here
            // Relative dist of 0 for both
            item.relativeDist = 0;
            // Specific variable allocations
            if ([delegate.buildingSettingFilter isEqualToString:@"Food Services"]) {
                item.foodService = [newArry[i] valueForKey:@"foodService"];
                item.buildingLocation = [newArry[i] valueForKey:@"buildingLocation"];
                item.address = [newArry[i] valueForKey:@"address"];
                item.mndHrs = [newArry[i] valueForKey:@"mndHrs"];
                item.tuesdayHours = [newArry[i] valueForKey:@"tuesdayHours"];
                item.wednesdayHours = [newArry[i] valueForKey:@"wednesdayHours"];
                item.thursdayHours = [newArry[i] valueForKey:@"thursdayHours"];
                item.fridayHours = [newArry[i] valueForKey:@"fridayHours"];
                item.saturdayHours = [newArry[i] valueForKey:@"saturdayHours"];
                item.sundayHours = [newArry[i] valueForKey:@"sundayHours"];
                item.coordinate = [newArry[i] valueForKey:@"coordinate"];
                item.ID = [newArry[i] valueForKey:@"ID"];
            }
            else if ([delegate.buildingSettingFilter isEqualToString:@"Academic Buildings"])
            {
                item.foodService = [newArry[i] valueForKey:@"foodService"];
                item.buildingLocation = [newArry[i] valueForKey:@"buildingLocation"];
                item.address = [newArry[i] valueForKey:@"address"];
                item.bio = [newArry[i] valueForKey:@"bio"];
                item.coordinate = [newArry[i] valueForKey:@"coordinate"];
                item.ID = [newArry[i] valueForKey:@"ID"];
            }
            
            // Add the item to the temp list
            [tempArry addObject:item];
        }
        // Now sort the array based on this key
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"foodService" ascending:YES];
        [tempArry sortUsingDescriptors:@[sort]];
        newArry = tempArry;
    }
    
    /* For the content offset
    if (newArry.count <= 3) {
        // [3 Cells] Cell Offset
        self.tableView.contentOffset = CGPointMake(0, -420);
    }
    else if (newArry.count == 4)
    {
        // [4 Cells] Cell Offset
        self.tableView.contentOffset = CGPointMake(0, -340);
    }
    else
    {
        // Greater than 4
        // [Max Cells - Until 5 Cells] Cell Offset
        self.tableView.contentOffset = CGPointMake(0, -280);
    }*/
    [tableView reloadData];
    didReload = YES;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[annotations class]]) {
        annotations *location = (annotations *)annotation;
        MKAnnotationView *annotView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"Annotation"];
        annotView = location.annotView;
        return annotView;
    }
    else
    {
        return nil;
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NewDetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    annotations *customAnnot = (annotations *)view.annotation;
    titleString = customAnnot.title;
    buildingString = customAnnot.subtitle;
    addressString = customAnnot.address;
    mondayHoursString = customAnnot.mondHrs;
    tuesdayHoursString = customAnnot.tuesdayHours;
    wednesdayHoursString = customAnnot.wednesdayHours;
    thursdayHoursString = customAnnot.thursdayHours;
    fridayHoursString = customAnnot.fridayHours;
    saturdayHoursString = customAnnot.saturdayHours;
    sundayHoursString = customAnnot.sundayHours;
    bioString = customAnnot.bio;
    
    // Coordinate
    // Convert from Coordinate to string
    NSString *tempCordStr = [[NSString alloc] initWithFormat:@"%f, %f", customAnnot.coordinate.latitude, customAnnot.coordinate.longitude];
    coordString = tempCordStr;
    
    detailView.foodTitleString = titleString;
    detailView.buildingNameString = buildingString;
    detailView.addressString = addressString;
    detailView.mondayhrsString = mondayHoursString;
    detailView.tuesdayhrsString = tuesdayHoursString;
    detailView.wednesdayhrsString = wednesdayHoursString;
    detailView.thursdayhrsString = thursdayHoursString;
    detailView.fridayhrsString = fridayHoursString;
    detailView.saturdayhrsString = saturdayHoursString;
    detailView.sundayhrsString = sundayHoursString;
    detailView.coordStr = coordString;
    detailView.bioString = bioString;
    [self.navigationController pushViewController:detailView animated:YES];
}

// Function to check if users location is in the Queen's region - defined by area paramter.. by default its set to within 20 km of Queens vicinity
// If user is outside the Queen's region NO will be returned and the nearby feature will be disabled
-(BOOL)coord:(CLLocationCoordinate2D)coordVal inArea:(MKCoordinateRegion)area
{
    CLLocationCoordinate2D ctr   = area.center;
    CLLocationCoordinate2D nwEdge;
    CLLocationCoordinate2D seEdge;
    
    nwEdge.latitude  = ctr.latitude  - (area.span.latitudeDelta  / 2.0);
    nwEdge.longitude = ctr.longitude - (area.span.longitudeDelta / 2.0);
    seEdge.latitude  = ctr.latitude  + (area.span.latitudeDelta  / 2.0);
    seEdge.longitude = ctr.longitude + (area.span.longitudeDelta / 2.0);
    
    // Compare and return accordingly
    if (coordVal.latitude >= nwEdge.latitude && coordVal.latitude <= seEdge.latitude && coordVal.longitude >= nwEdge.longitude && coordVal.longitude <= seEdge.longitude)
    {
        return YES;
    }
    else
        return NO;
}


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //If searching return the amount of results available
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [results count];
    }
    //Otherwise return the amount of items in the newArry
    return [newArry count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (runCount != 0)
    {
        // First deselect all cells
        NSArray *cellClassArray = [tableView visibleCells];
        for (int i = 0; i < cellClassArray.count; i++) {
            cellClass *cell = cellClassArray[i];
            NSIndexPath *indexPath = [tableView indexPathForCell:cell];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }
    
    
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
        output = [NSString stringWithFormat:@"%@ - %@", item.foodService, item.buildingLocation];
        cell.textLabel.text = output;
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue Light" size:18.0];
    }
    //Otherwise if the user is just viewing the cells without searching
    else
    {
        //Set the item to the specific cell
        item = [newArry objectAtIndex:indexPath.row];
    }
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //Set the title and subtitle properties
    cell.lblTitle.text = item.foodService;
    cell.lblSubtitle.text = item.buildingLocation;
    if ([delegate.buildingSettingFilter isEqualToString: @"Food Services"])
    {
        // Run the item hours check to see if open or closed
        NSString *outputString = [[NSString alloc] init];
        outputString = [self buildStatusFeature:item];
        if ([outputString isEqualToString:@"Open"]) {
            cell.lblStatus.textColor = [UIColor colorWithRed:(66/255.0) green:(213/255.0) blue:(82/255.0) alpha:1.0];
        }
        else
            cell.lblStatus.textColor = [UIColor redColor];
        cell.lblStatus.text = outputString;
    }
    else
    {
        cell.lblStatus.text = @"";
    }
    if (item.relativeDist == 0) {
        cell.lblDist.text = @"";
    }
    else
    {
        NSString *distStr = [[NSString alloc] initWithFormat:@"%4.0f m", item.relativeDist];
        cell.lblDist.text = distStr;
    }
    
    //cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //If the user selects a search cell perform the detailViewSegue segue - defined in the prepareForSegue func
    // Get the correct cell
    cellClass *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(self.searchDisplayController.isActive)
    {
        [self performSegueWithIdentifier:@"detailViewSegue" sender:self];
    }
    
}

// Check if segue can be performed
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if (didReload == YES) {
        return YES;
    }
    else
    {
        // Show activity indicator
        return NO;
    }
}

//Called when user selected a cell either search cell or regular and the specific cell "sub-view" needs to be pushed
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    FoodClass *item = nil;
    NSIndexPath *indexPath = nil;
    if ([[segue identifier] isEqualToString:@"detailViewSegue"])
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
        bioString = item.bio;
        coordString = item.coordinate;

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
        [[segue destinationViewController] setBioString:bioString];
        [[segue destinationViewController] setCoordStr:coordString];
        
    }
}

# pragma search
- (void) filterContentForSeachText: (NSString *) searchText scope:(NSString *)scope
{
    //The search works for "beginswith" meaning it will show results that contain what the user is typing
    //This can be changed to just display results that are EQUAL to the users current text but the beginswith is the most common type
    NSPredicate *predict = [NSPredicate predicateWithFormat:@"foodService beginswith[c] %@", searchText];
    results = [newArry filteredArrayUsingPredicate:predict];
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSeachText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *) buildStatusFeature: (FoodClass *)item
{
    NSCalendar *gregCalend = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComp = [gregCalend components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    int weekdayNum = (int)[dateComp weekday];
    
    NSString *analysisString;
    if (weekdayNum == 2)
        analysisString = item.mndHrs;
    else if (weekdayNum == 3)
        analysisString = item.tuesdayHours;
    else if (weekdayNum == 4)
        analysisString = item.wednesdayHours;
    else if (weekdayNum == 5)
        analysisString = item.thursdayHours;
    else if (weekdayNum == 6)
        analysisString = item.fridayHours;
    else if (weekdayNum == 7)
        analysisString = item.saturdayHours;
    else  // sunday is represented by 1
        analysisString = item.sundayHours;
    
    // Get users time
    NSString *currentHour = [[NSString alloc] init];
    NSString *currentMinute = [[NSString alloc] init];
    int currentHourInt = 0;
    int currentMinuteInt = 0;
    int currentTimeInt = 0;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
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
    
    NSLog(@"%d", currentTimeInt);
    
    NSString *outputString = [[NSString alloc] init];
    
    // First check if the analysis string is closed - if it is just return closed
    if ([analysisString isEqualToString:@"Closed"])
    {
        outputString = @"Closed";
        return outputString;
    }
    
    if ([item.foodService isEqualToString:@"Leonard Dining Hall"] || [item.foodService isEqualToString:@"Jean Royce Dining Hall"] || [item.foodService isEqualToString:@"Ban Righ Dining Hall"] || [item.foodService isEqualToString:@"Barista Bar"])
    {
        // We go to caf specific one
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
        
        // we know that after this i can never be zero - as there has to be key and values so do a expection check
        if (firstVal == 0)
        {
            return @"Closed";
        }
        
        // Now we want to check all indexes after first index to find the times and if it falls within range
        for (int i = firstVal; i < keyValuesArray.count; i++)
        {
            if ([keyValuesArray[i] rangeOfString:@"N/A"].location == NSNotFound)
            {
                // Get the start and end time exactly as done below and compare
                outputString = [self checkTimesAndImplementOpenFeature:keyValuesArray[i] currentTime:currentTimeInt];
                if ([outputString isEqualToString:@"Open"])
                {
                    //If open no need to continue with loop
                    break;
                }
            }
        }
        
    }
    else
        outputString = [self checkTimesAndImplementOpenFeature:analysisString currentTime:currentTimeInt];
    return outputString;
}

- (NSString *) checkTimesAndImplementOpenFeature: (NSString *) analysisString currentTime:(int)currentTimeInt
{
    // If the string is empty return closed!!
    if ([analysisString isEqualToString:@"EMPTY"])
    {
        return @"Closed";
    }
    
    // Continue with regular parsing
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
    else if (startTimeValue <= currentTimeInt && endTimeValue > currentTimeInt) {
        NSLog(@"Open");
        return @"Open";
    }
    else
    {
        NSLog(@"Closed");
        return @"Closed";
    }
    
}

@end
