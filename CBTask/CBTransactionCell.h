//
//  CBTransactionCell.h
//  CBTask
//
//  Created by Vlad Paraschiv on 14/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBTransaction.h"

extern NSString *kTransactionCellReusableIdentifier;

@interface CBTransactionCell : UITableViewCell

- (void)populateWithTransaction:(CBTransaction*)transaction;

@end
