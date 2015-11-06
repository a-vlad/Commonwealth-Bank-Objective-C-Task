//
//  CBCustomer+BusinessLogic.h
//  CBTask
//
//  Created by Vlad Paraschiv on 15/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBCustomer.h"

@interface CBCustomer (BusinessLogic)

/**
 *  Retrieves correct ATM from customer's ATM list for transaction
 */
- (CBAtm*)findAtmForTransaction:(CBTransaction*)transaction;

@end
