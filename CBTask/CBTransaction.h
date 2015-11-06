//
//  CBTransaction.h
//  CBTask
//
//  Created by Vlad Paraschiv on 14/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBModel.h"

@interface CBTransaction : CBModel

@property (strong, nonatomic) NSString  *transactionId;
@property (strong, nonatomic) NSDate    *effectiveDate;
@property (strong, nonatomic) NSString  *transactionDescription;
@property (strong, nonatomic) NSNumber  *amount;

- (BOOL)isAtmTransaction;

@end
