//
//  CBCustomerManager.m
//  CBTask
//
//  Created by Vlad Paraschiv on 14/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "CBCustomerManager.h"

@implementation CBCustomerManager

+ (instancetype)sharedManager
{
    static CBCustomerManager *singletonManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonManager = [[self alloc] init];
    });
    return singletonManager;
}

- (instancetype)init
{
    if (self = [super init])
    {
        // initialize model with bundle json
        NSError *error;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"exercise" ofType:@"json"];
        NSURL *localFileURL = [NSURL fileURLWithPath:filePath];
        NSData *contentOfLocalFile = [NSData dataWithContentsOfURL:localFileURL];
        NSDictionary *customerDictionary = [NSJSONSerialization JSONObjectWithData:contentOfLocalFile
                                                                          options: NSJSONReadingMutableContainers
                                                                            error:&error];
        if (error == nil){
            self.customer = [[CBCustomer alloc] initWithDictionary:customerDictionary];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }
    
    return self;
}

@end
