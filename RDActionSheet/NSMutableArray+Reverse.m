//
//  NSMutableArray.m
//  RiotHats
//
//  Created by Red Davis on 15/02/2012.
//  Copyright (c) 2012 Riot. All rights reserved.
//

#import "NSMutableArray+Reverse.h"

@implementation NSMutableArray(Reverse)

- (void)reverse {
    NSInteger i = 0;
    NSInteger j = [self count] - 1;
    
    while (i < j) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:j];  
        i++;
        j--;
    }
}

@end
