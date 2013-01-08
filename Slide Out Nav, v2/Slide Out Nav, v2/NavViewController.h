//
//  NavViewController.h
//  Slide Out Nav, v2
//
//  Created by Tucker Bickler on 1/7/13.
//  Copyright (c) 2013 Tucker Bickler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class ViewController;

@interface NavViewController : UIViewController

@property (weak, nonatomic) UIView *contentView;

@property BOOL visible;
@property float menuWidth;
@property float appXState1;
@property float appXState2;

- (void)setup:(ViewController*)appController;
- (void)toggleShow;

@end
