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
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - Show action sheet action

- (IBAction)showActionSheet:(id)sender {
    
    RDActionSheet *actionSheet = [[RDActionSheet alloc] initWithDelegate:self cancelButtonTitle:@"Cancel" primaryButtonTitle:@"Save" destroyButtonTitle:@"Destroy" otherButtonTitles:@"Email", @"Tweet", nil];
    
    [actionSheet showFrom:self.view];
}

#pragma mark - RDActionSheetDelegate

- (void)actionSheet:(RDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
}

- (void)actionSheetDidBecomeCancelled:(RDActionSheet *)actionSheet {
    
    
}

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
