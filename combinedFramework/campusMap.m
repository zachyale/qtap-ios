//
//  campusMap.c
//  combinedFramework
//
//  Created by Zachary Yale on 2015-03-20.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#include "campusMap.h"

@interface campusMap ()

@property (weak, nonatomic) IBOutlet UIWebView *mapView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentHub;
- (IBAction)segmentChange:(UISegmentedControl *)sender;


@end

@implementation campusMap

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
    
    
    // Load the file content and read the data into arrays
    
    
    //drawing the first week title
    self.navigationItem.title = @"Campus Map";
    //first web-page load
    
    NSString *urlAddress = [[NSBundle mainBundle] pathForResource:@"walkingmap" ofType:@"html"];
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [self.mapView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentChange:(UISegmentedControl *)sender{
    
    switch(_segmentHub.selectedSegmentIndex)
    {
        case 0:
        {
            NSString *urlAddress = [[NSBundle mainBundle] pathForResource:@"walkingmap" ofType:@"html"];
;
            NSURL *url = [NSURL URLWithString:urlAddress];
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            
            [self.mapView loadRequest:request];
        }
        case 1:
        {
            NSString *urlAddress = [[NSBundle mainBundle] pathForResource:@"transitmap" ofType:@"html"];
            NSURL *url = [NSURL URLWithString:urlAddress];
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            
            [self.mapView loadRequest:request];
        }
        case 2:
        {
            NSString *urlAddress = [[NSBundle mainBundle] pathForResource:@"drivingmap" ofType:@"html"];;
            NSURL *url = [NSURL URLWithString:urlAddress];
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            
            [self.mapView loadRequest:request];
        }
    //end of switch
    }
//end of action
}

@end
