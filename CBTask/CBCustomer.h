//
//  CBCustomer.h
//  CBTask
//
//  Created by Vlad Paraschiv on 14/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBModel.h"
#import "CBAccount.h"
#import "CBTransaction.h"
#import "CBAtm.h"
#import "CBPendingTransaction.h"

@interface CBCustomer : CBModel

@property (strong, nonatomic) CBAccount                         *account;
@property (strong, nonatomic) NSArray<__kindof CBTransaction*>  *transactions;
@property (strong, nonatomic) NSArray<CBAtm *>                  *atms;

@end
