//
//  CBAtm.h
//  CBTask
//
//  Created by Vlad Paraschiv on 14/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBModel.h"
#import <CoreLocation/CoreLocation.h>

@interface CBAtm : CBModel

@property (strong, nonatomic) NSString                  *atmId;
@property (strong, nonatomic) NSString                  *name;
@property (strong, nonatomic) NSString                  *address;
@property (assign, nonatomic) CLLocationCoordinate2D    geoLocation;

@end
