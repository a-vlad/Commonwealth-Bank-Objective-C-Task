//
//  NSNumber+Helpers.m
//  CBTask
//
//  Created by Vlad Paraschiv on 14/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "NSNumber+Helpers.h"

@implementation NSNumber (Helpers)

+ (NSNumber*)numberWithAmountString:(NSString*)amountString
{
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *number = [formatter numberFromString:amountString];
    
    return number;
}

- (NSString*)formattedAmount
{
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *amountString = [numberFormatter stringFromNumber:self];
    
    return amountString;
}

@end
