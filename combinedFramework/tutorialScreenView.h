//
//  tutorialScreenView.h
//  combinedFramework
//
//  Created by Rony Besprozvanny on 2015-08-18.
//  Copyright (c) 2015 Queen's University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tutorialScreenView : UIViewController

@property NSUInteger pgIndex;
@property NSString *title;
@property NSString *descrip;
@property NSString *img;

//MAIN SCREEN
@property (nonatomic, strong) IBOutlet UILabel *mainDescripLbl2;
@property (nonatomic, strong) IBOutlet UILabel *mainDescripLbl3;


// Tab Screens
@property (nonatomic, strong) IBOutlet UIImageView *imgView;
@property (nonatomic, strong) IBOutlet UILabel *titleLbl;
@property (nonatomic, strong) IBOutlet UILabel *descripLbl;
@property (nonatomic, strong) IBOutlet UIButton *doneBtn;

- (IBAction)btnAction:(id)sender;


@end
