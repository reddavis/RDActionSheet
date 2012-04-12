//
//  RDActionSheet.m
//  RDActionSheet v1.1.0
//
//  Created by Red Davis on 12/01/2012.
//  Copyright (c) 2012 Riot. All rights reserved.
//

#import "RDActionSheet.h"
#import <QuartzCore/QuartzCore.h>

@interface RDActionSheet ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UIView *blackOutView;

- (void)setupButtons;
- (void)setupBackground;
- (UIView *)buildBlackOutViewWithFrame:(CGRect)frame;

- (UIButton *)buildButtonWithTitle:(NSString *)title;
- (UIButton *)buildCancelButtonWithTitle:(NSString *)title;
- (UIButton *)buildPrimaryButtonWithTitle:(NSString *)title;
- (UIButton *)buildDestroyButtonWithTitle:(NSString *)title;

- (CGFloat)calculateSheetHeight;

- (void)buttonWasPressed:(id)button;

@end


const CGFloat kButtonPadding = 10;
const CGFloat kButtonHeight = 47;

const CGFloat kPortrainButtonWidth = 300;
const CGFloat kLandscapeButtonWidth = 450;

const CGFloat kActionSheetAnimationTime = 0.2;
const CGFloat kBlackoutViewFadeInOpacity = 0.6;


@implementation RDActionSheet

@synthesize delegate;
@synthesize callbackBlock;

@synthesize buttons;
@synthesize blackOutView;

@synthesize scrollView;

#pragma mark - Initialization

- (id)init {
    
    self = [super init];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        self.buttons = [NSMutableArray array];
        self.opaque = YES;
    }
    
    return self;
}

- (id)initWithDelegate:(NSObject<RDActionSheetDelegate,UIScrollViewDelegate> *)aDelegate cancelButtonTitle:(NSString *)cancelButtonTitle primaryButtonTitle:(NSString *)primaryButtonTitle destroyButtonTitle:(NSString *)destroyButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    self = [self initWithCancelButtonTitle:cancelButtonTitle primaryButtonTitle:primaryButtonTitle destroyButtonTitle:destroyButtonTitle otherButtonTitles:otherButtonTitles];
    if (self) {
        self.delegate = aDelegate;
    }
    
    return self;
}

- (id)initWithCancelButtonTitle:(NSString *)cancelButtonTitle primaryButtonTitle:(NSString *)primaryButtonTitle destroyButtonTitle:(NSString *)destroyButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    self = [self init];
    if (self) {
        
        // Build normal buttons[mArray getObjects:objects range:range];
        va_list argumentList;
        va_start(argumentList, otherButtonTitles);
        
        NSString *argString = otherButtonTitles;
        while (argString != nil) {
            
            UIButton *button = [self buildButtonWithTitle:argString];
            [self.buttons addObject:button];
            
            argString = va_arg(argumentList, NSString *);
        }
        
        va_end(argumentList);
        
        // Build cancel button
        UIButton *cancelButton = [self buildCancelButtonWithTitle:cancelButtonTitle];
        [self.buttons insertObject:cancelButton atIndex:0];
        /*
         // Add primary button
         if (primaryButtonTitle) {
         UIButton *primaryButton = [self buildPrimaryButtonWithTitle:primaryButtonTitle];
         [self.buttons addObject:primaryButton];
         }
         
         // Add destroy button
         if (destroyButtonTitle) {
         UIButton *destroyButton = [self buildDestroyButtonWithTitle:destroyButtonTitle];
         [self.buttons insertObject:destroyButton atIndex:1];
         } 
         */
    }
    
    return self;
}

- (id)initWithCancelButtonTitleWithNSArray:(NSString *)cancelButtonTitle primaryButtonTitle:(NSString *)primaryButtonTitle destroyButtonTitle:(NSString *)destroyButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles {
    
    self = [self init];
    if (self) {
        // Build normal buttons[mArray getObjects:objects range:range];
        //va_list argumentList;
        //va_start(argumentList, otherButtonTitles);
        
        //NSString *argString = otherButtonTitles;
        for (int x = 0; x<[otherButtonTitles count]; x++) {
            UIButton *button = [self buildButtonWithTitle:[otherButtonTitles objectAtIndex:x]];
            [self.buttons addObject:button];
        }
        /*
         while (argString != nil) {
         
         UIButton *button = [self buildButtonWithTitle:argString];
         [self.buttons addObject:button];
         
         argString = va_arg(argumentList, NSString *);
         }
         
         va_end(argumentList);
         */
        // Build cancel button
        UIButton *cancelButton = [self buildCancelButtonWithTitle:cancelButtonTitle];
        [self.buttons insertObject:cancelButton atIndex:0];
        /*
         // Add primary button
         if (primaryButtonTitle) {
         UIButton *primaryButton = [self buildPrimaryButtonWithTitle:primaryButtonTitle];
         [self.buttons addObject:primaryButton];
         }
         
         // Add destroy button
         if (destroyButtonTitle) {
         UIButton *destroyButton = [self buildDestroyButtonWithTitle:destroyButtonTitle];
         [self.buttons insertObject:destroyButton atIndex:1];
         } 
         */
    }
    
    return self;
}

#pragma mark - View setup

- (void)layoutSubviews {
    
    [self setupBackground];
    [self setupButtons];
}

- (void)setupBackground {
    
    UIImage *backgroundImage = [[UIImage imageNamed:@"SheetBackground.png"] stretchableImageWithLeftCapWidth:0.5 topCapHeight:0];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.frame.size.width, self.frame.size.height), YES, 0);
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    // Fill the context
    UIColor *fillColor = [UIColor colorWithRed:18/255.0 green:18/255.0 blue:18/255.0 alpha:1];
    CGContextSetFillColorWithColor(con, fillColor.CGColor);
    CGContextFillRect(con, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    
    // Draw gradient
    [backgroundImage drawInRect:CGRectMake(0, 0, self.frame.size.width, backgroundImage.size.height)];
    
    // Draw Line
    CGFloat lineYAxis = self.frame.size.height - (kButtonPadding * 2 + kButtonHeight);
    
    CGContextBeginPath(con);
    CGContextSetStrokeColorWithColor(con, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(con, 1);
    CGContextMoveToPoint(con, 0, lineYAxis);
    CGContextAddLineToPoint(con, self.frame.size.width, lineYAxis);
    CGContextStrokePath(con);
    
    CGContextBeginPath(con);
    UIColor *strokeColor = [UIColor colorWithRed:42/255.0 green:45/255.0 blue:48/255.0 alpha:1];
    CGContextSetStrokeColorWithColor(con, strokeColor.CGColor);
    CGContextSetLineWidth(con, 1);
    CGContextMoveToPoint(con, 0, lineYAxis + 1);
    CGContextAddLineToPoint(con, self.frame.size.width, lineYAxis + 1);
    CGContextStrokePath(con);
    
    UIImage *finishedBackground = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *background = [[UIImageView alloc] initWithImage:finishedBackground];
    background.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self insertSubview:background atIndex:0];
}

- (void)setupButtons {
    
    CGFloat yOffset = self.frame.size.height - kButtonPadding - floorf(kButtonHeight/2);
    
    BOOL cancelButton = YES;
    for (UIButton *button in self.buttons) {
        
        CGFloat buttonWidth;
        UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
        if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
            buttonWidth = kLandscapeButtonWidth;
        } 
        else {
            buttonWidth = kPortrainButtonWidth;
        }
        
        button.frame = CGRectMake(0, 0, buttonWidth, kButtonHeight);
        button.center = CGPointMake(self.center.x, yOffset);
        [self addSubview:button];
        
        yOffset -= button.frame.size.height + kButtonPadding;
        
        // We draw a line above the cancel button so add an extra kButtonPadding
        if (cancelButton == YES) {
            yOffset -= kButtonPadding;
            cancelButton = NO;
        }
    }
}

#pragma mark - Blackout view builder

- (UIView *)buildBlackOutViewWithFrame:(CGRect)frame {
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.backgroundColor = [UIColor blackColor];
    view.opaque = YES;
    view.alpha = 0;
    
    return view;
}

#pragma mark - Button builders

- (UIButton *)buildButtonWithTitle:(NSString *)title {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    button.accessibilityLabel = title;
    button.opaque = YES;
    
    [button.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    UIColor *titleColor = [UIColor colorWithRed:18/255.0 green:22/255.0 blue:26/255.0 alpha:1];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    
    UIImage *backgroundImage = [[UIImage imageNamed:@"SheetButtonGeneric.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:1];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    UIImage *touchBackgroundImage = [[UIImage imageNamed:@"SheetButtonGenericTouch.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:1];
    [button setBackgroundImage:touchBackgroundImage forState:UIControlStateHighlighted];
    
    button.titleLabel.layer.shadowColor = [UIColor whiteColor].CGColor;
    button.titleLabel.layer.shadowRadius = 0.0;
    button.titleLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    button.titleLabel.layer.shadowOpacity = 0.5;
    
    return button;
}

- (UIButton *)buildCancelButtonWithTitle:(NSString *)title {
    
    UIButton *button = [self buildButtonWithTitle:title];
    [button removeTarget:self action:@selector(buttonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(cancelActionSheet) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *backgroundImage = [[UIImage imageNamed:@"SheetButtonDismiss.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:1];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    UIImage *touchBackgroundImage = [[UIImage imageNamed:@"SheetButtonDismissTouch.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:1];
    [button setBackgroundImage:touchBackgroundImage forState:UIControlStateHighlighted];
    
    button.titleLabel.layer.shadowOpacity = 0.3;
    
    return button;
}

- (UIButton *)buildPrimaryButtonWithTitle:(NSString *)title {
    
    UIButton *button = [self buildButtonWithTitle:title];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIImage *backgroundImage = [[UIImage imageNamed:@"SheetButtonPrimary.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:1];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    UIImage *touchBackgroundImage = [[UIImage imageNamed:@"SheetButtonPrimaryTouch.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:1];
    [button setBackgroundImage:touchBackgroundImage forState:UIControlStateHighlighted];
    
    button.titleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    button.titleLabel.layer.shadowOffset = CGSizeMake(0.0, -1.0);
    
    return button;
}

- (UIButton *)buildDestroyButtonWithTitle:(NSString *)title {
    
    UIButton *button = [self buildButtonWithTitle:title];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIImage *backgroundImage = [[UIImage imageNamed:@"SheetButtonDestroy.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:1];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    UIImage *touchBackgroundImage = [[UIImage imageNamed:@"SheetButtonDestroyTouch.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:1];
    [button setBackgroundImage:touchBackgroundImage forState:UIControlStateHighlighted];
    
    button.titleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    button.titleLabel.layer.shadowOffset = CGSizeMake(0.0, -1.0);
    
    return button;
}

#pragma mark - Button actions

- (void)buttonWasPressed:(id)button {
    
    NSInteger buttonIndex = [self.buttons indexOfObject:button] - 1;
    
    if (self.callbackBlock) {
        self.callbackBlock(RDActionSheetButtonResultSelected, buttonIndex);
    }
    else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
            [self.delegate actionSheet:self clickedButtonAtIndex:buttonIndex];
        }
    }
    
    [self cancelActionSheet];
}

- (void)cancelActionSheet {
    
    [UIView animateWithDuration:kActionSheetAnimationTime animations:^{
        
        CGFloat endPosition = self.frame.origin.y + self.frame.size.height;
        self.frame = CGRectMake(self.frame.origin.x, endPosition, self.frame.size.width, self.frame.size.height);
        self.blackOutView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
    if (self.callbackBlock) {
        self.callbackBlock(RDActionSheetResultResultCancelled, -1);
    }
    else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheetDidBecomeCancelled:)]) {
            [self.delegate actionSheetDidBecomeCancelled:self];
        }
    }    
}

#pragma mark - Present action sheet
- (void)scrollViewDidScroll:(UIScrollView *)scrollViewInstance {
    if (scrollViewInstance.contentOffset.y > 60) {
        [scrollViewInstance setContentOffset:CGPointMake(0, 60)];
    }
}
- (void)showFrom:(UIView *)view {
    
    CGFloat startPosition = view.bounds.origin.y + view.bounds.size.height;
    self.frame = CGRectMake(0, startPosition, view.bounds.size.width, [self calculateSheetHeight]);
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, startPosition, view.bounds.size.width, view.bounds.size.height)];
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(view.bounds.size.width,[self calculateSheetHeight]);
    [self.scrollView addSubview:self];
    CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
    [self.scrollView bringSubviewToFront:self];
    [view bringSubviewToFront:self.scrollView];
    [view addSubview:self.scrollView];
    
    self.blackOutView = [self buildBlackOutViewWithFrame:view.bounds];
    [view insertSubview:self.blackOutView belowSubview:self.scrollView];
    
    [UIView animateWithDuration:kActionSheetAnimationTime animations:^{    
        CGFloat endPosition = startPosition - self.scrollView.frame.size.height;
        self.frame = CGRectMake(self.frame.origin.x, endPosition, self.frame.size.width, self.frame.size.height);
        self.blackOutView.alpha = kBlackoutViewFadeInOpacity;
    }];   
    
    [UIView animateWithDuration:kActionSheetAnimationTime animations:^{    
        CGFloat endPosition = startPosition - self.scrollView.frame.size.height;
        self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, endPosition, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        self.blackOutView.alpha = kBlackoutViewFadeInOpacity;
    }]; 
}

#pragma mark - Helpers

- (CGFloat)calculateSheetHeight {
    
    return ((kButtonHeight * self.buttons.count) + (self.buttons.count * kButtonPadding) + kButtonHeight/2) + 4;
}

@end
