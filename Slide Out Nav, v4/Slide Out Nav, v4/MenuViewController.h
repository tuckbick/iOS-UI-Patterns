//
//  MenuViewController.h
//  Slide Out Nav, v4
//
//  Created by Tucker Bickler on 1/7/13.
//  Copyright (c) 2013 Tucker Bickler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class ViewController;

@interface MenuViewController : UIViewController


@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *resultsView;

@property (weak, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIImage *foldImg;

@property BOOL visible;

- (void)setup:(ViewController*)appController;
- (void)toggleShow;

@end
