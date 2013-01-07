//
//  ViewController.m
//  WindowPanes
//
//  Created by Tucker Bickler on 1/4/13.
//  Copyright (c) 2013 Tucker Bickler. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize paneScroller;
@synthesize panes;
@synthesize origDim;
@synthesize currentPane;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int paneCount = 3;
    [self setCurrentPane:0];
    [self setPanes: [[NSMutableArray alloc] initWithCapacity:paneCount]];
    
    CGRect appFrame = [UIScreen mainScreen].bounds;
    [self setOrigDim:appFrame];
    [paneScroller setFrame:appFrame];
    [paneScroller setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [paneScroller setAutoresizesSubviews:YES];
    [[self view] setBackgroundColor:[UIColor blackColor]];
    
    for (int i = 0; i < paneCount; i+=1) {
        CGRect frame;
        frame.size = [paneScroller frame].size;
        frame.origin.x = frame.size.width * i;
        frame.origin.y = 0;
        
        PaneViewController* pane = [[PaneViewController alloc] initWithNibName:@"PaneViewController" bundle:[NSBundle mainBundle]];
        [[pane view] setFrame:frame];
        [pane setup];
        
        [panes insertObject:pane atIndex:i];
        [paneScroller addSubview:[pane view]];
    }
    
    [paneScroller setContentSize:CGSizeMake([paneScroller frame].size.width * paneCount, [paneScroller frame].size.height)];
    [paneScroller setPagingEnabled:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // prevent vertical scrolling
    [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0)];
    
    // determine current page
    [self setCurrentPane:round(scrollView.contentOffset.x / [paneScroller frame].size.width)];
    
    [self notifyPanesOfLocation:scrollView.contentOffset.x];
}

- (void)notifyPanesOfLocation:(integer_t) offset_x
{
    
    int x = fmodf( offset_x, [paneScroller frame].size.width);
    
    float z = [self getPageZ:x];
    
    for (int i = 0; i < [panes count]; i += 1) {
        [(PaneViewController *)[panes objectAtIndex:i] zDidChange:z];
    }
}

- (float)getPageZ:(integer_t) x
{
    
    float half = [paneScroller frame].size.width/2;
    float pos, z;
    
    // normalize
    if (x > half) {
        pos = [paneScroller frame].size.width - x;
    } else {
        pos = x;
    }
    pos /= half;
    
    z = - fabs( sin( pos * M_PI_2)) + 1.0;
    
    return z;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    CGRect appFrame = origDim;
    
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        appFrame.size.height = origDim.size.width;
        appFrame.size.width = origDim.size.height;
        
    } else if (!UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        NSLog(@"here");
        return;
    }
    
    [paneScroller setFrame:appFrame];
    [paneScroller setContentSize:CGSizeMake(appFrame.size.width * [panes count], appFrame.size.height)];
    for (int i = 0; i < [panes count]; i+=1) {
        CGRect frame;
        frame.size = appFrame.size;
        frame.origin.x = frame.size.width * i;
        frame.origin.y = 0;
        [[(PaneViewController*)[panes objectAtIndex:i] view] setFrame:frame];
    }
    
    // scroll to the current page
    CGRect currentFrame = [[(PaneViewController*)[panes objectAtIndex:currentPane] view] frame];
    [paneScroller scrollRectToVisible:currentFrame animated:NO];
}

@end
