//
//  RDViewController.m
//  RDActionSheet
//
//  Created by Red Davis on 16/03/2012.
//  Copyright (c) 2012 Red Davis. All rights reserved.
//

#import "RDViewController.h"

@interface RDViewController ()

@end

@implementation RDViewController

@synthesize showActionSheetButton;

#pragma mark - View management

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
}

#pragma mark - Action sheet

#define shouldUseDelegateExample 1

- (IBAction)showActionSheet:(id)sender {
    
    RDActionSheet *actionSheet = [[RDActionSheet alloc] initWithTitle:@"Here's a title that is hopefully long enough to require multiple lines" cancelButtonTitle:@"Cancel" primaryButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"a", @"b", nil];
    if (shouldUseDelegateExample) {
        NSLog(@"Delegate callbacks enabled");
        actionSheet.delegate = self;
    } else {
        NSLog(@"Block callbacks enabled");
        actionSheet.callbackBlock = ^(RDActionSheetCallbackType type, NSInteger buttonIndex, NSString *buttonTitle) {
            switch (type) {
                case RDActionSheetCallbackTypeClickedButtonAtIndex:
                    NSLog(@"RDActionSheetCallbackTypeClickedButtonAtIndex %d, title %@", buttonIndex, buttonTitle);
                    break;
                case RDActionSheetCallbackTypeDidDismissWithButtonIndex:
                    NSLog(@"RDActionSheetCallbackTypeDidDismissWithButtonIndex %d, title %@", buttonIndex, buttonTitle);
                    break;
                case RDActionSheetCallbackTypeWillDismissWithButtonIndex:
                    NSLog(@"RDActionSheetCallbackTypeWillDismissWithButtonIndex %d, title %@", buttonIndex, buttonTitle);
                    break;
                case RDActionSheetCallbackTypeDidPresentActionSheet:
                    NSLog(@"RDActionSheetCallbackTypeDidPresentActionSheet");
                    break;
                case RDActionSheetCallbackTypeWillPresentActionSheet:
                    NSLog(@"RDActionSheetCallbackTypeDidPresentActionSheet");
                    break;
            }
        };
    }    
    [actionSheet showFrom:self.view];
}

-(void)actionSheet:(RDActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"didDismissWithButtonIndex %d", buttonIndex);
}

-(void)actionSheet:(RDActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"willDismissWithButtonIndex %d", buttonIndex);
}

-(void)willPresentActionSheet:(RDActionSheet *)actionSheet {
    NSLog(@"willPresentActionSheet");
}

-(void)didPresentActionSheet:(RDActionSheet *)actionSheet {
    NSLog(@"didPresentActionSheet");
}

-(void)actionSheet:(RDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"clickedButtonAtIndex %d", buttonIndex);
    NSLog(@"%@", [actionSheet buttonTitleAtIndex:buttonIndex]);
}

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
