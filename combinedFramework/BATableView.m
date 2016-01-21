//
//  BATableView.m
//  combinedFramework
//
//  Created by Zachary Yale on 2015-08-06.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import "BATableView.h"

@implementation BATableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    id hitView = [super hitTest:point withEvent:event];
    if (point.y<0) {
        return nil;
    }
    return hitView;
}

@end
