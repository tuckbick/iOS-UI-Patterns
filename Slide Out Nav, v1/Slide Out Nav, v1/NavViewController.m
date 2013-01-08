//
//  NavViewController.m
//  Slide Out Nav, v1
//
//  Created by Tucker Bickler on 1/7/13.
//  Copyright (c) 2013 Tucker Bickler. All rights reserved.
//

#import "NavViewController.h"
#import "ViewController.h"

@interface NavViewController ()

@end

@implementation NavViewController

@synthesize visible;
@synthesize menuWidth;
@synthesize appXState1;
@synthesize appXState2;
@synthesize appView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setVisible:NO];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup:(ViewController*)appController
{
    [self setAppView:[appController view]];
    
    CGRect frame = [appView bounds];
    frame.size.width = MIN(frame.size.width*0.8, 320);
    frame.origin.x = -frame.size.width;
    [[self view] setFrame:frame];
    [self setMenuWidth:frame.size.width];
    [self setAppXState1:[appView center].x];
    [self setAppXState2:appXState1 + menuWidth];
    
    UIView* appContentView = [appController contentView];
    CALayer* contentLayer = [appContentView layer];
    [contentLayer setShadowColor:[[UIColor blackColor] CGColor]];
    [contentLayer setShadowOpacity:1.0];
    [contentLayer setShadowRadius:10.0];
    
    UITapGestureRecognizer* contentTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentTapped)];
    [appView addGestureRecognizer:contentTapGesture];
    
    UIPanGestureRecognizer* contentPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(contentPanning:)];
    [contentPanGesture setMaximumNumberOfTouches:1];
    [contentPanGesture setDelegate:(id)self];
    [appView addGestureRecognizer:contentPanGesture];

    [[appController view] addSubview:[self view]];
}

- (void)contentTapped
{
    if (!visible) return;
    [self toggleShow];
}

- (void)contentPanning:(UIPanGestureRecognizer *)gesture
{
    UIView *piece = [gesture view];
    [self adjustAnchorForPanning:gesture];
    
    if ([gesture state] == UIGestureRecognizerStateBegan || [gesture state] == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [gesture locationInView:[piece superview]];
        translation.y = [piece center].y;
        
        if (translation.x > menuWidth) {
            translation.x = appXState1 + menuWidth;
        } else {
            translation.x += appXState1;
        }
        
        [piece setCenter:translation];
    }
    
    else if ([gesture state] == UIGestureRecognizerStateEnded)
        [self toggleShow];
}

- (void)adjustAnchorForPanning:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        locationInSuperview.y = [piece center].y;
        [piece setCenter:locationInSuperview];
    }
}

- (void)toggleShow
{
    
    CGPoint appDest = [appView center];
    float xDiff = appDest.x;
    float maxDuration = 0.1;
    
    if (visible) {
        
        xDiff -= appXState1;
        appDest.x = appXState1;
        
    } else {
        
        xDiff = appXState2 - xDiff;
        appDest.x = appXState2;
    }
    
    xDiff /= menuWidth;
    appDest.x = visible ? appXState1 : appXState2;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:xDiff * maxDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    [appView setCenter:appDest];
    
    [UIView commitAnimations];
    
    [self setVisible:!visible];
    
}

@end
