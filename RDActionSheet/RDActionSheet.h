//
//  RDActionSheet.h
//  RDActionSheet v1.1.0
//
//  Created by Red Davis on 12/01/2012.
//  Copyright (c) 2012 Riot. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RDActionSheet;
@protocol RDActionSheetDelegate;

typedef enum RDActionSheetResult {
    RDActionSheetButtonResultSelected,
    RDActionSheetResultResultCancelled
} RDActionSheetResult;

typedef enum RDActionSheetCallbackType {
    RDActionSheetCallbackTypeClickedButtonAtIndex,
    RDActionSheetCallbackTypeDidDismissWithButtonIndex,
    RDActionSheetCallbackTypeWillDismissWithButtonIndex,
    RDActionSheetCallbackTypeWillPresentActionSheet,
    RDActionSheetCallbackTypeDidPresentActionSheet
} RDActionSheetCallbackType;

typedef void(^RDCallbackBlock)(RDActionSheetResult result, NSInteger buttonIndex) __attribute__((deprecated));
typedef void(^RDActionSheetCallbackBlock)(RDActionSheetCallbackType result, NSInteger buttonIndex, NSString *buttonTitle);

@interface RDActionSheet : UIView

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, unsafe_unretained) NSObject <RDActionSheetDelegate> *delegate;
@property (nonatomic, copy) RDActionSheetCallbackBlock callbackBlock;

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;

- (id)initWithDelegate:(NSObject <RDActionSheetDelegate> *)aDelegate cancelButtonTitle:(NSString *)cancelButtonTitle primaryButtonTitle:(NSString *)primaryButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... __attribute__ ((deprecated));

- (id)initWithCancelButtonTitle:(NSString *)cancelButtonTitle primaryButtonTitle:(NSString *)primaryButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle primaryButtonTitle:(NSString *)primaryButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (void)showFrom:(UIView *)view;

- (void)cancelActionSheet;

@end

@protocol RDActionSheetDelegate
@optional
- (void)willPresentActionSheet:(RDActionSheet *)actionSheet;  // before animation and showing view
- (void)didPresentActionSheet:(RDActionSheet *)actionSheet;  // after animation
- (void)actionSheet:(RDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;  // when user taps a button
- (void)actionSheet:(RDActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after hide animation
- (void)actionSheet:(RDActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex;  // before hide animation
@end
