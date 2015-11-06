//
//  NSNumber+Helpers.h
//  CBTask
//
//  Created by Vlad Paraschiv on 14/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Helpers)

/**
 *  Converts amount string from xxx.xx to NSNumber
 */
+ (NSNumber*)numberWithAmountString:(NSString*)amountString;

/**
 *  Returns amount string eg: -$30.20 from NSNumber amount
 */
- (NSString*)formattedAmount;

@end
