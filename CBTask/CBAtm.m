//
//  CBAtm.m
//  CBTask
//
//  Created by Vlad Paraschiv on 14/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "CBAtm.h"

static const NSString *kIdKey           = @"id";
static const NSString *kNameKey         = @"name";
static const NSString *kAddressKey      = @"address";
static const NSString *kLocationKey     = @"location";
static const NSString *kLocationLatKey  = @"lat";
static const NSString *kLocationLongKey = @"lng";

@implementation CBAtm

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        self.atmId                  = dictionary[kIdKey];
        self.name                   = dictionary[kNameKey];
        self.address                = dictionary[kAddressKey];
        
        NSDictionary *locationDictionary = dictionary[kLocationKey];
        NSNumber *latNum = locationDictionary[kLocationLatKey];
        NSNumber *longNum = locationDictionary[kLocationLongKey];
        self.geoLocation = CLLocationCoordinate2DMake(latNum.doubleValue, longNum.doubleValue);
    }
    
    return self;
}

@end
