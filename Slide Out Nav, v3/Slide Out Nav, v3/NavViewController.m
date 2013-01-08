//
//  NavViewController.m
//  Slide Out Nav, v3
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
@synthesize menuXState1;
@synthesize menuXState2;

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
    
    CGRect frame = [[appController contentView] bounds];
    frame.size.width = MIN(frame.size.width*0.8, 320);
    frame.origin.x = -frame.size.width;
    frame.origin.y = 0;
    [[self view] setFrame:frame];
    [self setMenuWidth:frame.size.width];
    [self setMenuXState1:[[self view] center].x];
    [self setMenuXState2:menuXState1 + menuWidth];
    
    UITapGestureRecognizer* contentTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentTapped)];
    [[appController contentView] addGestureRecognizer:contentTapGesture];
    
    UIPanGestureRecognizer* menuPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(menuPanning:)];
    [menuPanGesture setMaximumNumberOfTouches:1];
    [menuPanGesture setDelegate:(id)self];
    [[self view] addGestureRecognizer:menuPanGesture];

    [[appController view] addSubview:[self view]];
}

- (void)contentTapped
{
    if (!visible) return;
    [self toggleShow];
}

- (void)menuPanning:(UIPanGestureRecognizer *)gesture
{
    UIView *piece = [gesture view];
    [self adjustAnchorForPanning:gesture];
    
    if ([gesture state] == UIGestureRecognizerStateBegan || [gesture state] == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [gesture locationInView:[piece superview]];
        translation.y = [piece center].y;
        
        if (translation.x > menuWidth) {
            translation.x = menuXState1 + menuWidth;
        } else {
            translation.x += menuXState1;
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
    
    CGPoint menuDest = [[self view] center];
    float xDiff = menuDest.x;
    float maxDuration = 0.1;
    float shadowOpacity;
    
    if (visible) {
        
        xDiff -= menuXState1;
        menuDest.x = menuXState1;
        shadowOpacity = 0.0;
        
    } else {
        
        xDiff = menuXState2 - xDiff;
        menuDest.x = menuXState2;
        shadowOpacity = 1.0;
    }
    
    xDiff /= menuWidth;
    menuDest.x = visible ? menuXState1 : menuXState2;
    
    CALayer* menuLayer = [[self view] layer];
    [menuLayer setShadowColor:[[UIColor blackColor] CGColor]];
    [menuLayer setShadowRadius:10.0];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:xDiff * maxDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    [[self view] setCenter:menuDest];
    [menuLayer setShadowOpacity:shadowOpacity];
    
    [UIView commitAnimations];
    
    [self setVisible:!visible];
    
}

@end
