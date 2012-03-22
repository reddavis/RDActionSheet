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
    
    RDActionSheet *actionSheet = [[RDActionSheet alloc] initWithDelegate:self cancelButtonTitle:@"Cancel" primaryButtonTitle:@"Save" destroyButtonTitle:@"Destroy" otherButtonTitles:@"Tweet", nil];
    [actionSheet showFrom:self.view];
}

#pragma mark - RDActionSheetDelegate

- (void)actionSheet:(RDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"Pressed %i", buttonIndex);
}

- (void)actionSheetDidBecomeCancelled:(RDActionSheet *)actionSheet {
    
    NSLog(@"Sheet cancelled");
}

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
