//
//  NSDate+Helpers.m
//  CBTask
//
//  Created by Vlad Paraschiv on 15/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "NSDate+Helpers.h"

@implementation NSDate (Helpers)

+ (NSDate*)dateFromString:(NSString*)string
{
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSDate* date = [formatter dateFromString:string];
    
    return date;
}

@end
