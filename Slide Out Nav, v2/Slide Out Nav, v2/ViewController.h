//
//  ViewController.h
//  Slide Out Nav, v1
//
//  Created by Tucker Bickler on 1/7/13.
//  Copyright (c) 2013 Tucker Bickler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavViewController.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) NavViewController* navViewController;

- (IBAction)navButtonPressed:(id)sender;

@end
