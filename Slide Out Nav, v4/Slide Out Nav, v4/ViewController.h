//
//  ViewController.h
//  Slide Out Nav, v1
//
//  Created by Tucker Bickler on 1/7/13.
//  Copyright (c) 2013 Tucker Bickler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) MenuViewController* menuViewController;

- (IBAction)menuButtonSelected:(id)sender;

@end
