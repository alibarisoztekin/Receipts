//
//  AddReceiptViewController.h
//  Receipts++
//
//  Created by Ali Barış Öztekin on 2017-03-02.
//  Copyright © 2017 Ali Barış Öztekin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Receipts__+CoreDataModel.h"

@interface AddReceiptViewController : UIViewController

@property (nonatomic) Receipt* receipt;
@property (weak,nonatomic)  NSArray<Tag*>* tagsArray;

@end
