//
//  NSDate+Helpers.h
//  CBTask
//
//  Created by Vlad Paraschiv on 15/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helpers)

/*
 *  Returns NSDate from NSString date format: "dd/MM/yyyy"
 */
+ (NSDate*)dateFromString:(NSString*)string;

@end
