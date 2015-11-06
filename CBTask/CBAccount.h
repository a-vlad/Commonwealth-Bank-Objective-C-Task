//
//  CBAccount.h
//  CBTask
//
//  Created by Vlad Paraschiv on 14/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBModel.h"

@interface CBAccount : CBModel

@property (strong, nonatomic) NSString *accountName;
@property (strong, nonatomic) NSString *accountNumber;
@property (strong, nonatomic) NSNumber *availableFunds;
@property (strong, nonatomic) NSNumber *balance;

@end
