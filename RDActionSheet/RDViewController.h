//
//  RDViewController.h
//  RDActionSheet
//
//  Created by Red Davis on 16/03/2012.
//  Copyright (c) 2012 Red Davis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDActionSheet.h"

@interface RDViewController : UIViewController <RDActionSheetDelegate>

@property (nonatomic, strong) IBOutlet UIButton *showActionSheetButton;

- (IBAction)showActionSheet:(id)sender;

@end
