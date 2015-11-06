//
//  CBCustomer.m
//  CBTask
//
//  Created by Vlad Paraschiv on 14/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "CBCustomer.h"

static const NSString *kAccountKey      = @"account";
static const NSString *kTransactionsKey = @"transactions";
static const NSString *kPendingKey      = @"pending";
static const NSString *kAtmsKey         = @"atms";


@implementation CBCustomer

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        self.account = [[CBAccount alloc] initWithDictionary:dictionary[kAccountKey]];
        
        // parse transactions
        NSMutableArray *transactionsArray = [NSMutableArray new];
        for (NSDictionary *dict in dictionary[kTransactionsKey]){
            CBTransaction *tmpTransaction = [[CBTransaction alloc] initWithDictionary:dict];
            [transactionsArray addObject:tmpTransaction];
        }
        // parse pending transactions
        for (NSDictionary *dict in dictionary[kPendingKey]){
            CBPendingTransaction *tmpTransaction = [[CBPendingTransaction alloc] initWithDictionary:dict];
            [transactionsArray addObject:tmpTransaction];
        }
        self.transactions = transactionsArray;
        
        // parse atm list
        NSMutableArray *atmsArray = [NSMutableArray new];
        for (NSDictionary *dict in dictionary[kAtmsKey]){
            CBAtm *tmpTransaction = [[CBAtm alloc] initWithDictionary:dict];
            [atmsArray addObject:tmpTransaction];
        }
        self.atms = atmsArray;
    }
    return self;
}

@end
