//
//  buildingsTableViews.h
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-03-19.
//  Copyright (c) 2015 ENGSOC Group 377A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface buildingsTableViews : UITableViewController <UITableViewDataSource,UITableViewDelegate, UISearchDisplayDelegate>

@property (nonatomic, strong) NSArray *results;


@end
