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

typedef void(^RDCallbackBlock)(RDActionSheetResult result, NSInteger buttonIndex);


@interface RDActionSheet : UIView

@property (nonatomic, unsafe_unretained) NSObject <RDActionSheetDelegate> *delegate;
@property (nonatomic, copy) RDCallbackBlock callbackBlock;

- (id)initWithDelegate:(NSObject <RDActionSheetDelegate> *)aDelegate cancelButtonTitle:(NSString *)cancelButtonTitle primaryButtonTitle:(NSString *)primaryButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles __attribute__ ((deprecated));

- (id)initWithCancelButtonTitle:(NSString *)cancelButtonTitle primaryButtonTitle:(NSString *)primaryButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle primaryButtonTitle:(NSString *)primaryButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray*)otherButtonTitles;

- (void)showFrom:(UIView *)view;

-(void)showFrom:(UIView*)view inRect:(CGRect)rect;

- (void)cancelActionSheet;

@end

@protocol RDActionSheetDelegate
@optional
- (void)actionSheet:(RDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)actionSheetDidBecomeCancelled:(RDActionSheet *)actionSheet;
@end
