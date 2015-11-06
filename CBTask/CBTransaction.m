//
//  CBTransaction.m
//  CBTask
//
//  Created by Vlad Paraschiv on 14/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "CBTransaction.h"
#import "NSDate+Helpers.h"

static const NSString *kIdKey               = @"id";
static const NSString *kEffectiveDateKey    = @"effectiveDate";
static const NSString *kDescriptionKey      = @"description";
static const NSString *kAmountKey           = @"amount";

@implementation CBTransaction

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        self.transactionId          = dictionary[kIdKey];
        self.effectiveDate          = [NSDate dateFromString:dictionary[kEffectiveDateKey]];
        self.transactionDescription = dictionary[kDescriptionKey];
        self.amount                 = dictionary[kAmountKey];
    }
    return self;
}

- (BOOL)isAtmTransaction
{
    NSRange range = [self.transactionDescription rangeOfString:@"Wdl ATM" options:NSLiteralSearch];
    
    return (range.location != NSNotFound);
}

@end
