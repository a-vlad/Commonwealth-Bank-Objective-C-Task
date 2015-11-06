//
//  CBAtmMapViewController.h
//  CBTask
//
//  Created by Vlad Paraschiv on 15/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CBAtm.h"

@interface CBAtmMapViewController : UIViewController

/**
 *  Prepares ATM Map view with transaction and list of possible atm locations for rendering
 */
- (void)populateWithAtm:(CBAtm*)atm;

@end
