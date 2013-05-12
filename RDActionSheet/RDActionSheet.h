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

typedef void(^RDActionSheetCallbackBlock)(RDActionSheetCallbackType result, NSInteger buttonIndex, NSString *buttonTitle);


@interface RDActionSheet : UIView

@property (strong, nonatomic) NSMutableArray *buttons;
@property (weak, nonatomic) id <RDActionSheetDelegate> delegate;
@property (copy, nonatomic) RDActionSheetCallbackBlock callbackBlock;

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;

- (id)initWithCancelButtonTitle:(NSString *)cancelButtonTitle primaryButtonTitle:(NSString *)primaryButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle primaryButtonTitle:(NSString *)primaryButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (void)showFrom:(UIView *)view;
- (void)cancelActionSheet;

@end


@protocol RDActionSheetDelegate <NSObject>
@optional
- (void)willPresentActionSheet:(RDActionSheet *)actionSheet;  // before animation and showing view
- (void)didPresentActionSheet:(RDActionSheet *)actionSheet;  // after animation
- (void)actionSheet:(RDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;  // when user taps a button
- (void)actionSheet:(RDActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after hide animation
- (void)actionSheet:(RDActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex;  // before hide animation
@end
