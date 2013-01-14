//
//  MenuViewController.m
//  Slide Out Nav, v4
//
//  Created by Tucker Bickler on 1/7/13.
//  Copyright (c) 2013 Tucker Bickler. All rights reserved.
//

#import "MenuViewController.h"
#import "ViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize visible;
@synthesize contentView;
@synthesize foldImg;
@synthesize searchBar;
@synthesize resultsView;

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
    [self setContentView:[appController contentView]];
    
    CGRect frame = [contentView bounds];
    frame.size.width = 264.0;
    frame.origin.x = 0;
    frame.origin.y = 0;
    [[self view] setFrame:frame];
    
    UIView* appContentView = [appController contentView];
    CALayer* contentLayer = [appContentView layer];
    [contentLayer setShadowColor:[[UIColor blackColor] CGColor]];
    [contentLayer setShadowOpacity:1.0];
    [contentLayer setShadowRadius:10.0];
    
    UIImage* menuImg = [UIImage imageNamed:@"menu.png"];
    [self setFoldImg:menuImg];
    
    for (int i = 0; i < [[[self view] subviews] count]; i += 1) {
        [[[[self view] subviews] objectAtIndex:i] setHidden:!visible];
    }
    
    UITapGestureRecognizer* resultsTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resultsTapped)];
    [resultsView addGestureRecognizer:resultsTapGesture];
    
    UITapGestureRecognizer* contentTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentTapped)];
    [contentView addGestureRecognizer:contentTapGesture];

//    UIPanGestureRecognizer* contentPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(contentPanning:)];
//    [contentPanGesture setMaximumNumberOfTouches:1];
//    [contentPanGesture setDelegate:(id)self];
//    [contentView addGestureRecognizer:contentPanGesture];

    [[appController view] addSubview:[self view]];
}

- (void)contentTapped
{
    if (!visible) return;
    [self toggleShow];
}

//- (void)contentPanning:(UIPanGestureRecognizer *)gesture
//{
//    UIView *piece = [gesture view];
//    [self adjustAnchorForPanning:gesture];
//    
////    if ([gesture state] == UIGestureRecognizerStateBegan || [gesture state] == UIGestureRecognizerStateChanged) {
////        
////        CGPoint translation = [gesture locationInView:[piece superview]];
////        translation.y = [piece center].y;
////        
////        if (translation.x > menuWidth) {
////            translation.x = appXState1 + menuWidth;
////        } else {
////            translation.x += appXState1;
////        }
////        
////        [piece setCenter:translation];
////    }
////    
////    else if ([gesture state] == UIGestureRecognizerStateEnded)
////        [self toggleShow];
//}

//- (void)adjustAnchorForPanning:(UIPanGestureRecognizer *)gestureRecognizer
//{
//    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
//        UIView *piece = gestureRecognizer.view;
//        CGPoint locationInView = [gestureRecognizer locationInView:piece];
//        double startPos = piece.frame.origin.x;// + piece.frame.size.width/2.0;
//        double endPos = piece.frame.origin.x + locationInView.x;// + piece.frame.size.width/2.0;
//        CGRect destFrame = CGRectMake(endPos, 0, piece.frame.size.width, piece.frame.size.height);
//        
////        NSLog(@"%f %f", startPos, endPos);
////        
//////        locationInSuperview.y = [piece center].y;
//////        [piece setCenter:locationInSuperview];
//////        NSLog(@"%@",piece);
////        
////        [CATransaction begin];
////        [CATransaction setCompletionBlock:^{
//////            [contentView setFrame:destFrame];
//////            [self setVisible:!visible];
//////            
//////            // show all subviews on completion
//////            for (int i = 0; i < [[menuView subviews] count]; i += 1) {
//////                [[[menuView subviews] objectAtIndex:i] setHidden:NO];
//////            }
//////            
//////            [foldTopLayer removeFromSuperlayer];
////            NSLog(@"done");
////        }];
////        
////        [CATransaction setValue:[NSNumber numberWithFloat:0.1] forKey:kCATransactionAnimationDuration];
//////        CAAnimation* openAnimation = [self foldAnimationWithKeyPath:@"position.x" function:openFn startValue:[contentView frame].size.width/2.0 endValue:[contentView frame].size.width/2.0 + [menuView bounds].size.width];
////
////        
////        // animate on transform.rotation.x
////        CABasicAnimation* setAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
////        [setAnimation setFromValue:[NSNumber numberWithDouble:startPos]];
////        [setAnimation setToValue:[NSNumber numberWithDouble:endPos]];
////        [setAnimation setFillMode:kCAFillModeForwards];
////        [setAnimation setRemovedOnCompletion:NO];
////        [[contentView layer] addAnimation:setAnimation forKey:@"position"];
////        [CATransaction commit];
////        
////        NSLog(@"here %f %f", startPos, endPos);
//        
//        [CATransaction begin];
//        [CATransaction setCompletionBlock:^{
////            [[contentView layer] setFrame:destFrame];
//        }];
//        [CATransaction setValue:[NSNumber numberWithFloat:0.1] forKey:kCATransactionAnimationDuration];
//        NSLog(@"%f %f", startPos, endPos);
//        CAAnimation* setAnimation = [self foldAnimationWithKeyPath:@"position.x" function:openFn startValue:startPos endValue:endPos];
//        [setAnimation setFillMode:kCAFillModeForwards];
//        [setAnimation setRemovedOnCompletion:NO];
//        [[contentView layer] addAnimation:setAnimation forKey:@"position"];
//        [CATransaction commit];
//        
//    }
//}

- (void)resultsTapped
{
    [searchBar resignFirstResponder];
}

- (void)toggleShow
{
    
    float duration = 0.2;
    UIView* menuView = [self view];
    
    CGRect destFrame = [contentView frame];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/800.0;
    CALayer* foldTopLayer = [CALayer layer];
    [foldTopLayer setFrame:[menuView bounds]];
    [foldTopLayer setSublayerTransform:transform];
    [[menuView layer] addSublayer:foldTopLayer];
    
    double angle;
    CGFloat menuWidth = [menuView bounds].size.width;
    CGFloat menuHeight = [menuView bounds].size.height;
    CGFloat foldSectionWidth = menuWidth/2.0;
    CALayer* foldLayer = foldTopLayer;
    
    if (visible) {
        
        // Hiding
        [searchBar resignFirstResponder];
        
        UIGraphicsBeginImageContext([menuView frame].size);
        [[menuView layer] renderInContext:UIGraphicsGetCurrentContext()];
        UIImage* menuSnapshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self setFoldImg:menuSnapshot];
        
        // calculate the destination of the contentView
        destFrame.origin.x = [contentView frame].origin.x - [menuView bounds].size.width;
        
        // set anchor point
        CGPoint anchorPoint = CGPointMake(0.0, 0.5);
        
        // hide all subviews before animating
        for (int i = 0; i < [[menuView subviews] count]; i += 1) {
            [[[menuView subviews] objectAtIndex:i] setHidden:YES];
        }
        
        // first section
        angle = M_PI_2;
        CGRect sectionFrame1 = CGRectMake(0*foldSectionWidth, 0, foldSectionWidth, menuHeight);
        CATransformLayer* transLayer1 = [self transformFoldSection:menuSnapshot frame:sectionFrame1 duration:duration anchorPoint:anchorPoint startAngle:0 endAngle:angle];
        [foldLayer addSublayer:transLayer1];
        foldLayer = transLayer1;
        
        // second section
        angle = -M_PI;
        CGRect sectionFrame2 = CGRectMake(1*foldSectionWidth, 0, foldSectionWidth, menuHeight);
        CATransformLayer* transLayer2 = [self transformFoldSection:menuSnapshot frame:sectionFrame2 duration:duration anchorPoint:anchorPoint startAngle:0 endAngle:angle];
        [foldLayer addSublayer:transLayer2];
        foldLayer = transLayer2;
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            [contentView setFrame:destFrame];
            [foldTopLayer removeFromSuperlayer];
            [self setVisible:!visible];
        }];
        
        [CATransaction setValue:[NSNumber numberWithFloat:duration] forKey:kCATransactionAnimationDuration];
        CAAnimation* closeAnimation = [self foldAnimationWithKeyPath:@"position.x" function:closeFn startValue:[contentView frame].origin.x + [contentView frame].size.width/2.0 endValue:[contentView frame].size.width/2.0];
        [closeAnimation setFillMode:kCAFillModeForwards];
        [closeAnimation setRemovedOnCompletion:NO];
        [[contentView layer] addAnimation:closeAnimation forKey:@"position"];
        [CATransaction commit];
        
    } else {
        
        // Showing
        
        UIImage* menuSnapshot = [self foldImg];
        
        destFrame.origin.x = [contentView frame].origin.x + [menuView bounds].size.width;
        
        // set anchor point
        CGPoint anchorPoint = CGPointMake(0.0, 0.5);
        
        // first section
        angle = M_PI_2;
        CGRect sectionFrame1 = CGRectMake(0*foldSectionWidth, 0, foldSectionWidth, menuHeight);
        CATransformLayer* transLayer1 = [self transformFoldSection:menuSnapshot frame:sectionFrame1 duration:duration anchorPoint:anchorPoint startAngle:angle endAngle:0];
        [foldLayer addSublayer:transLayer1];
        foldLayer = transLayer1;
        
        // second section
        angle = -M_PI;
        CGRect sectionFrame2 = CGRectMake(1*foldSectionWidth, 0, foldSectionWidth, menuHeight);
        CATransformLayer* transLayer2 = [self transformFoldSection:menuSnapshot frame:sectionFrame2 duration:duration anchorPoint:anchorPoint startAngle:angle endAngle:0];
        [foldLayer addSublayer:transLayer2];
        foldLayer = transLayer2;
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            [contentView setFrame:destFrame];
            [self setVisible:!visible];
            
            // show all subviews on completion
            for (int i = 0; i < [[menuView subviews] count]; i += 1) {
                [[[menuView subviews] objectAtIndex:i] setHidden:NO];
            }
            
            [foldTopLayer removeFromSuperlayer];
        }];

        [CATransaction setValue:[NSNumber numberWithFloat:duration] forKey:kCATransactionAnimationDuration];
        CAAnimation* openAnimation = [self foldAnimationWithKeyPath:@"position.x" function:openFn startValue:[contentView frame].size.width/2.0 endValue:[contentView frame].size.width/2.0 + [menuView bounds].size.width];
        [openAnimation setFillMode:kCAFillModeForwards];
        [openAnimation setRemovedOnCompletion:NO];
        [[contentView layer] addAnimation:openAnimation forKey:@"position"];
        [CATransaction commit];
        

        
    }
    
}

- (CATransformLayer *)transformFoldSection:(UIImage *)menuSnapshot frame:(CGRect)frame duration:(CGFloat)duration anchorPoint:(CGPoint)anchorPoint startAngle:(double)startAngle endAngle:(double)endAngle
{
    CATransformLayer* jointLayer = [CATransformLayer layer];
    [jointLayer setAnchorPoint:anchorPoint];
    CALayer* imgLayer = [CALayer layer];
    
    CGFloat layerWidth = menuSnapshot.size.width - frame.origin.x;
    if (frame.origin.x) {
        [jointLayer setPosition:CGPointMake(frame.size.width, 0)];
    } else {
        [jointLayer setPosition:CGPointMake(0, 0)];
    }
    
    [imgLayer setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [imgLayer setAnchorPoint:anchorPoint];
    [imgLayer setPosition:CGPointMake(layerWidth*anchorPoint.x, frame.size.height/2.0)];
    [jointLayer addSublayer:imgLayer];
    CGImageRef menuCrop = CGImageCreateWithImageInRect([menuSnapshot CGImage], frame);
    // transfer pointer between ObjC and CoreAnimation
    [imgLayer setContents:(__bridge id)menuCrop];
    [imgLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    [animation setDuration:duration];
    [animation setFromValue:[NSNumber numberWithDouble:startAngle]];
    [animation setToValue:[NSNumber numberWithDouble:endAngle]];
    [animation setRemovedOnCompletion:NO];
    [jointLayer addAnimation:animation forKey:@"jointAnimation"];
    
    return jointLayer;
}

// func to determine location of contents view while folding menu
double (^openFn)(double) = ^double(double time) {
    return sin(time*M_PI_2);
};
double (^closeFn)(double) = ^double(double time) {
    return -cos(time*M_PI_2) + 1;
};

// Get animation frames
- (id) foldAnimationWithKeyPath:(NSString*)path function:(double (^)(double))block startValue:(double)startValue endValue:(double)endValue
{
    // animate on transform.rotation.x
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path];
    
    // make the animation have 40 frames
    NSInteger diff = endValue - startValue;
    NSUInteger frameCount = 40;
    
    // calculate the value of each frame
    NSMutableArray* frameValues = [NSMutableArray arrayWithCapacity:frameCount];
    double time = 0.0;
    // normalize our timestep
    double timeStep = 1.0 / (double)(frameCount - 1);
    for (NSUInteger i = 0; i < frameCount; i+=1) {
        // scale our time value to be point between start and end
        double value = startValue + (block(time) * diff);
        [frameValues addObject:[NSNumber numberWithDouble:value]];
        // advance current frame
        time += timeStep;
    }
    // keep time between frames constant
    animation.calculationMode = kCAAnimationLinear;
    
    // assign our keyframes
    [animation setValues:frameValues];
    
    return animation;
}

@end
