//
//  CBCustomer+BusinessLogic.m
//  CBTask
//
//  Created by Vlad Paraschiv on 15/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "CBCustomer+BusinessLogic.h"

@implementation CBCustomer (BusinessLogic)

- (CBAtm*)findAtmForTransaction:(CBTransaction*)transaction
{
    for (CBAtm *atm in self.atms)
    {
        NSRange range = [transaction.transactionDescription rangeOfString:atm.name
                                                                  options:NSCaseInsensitiveSearch];
        
        if (range.location != NSNotFound)
        {
            // found atm
            return atm;
        }
    }
    
    return nil;
}

@end
