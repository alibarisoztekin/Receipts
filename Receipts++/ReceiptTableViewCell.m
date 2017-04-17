//
//  ReceiptTableViewCell.m
//  Receipts++
//
//  Created by Ali Barış Öztekin on 2017-03-03.
//  Copyright © 2017 Ali Barış Öztekin. All rights reserved.
//

#import "ReceiptTableViewCell.h"
#import "Receipts__+CoreDataModel.h"

@interface ReceiptTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;



@end

@implementation ReceiptTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellWithReceipt:(Receipt*) receipt {
    
    self.amountLabel.text = [NSString stringWithFormat:@"$%.2f", receipt.amount];
    self.descriptionLabel.text = receipt.receiptDescription;
    
    NSDateFormatter* dateformatter = [NSDateFormatter new];
    [dateformatter setDateStyle: NSDateFormatterShortStyle];
    [dateformatter setTimeStyle:NSDateFormatterNoStyle];
    self.dateLabel.text = [dateformatter stringFromDate:receipt.timeStamp];

}

@end
