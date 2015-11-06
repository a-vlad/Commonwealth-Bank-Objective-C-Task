//
//  CBAccountTileView.h
//  CBTask
//
//  Created by Vlad Paraschiv on 15/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBAccount.h"

@interface CBAccountTileView : UIView

- (void)populateWithAccount:(CBAccount*)account;

@end
