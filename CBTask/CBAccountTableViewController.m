//
//  CBAccountTableViewController.m
//  CBTask
//
//  Created by Vlad Paraschiv on 14/10/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "CBAccountTableViewController.h"
#import "CBCustomerManager.h"
#import "CBTransactionCell.h"
#import "ALView+PureLayout.h"
#import "CBAccountTileView.h"
#import "CBAtmMapViewController.h"
#import "CBCustomer+BusinessLogic.h"

#define kCellHeight         60
#define kHeaderHeight       30
#define kAccountTileHeight  150
#define kHeaderFontSize     14

@interface CBAccountTableViewController ()

@property (strong, nonatomic) IBOutlet CBAccountTileView *tileView;

@property (strong, nonatomic) CBCustomer    *currentCustomer;
@property (strong, nonatomic) NSDictionary  *tableDictionary;
@property (strong, nonatomic) NSArray       *orderedKeys;

@end


@implementation CBAccountTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentCustomer = [CBCustomerManager sharedManager].customer;
    self.tableDictionary = [self dateKeyDictionaryFromTransactionsArray:self.currentCustomer.transactions];
    
    // we need to keep track of keys as NSDictionary does not guarantee order of keys
    self.orderedKeys     = [self orderDateArray:self.tableDictionary.allKeys];
    
    // populate account tile with customer info
    [self.tileView populateWithAccount:self.currentCustomer.account];
    
    // customise tableview
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
}


//====================================
#pragma mark - Table View Delegate
//====================================

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBAtmMapViewController *atmMapView = [self.storyboard instantiateViewControllerWithIdentifier:@"AtmMapViewControllerReuseId"];

    CBAtm *atm = [self.currentCustomer findAtmForTransaction:[self transactionFromIndexPath:indexPath]];
    
    if (atm)
    {
        [atmMapView populateWithAtm:atm];
        [self.navigationController pushViewController:atmMapView animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                        message:@"Cannot find the ATM location."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBTransaction *transaction = [self transactionFromIndexPath:indexPath];
    
    if ([transaction isAtmTransaction])
        return indexPath;
    else
        return nil;
}


//====================================
#pragma mark - Table View data source
//====================================

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // account tile section header view
    if (section == 0)
        return  self.tileView;
    
    // get heading date
    NSDate *key = self.orderedKeys[section-1];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd MMM yyy"];
    NSString *stringDate = [dateFormat stringFromDate:key];
    
    // create view
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, kHeaderHeight)];
    [view setBackgroundColor:[UIColor colorWithRed:255/255.0 green:204/255.0 blue:0/255.0 alpha:1.0]];
    
    // create date label
    UILabel *dateLabel = [UILabel new];
    [dateLabel setFont:[UIFont boldSystemFontOfSize:kHeaderFontSize]];
    [dateLabel setText:stringDate];
    [view addSubview:dateLabel];
    [dateLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:view withOffset:5.0];
    [dateLabel autoSetDimension:ALDimensionHeight toSize:kHeaderHeight];
    [dateLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:view];
    
    // days left label
    UILabel *daysLabel = [UILabel new];
    [daysLabel setFont:[UIFont boldSystemFontOfSize:kHeaderFontSize]];
    daysLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:daysLabel];
    [daysLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:view withOffset:-5.0];
    [daysLabel autoSetDimension:ALDimensionHeight toSize:kHeaderHeight];
    [daysLabel autoSetDimension:ALDimensionWidth toSize:100];
    [daysLabel autoSetDimension:ALDimensionWidth toSize:100];
    [daysLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:view];
    daysLabel.text = [NSString stringWithFormat:@"%@ Days Ago",[self daysAgoFromDate:key]];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return kAccountTileHeight;
    else
        return kHeaderHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableDictionary.allKeys.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // first header is account tile
    if (section == 0)
        return 0;
    
    NSDate *key = self.orderedKeys[section-1];
    NSArray *trxForDate = self.tableDictionary[key];
    
    return trxForDate.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBTransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:kTransactionCellReusableIdentifier forIndexPath:indexPath];
    [cell populateWithTransaction:[self transactionFromIndexPath:indexPath]];
        
    return cell;
}


//====================================
#pragma mark - Private Helpers
//====================================

/**
 *  Return transaction from datasource from indexpath
 */
- (CBTransaction*)transactionFromIndexPath:(NSIndexPath*)indexPath
{
    NSDate *key = self.orderedKeys[indexPath.section-1];
    NSArray *trxForDate = self.tableDictionary[key];
    return trxForDate[indexPath.row];
}

/**
 *  Returns number of days from today since date
 */
- (NSNumber*)daysAgoFromDate:(NSDate*)date
{
    return [NSNumber numberWithInt:[self daysBetweenDate:date andDate:[NSDate new]]];
}

/**
 *  Returns number of days between two dates
 */
- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

/**
 *  Catalogues transactions into Date buckets for displaying in tableview date headings.
 *
 *  @param  array   -   Array of CBTransactions
 *  @return A Dictionary where keys are unique NSDates 
 *          and object is NSArray of CBTransactions made on that date.
 *          Will return nil if nil or empty dictionary.
 */
- (NSDictionary*)dateKeyDictionaryFromTransactionsArray:(NSArray*)array
{
    // return nil for edge cases
    if ((array == nil) || (array.count == 0))
        return nil;
    
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    for (CBTransaction *transaction in array)
    {
        // check if bucket exists
        NSMutableArray *bucket = dictionary[transaction.effectiveDate];
        
        // create bucket if first item in bucket
        if (bucket == nil)
            bucket = [NSMutableArray new];
        
        [bucket addObject:transaction];
        [dictionary setObject:bucket forKey:transaction.effectiveDate];
    }
    
    return dictionary;
}

/**
 *  Returns array of ordered dates.
 *
 *  @param  array   -   Array of NSDate
 *  @return Ordered NSArray of NSDate objects from most recent first going back in time.
 */
- (NSArray*)orderDateArray:(NSArray*)array
{
    NSArray *orderedArray = [array sortedArrayUsingComparator: ^(NSDate *d1, NSDate *d2) {
        return [d2 compare:d1];
    }];
    
    return orderedArray;
}

@end
