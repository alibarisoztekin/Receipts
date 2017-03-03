//
//  AddReceiptViewController.m
//  Receipts++
//
//  Created by Ali Barış Öztekin on 2017-03-02.
//  Copyright © 2017 Ali Barış Öztekin. All rights reserved.
//

#import "AddReceiptViewController.h"
#import "CoreDataManager.h"

@interface AddReceiptViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tagTableView;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *desctriptionTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak,nonatomic)  NSArray<Tag*>* tagsArray;


@end

@implementation AddReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tagsArray = [[CoreDataManager deafultManager] tagsArray];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dateChanged:(UIDatePicker *)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)saveTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    
    }];
}
- (IBAction)cancelTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
