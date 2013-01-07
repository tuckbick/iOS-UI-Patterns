//
//  ViewController.h
//  WindowPanes
//
//  Created by Tucker Bickler on 1/4/13.
//  Copyright (c) 2013 Tucker Bickler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaneViewController.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *paneScroller;
@property (strong, nonatomic) NSMutableArray* panes;
@property (nonatomic) CGRect origDim;
@property (nonatomic) int currentPane;

@end
