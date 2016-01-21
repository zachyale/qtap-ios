//
//  cellClass.m
//  combinedFramework
//
//  Created by Rony Besprozvanny and Zachary Yale on 2015-03-19.
//  Copyright (c) 2016 QTap Project. All rights reserved.
//

#import "cellClass.h"

@implementation cellClass

@synthesize lblTitle,lblSubtitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)awakeFromNib {
    // Initialization code
}

@end
