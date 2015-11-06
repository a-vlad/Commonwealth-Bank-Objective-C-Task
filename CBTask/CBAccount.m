//
//  CBAccount.m
//  CBTask
//
//  Created by Vlad Paraschiv on 14/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "CBAccount.h"
#import "NSNumber+Helpers.h"

static const NSString *kAccountName         = @"accountName";
static const NSString *kAccountNumber       = @"accountNumber";
static const NSString *kAvailableBalanceKey = @"available";
static const NSString *kBalanceKey          = @"balance";

@implementation CBAccount

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        self.accountName        = dictionary[kAccountName];
        self.accountNumber      = dictionary[kAccountNumber];
        self.availableFunds     = dictionary[kAvailableBalanceKey];
        self.balance            = dictionary[kBalanceKey];
    }
    return self;
}

@end
