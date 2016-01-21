//
//  annotations.h
//  mapKitR1.0
//
//  Created by Rony Besprozvanny and Zachary Yale on 2015-06-27.
//  Copyright (c) 2015 QTap Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface annotations : NSObject <MKAnnotation>

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;  // Building Title - For food is food title
@property(nonatomic, copy) NSString *subtitle;  // Faculty - For food is Building Location
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *mondHrs;
@property (nonatomic, strong) NSString *tuesdayHours;
@property (nonatomic, strong) NSString *wednesdayHours;
@property (nonatomic, strong) NSString *thursdayHours;
@property (nonatomic, strong) NSString *fridayHours;
@property (nonatomic, strong) NSString *saturdayHours;
@property (nonatomic, strong) NSString *sundayHours;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic, assign) MKPinAnnotationColor pinColor;



- (id) initWithTitle:(NSString *) title initWithFacultyService:(NSString *) newSub initWithAddress:(NSString *) address initWithMonHrs:(NSString *) monHrs initWithTuesHrs:(NSString *) tuesHrs initWithWedHrs:(NSString *) wedHrs initWithThursHrs:(NSString *) thursHrs initWithFriHrs:(NSString *) friHrs initWithSatHrs:(NSString *) satHrs initWithSunHrs:(NSString *) sunHrs Location:(CLLocationCoordinate2D) cordVal;

- (id) initWithTitle:(NSString *) title initWithFacultyService:(NSString *) newSub initWithAddress:(NSString *) address initWithBio:(NSString *) bio Location:(CLLocationCoordinate2D) cordVal;

- (MKAnnotationView *) annotView;
- (void) transitionAction:(id) sender;

@end
