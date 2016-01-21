//
//  dashboardCell.h
//  combinedFramework
//
//  Created by Zachary Yale and Rony Besprozvanny on 2015-08-17.
//  Copyright (c) 2016 QTap Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dashboardCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *lblStart;
@property (nonatomic, retain) IBOutlet UILabel *lblEnd;
@property (nonatomic, retain) IBOutlet UILabel *lblClass;
@property (nonatomic, retain) IBOutlet UILabel *lblLocation;
@property (nonatomic, retain) IBOutlet UILabel *lblLocationEngineering;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *APSCwidthSingle;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *APSCwidthDouble;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *APSCwidthTriple;
@property (nonatomic, retain) IBOutlet UILabel *lblClassType;
@property (nonatomic, retain) IBOutlet UIView *lineView;
@property (nonatomic, retain) IBOutlet UIImageView *courseImg;
@property (strong, nonatomic) IBOutlet UIView *singleLine;
@property (strong, nonatomic) IBOutlet UIView *doubleLine;
@property (strong, nonatomic) IBOutlet UIView *tripleLine;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *singleClassConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *doubleClassConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tripleClassConstraint;

// FOR WHEN NO EVENTS ARE SCHEDULED
@property (nonatomic, retain) IBOutlet UILabel *lblNoClass;



@end
