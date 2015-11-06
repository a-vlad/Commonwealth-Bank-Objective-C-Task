//
//  CBCustomerManager.h
//  CBTask
//
//  Created by Vlad Paraschiv on 14/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBCustomer.h"

/**
 *  Customer Manager Singleton
 *  Initialized from Bundled JSON file. 
 *  Can be extended in future to init from remote endpoint.
 */
@interface CBCustomerManager : NSObject

@property (strong, nonatomic) CBCustomer *customer;

+ (instancetype)sharedManager;

@end
