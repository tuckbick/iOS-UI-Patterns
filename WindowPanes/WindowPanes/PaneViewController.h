//
//  PaneViewController.h
//  WindowPanes
//
//  Created by Tucker Bickler on 1/4/13.
//  Copyright (c) 2013 Tucker Bickler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaneViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *pane;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property(nonatomic) float currentScale;
@property (strong, nonatomic) IBOutlet UIView *view;

- (void) setup;
- (void) zDidChange:(float) z;

@end
