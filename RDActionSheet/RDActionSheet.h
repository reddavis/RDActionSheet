//
//  LBActionSheet.h
//  LetterBoxd
//
//  Created by Red Davis on 12/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RDActionSheet;
@protocol RDActionSheetDelegate;

@interface RDActionSheet : UIView

@property (nonatomic, unsafe_unretained) NSObject <RDActionSheetDelegate> *delegate;

- (id)initWithDelegate:(NSObject <RDActionSheetDelegate> *)aDelegate cancelButtonTitle:(NSString *)cancelButtonTitle primaryButtonTitle:(NSString *)primaryButtonTitle destroyButtonTitle:(NSString *)destroyButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (void)showFrom:(UIView *)view;
- (void)cancelActionSheet;

@end

@protocol RDActionSheetDelegate
- (void)actionSheet:(RDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@optional
- (void)actionSheetDidBecomeCancelled:(RDActionSheet *)actionSheet;
@end