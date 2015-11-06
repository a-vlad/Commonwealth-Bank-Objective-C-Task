//
//  CBPendingTransaction.m
//  CBTask
//
//  Created by Vlad Paraschiv on 14/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "CBPendingTransaction.h"

@implementation CBPendingTransaction

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        /* nothing extra to construct for pending transaction */
    }
    return self;
}

@end
