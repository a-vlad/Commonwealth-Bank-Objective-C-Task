//
//  CBTransactionCell.m
//  CBTask
//
//  Created by Vlad Paraschiv on 14/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "CBTransactionCell.h"
#import "CBPendingTransaction.h"
#import "NSNumber+Helpers.h"

const NSString *kTransactionCellReusableIdentifier  = @"CBTransactionCell";

#define kCellHeight 30

@interface CBTransactionCell ()

@property (weak, nonatomic) IBOutlet UILabel            *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel            *amountLabel;
@property (weak, nonatomic) IBOutlet UIImageView        *iconImageView;

// constraint outlets
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *amountWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descriptionLeftMarginToCellConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descriptionLeftMarginToImageConstraint;

@end


@implementation CBTransactionCell


//================================
#pragma mark - Public Methods
//================================

- (void)populateWithTransaction:(CBTransaction*)transaction
{
    BOOL isPending = [transaction isKindOfClass:[CBPendingTransaction class]];
    
    // append "Pending:" if pending transaction
    NSAttributedString *descriptionString = [self pendingStringWithDescription:transaction.transactionDescription pending:isPending];
    
    self.descriptionLabel.attributedText    = descriptionString;
    self.amountLabel.text                   = [transaction.amount formattedAmount];
    self.amountWidthConstraint.constant     = [transaction.amount formattedAmount].length * 10;    // scale $ field to fit
    
    if ([transaction isAtmTransaction] == NO) {
        [self hideIconImage];
    } else {
        [self showIconImage];
        [self.iconImageView setImage:[UIImage imageNamed:@"findUsIcon"]];
    }
}


//================================
#pragma mark - Private Methods
//================================

- (void)hideIconImage
{
    self.iconImageView.hidden = YES;
    self.descriptionLeftMarginToCellConstraint.priority     = 999;//UILayoutPriorityRequired;
    self.descriptionLeftMarginToImageConstraint.priority    = 750;//UILayoutPriorityDefaultLow;
}

- (void)showIconImage
{
    self.iconImageView.hidden = NO;
    self.descriptionLeftMarginToCellConstraint.priority     = 750;//UILayoutPriorityDefaultLow;
    self.descriptionLeftMarginToImageConstraint.priority    = 999;//UILayoutPriorityRequired;
}

/**
 *  Returns attributed string with bold Pending: preappended
 */
- (NSAttributedString*)pendingStringWithDescription:(NSString*)description pending:(BOOL)pending
{
    NSMutableString *appendedString = [description mutableCopy];
    
    // replace <br/> with new line
    appendedString = [[appendedString stringByReplacingOccurrencesOfString: @"<br/>" withString: @"\n"] mutableCopy];
    
    if (pending)
        [appendedString insertString:@"PENDING: " atIndex:0];
    
    // build the attributes dictionaries
    const CGFloat fontSize  = 14;
    NSDictionary *attrs     = @{ NSFontAttributeName:[UIFont systemFontOfSize:fontSize] };
    NSDictionary *boldAttrs = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:fontSize],
                                 NSForegroundColorAttributeName:[UIColor blackColor] };
    
    // build the attributed string
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:appendedString attributes:attrs];
    
    // make "Pending:" bold
    if (pending)
        [attributedText setAttributes:boldAttrs range:NSMakeRange(0,8)];
    
    return attributedText;
}

@end
