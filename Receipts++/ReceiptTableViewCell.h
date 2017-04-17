//
//  ReceiptTableViewCell.h
//  Receipts++
//
//  Created by Ali Barış Öztekin on 2017-03-03.
//  Copyright © 2017 Ali Barış Öztekin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Receipt;

@interface ReceiptTableViewCell : UITableViewCell

- (void)configureCellWithReceipt:(Receipt*) receipt;

@end
