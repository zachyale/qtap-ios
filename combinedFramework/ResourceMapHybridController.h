//
//  ResourceMapHybridController.h
//  combinedFramework
//
//  Created by Zachary Yale on 2015-08-06.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

// For system version
#define osVersion ([[[UIDevice currentDevice] systemVersion] floatValue])

#import <UIKit/UIKit.h>
#import "BATableView.h"
#import <MapKit/MapKit.h>
# import "FoodClass.h"

@interface ResourceMapHybridController : UIViewController <UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, CLLocationManagerDelegate, MKAnnotation>

@property (weak, nonatomic) IBOutlet MKMapView *mainMap;
@property (strong, nonatomic) CLLocationManager *locManage;
@property (weak, nonatomic) IBOutlet BATableView *tableView;

// For calculating if buildings and food services are open/closed
- (NSString *) buildStatusFeature: (FoodClass *)item;
- (NSString *) checkTimesAndImplementOpenFeature: (NSString *) analysisString currentTime:(int)currentTimeInt;
@end
