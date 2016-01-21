//
//  FoodClass.h
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-03-19.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface FoodClass : NSObject
//All the strings that will contain the food values for each food service and in buildingTableViews will be used as custom class to store the corresponding food cell with all its properties and the food class is necessary to allow for searching so that all the info is attached
@property (nonatomic, strong) NSString *foodService;
@property (nonatomic, strong) NSString *mndHrs;
@property (nonatomic, strong) NSString *buildingLocation;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *tuesdayHours;
@property (nonatomic, strong) NSString *wednesdayHours;
@property (nonatomic, strong) NSString *thursdayHours;
@property (nonatomic, strong) NSString *fridayHours;
@property (nonatomic, strong) NSString *saturdayHours;
@property (nonatomic, strong) NSString *sundayHours;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *coordinate;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic, assign) CLLocationDistance relativeDist;


@end
