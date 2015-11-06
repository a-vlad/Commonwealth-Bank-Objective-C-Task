//
//  CBAccountTileView.m
//  CBTask
//
//  Created by Vlad Paraschiv on 15/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "CBAccountTileView.h"
#import "NSNumber+Helpers.h"

@interface CBAccountTileView()

@property (strong, nonatomic) IBOutlet UILabel *availableFundsLabel;
@property (strong, nonatomic) IBOutlet UILabel *accountBalanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *accountNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *accountNumberLabel;

@end


@implementation CBAccountTileView


//================================
#pragma mark - Public Methods
//================================

- (void)populateWithAccount:(CBAccount*)account
{
    self.availableFundsLabel.text   = [account.availableFunds formattedAmount];
    self.accountBalanceLabel.text   = [account.balance formattedAmount];
    self.accountNameLabel.text      = account.accountName;
    self.accountNumberLabel.text    = account.accountNumber;
}

@end
