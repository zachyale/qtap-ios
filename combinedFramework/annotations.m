//
//  annotations.m
//  mapKitR1.0
//
//  Created by Rony Besprozvanny and Zachary Yale on 2015-06-27.
//  Copyright (c) 2016 QTap Project. All rights reserved.
//

#import "annotations.h"
#import "AppDelegate.h"

@implementation annotations
int count = 0;
int countVar = 0;

- (id) initWithTitle:(NSString *) title initWithFacultyService:(NSString *) newSub initWithAddress:(NSString *) address initWithMonHrs:(NSString *) monHrs initWithTuesHrs:(NSString *) tuesHrs initWithWedHrs:(NSString *) wedHrs initWithThursHrs:(NSString *) thursHrs initWithFriHrs:(NSString *) friHrs initWithSatHrs:(NSString *) satHrs initWithSunHrs:(NSString *) sunHrs Location:(CLLocationCoordinate2D) cordVal
{
    self = [super init];
    if(self)
    {
        _title = title; // Building Name/ Food Service
        _subtitle = newSub; // Faculty/Building Location
        _address = address;
        _mondHrs = monHrs;
        _tuesdayHours = tuesHrs;
        _wednesdayHours = wedHrs;
        _thursdayHours = thursHrs;
        _fridayHours = friHrs;
        _saturdayHours = satHrs;
        _sundayHours = sunHrs;
        _coordinate = cordVal;
        _pinColor = MKPinAnnotationColorPurple;
    }
    return self;
}

- (id) initWithTitle:(NSString *) title initWithFacultyService:(NSString *) newSub initWithAddress:(NSString *) address initWithBio:(NSString *) bio Location:(CLLocationCoordinate2D) cordVal
{
    self = [super init];
    if(self)
    {
        _title = title;
        _subtitle = newSub;
        _address = address;
        _bio = bio;
        _coordinate = cordVal;
        _pinColor = MKPinAnnotationColorGreen;
    }
    return self;
}


- (MKAnnotationView *) annotView
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MKPinAnnotationView *annotView = [[MKPinAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"Annotation"];
    annotView.enabled = YES;
    annotView.pinColor = _pinColor;
    annotView.canShowCallout = YES;
    UIButton *transitionBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotView.rightCalloutAccessoryView = transitionBtn;
    transitionBtn.tag = count;
    count ++;
    return annotView;
}


- (void) transitionAction:(UIButton *) sender
{
    int ind = (int) sender.tag;
    NSString *strVal = [NSString stringWithFormat:@"Pressed Annotation %d", ind];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Test" message:strVal delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

@end
