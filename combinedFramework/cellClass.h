//
//  cellClass.h
//  combinedFramework
//
//  Created by Rony Besprozvanny and Zachary Yale on 2015-03-19.
//  Copyright (c) 2016 QTap Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cellClass : UITableViewCell
//We need to use custom cells so the custom cell will have a title and a subtitle
@property (nonatomic, strong) IBOutlet UILabel *lblTitle;
@property (nonatomic, strong) IBOutlet UILabel *lblSubtitle;
@property (nonatomic,strong) IBOutlet UILabel *lblStatus;
@property (nonatomic,strong) IBOutlet UILabel *lblDist;
@property (nonatomic, strong) IBOutlet UISlider *slider;
@property (nonatomic, strong) IBOutlet UILabel *lblRangeSlider;
@property (nonatomic, strong) IBOutlet UISwitch *nearbySwitch;
@property (nonatomic, strong) NSString *isChecked;

@end
