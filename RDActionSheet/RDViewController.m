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

- (IBAction)showActionSheet:(id)sender {
    
    RDActionSheet *actionSheet = [[RDActionSheet alloc] initWithTitle:@"Here's a title that is hopefully long enough to require multiple lines" cancelButtonTitle:@"Cancel" primaryButtonTitle:@"Save" destructiveButtonTitle:@"Destroy" otherButtonTitles:@"Tweet", nil];
    
    actionSheet.callbackBlock = ^(RDActionSheetResult result, NSInteger buttonIndex) {
        switch (result) {
            case RDActionSheetButtonResultSelected:
                NSLog(@"Pressed %i", buttonIndex);
                break;
            case RDActionSheetResultResultCancelled:
                NSLog(@"Sheet cancelled");
        }
    };
    
    [actionSheet showFrom:self.view];
}

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
