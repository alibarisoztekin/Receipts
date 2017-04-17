//
//  AddReceiptViewController.m
//  Receipts++
//
//  Created by Ali Barış Öztekin on 2017-03-02.
//  Copyright © 2017 Ali Barış Öztekin. All rights reserved.
//

#import "AddReceiptViewController.h"
#import "CoreDataManager.h"

@interface AddReceiptViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tagTableView;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *desctriptionTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic,strong) NSMutableSet* selectedTags;


@end

@implementation AddReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectedTags = [NSMutableSet new];
    
}


- (IBAction)dateChanged:(UIDatePicker *)sender {
}



- (IBAction)saveTapped:(UIButton *)sender {
    Receipt* receipt = [NSEntityDescription insertNewObjectForEntityForName:kReceiptEntityName inManagedObjectContext:[[CoreDataManager deafultManager] context]];
    receipt.amount = [self.amountTextField.text doubleValue];
    receipt.receiptDescription = self.desctriptionTextField.text;
    receipt.timeStamp = [self.datePicker date];
    [receipt addTags:self.selectedTags];
    [self dismissViewControllerAnimated:YES completion:^{
        [[CoreDataManager deafultManager] saveContext];
    }];
}
- (IBAction)cancelTapped:(UIButton *)sender {
    NSArray<Receipt*>* receiptArray = [[CoreDataManager deafultManager] receiptsArrayFromFetch];
    NSLog(@"%@",receiptArray[0].tags);

    [self dismissViewControllerAnimated:YES completion:nil];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tagsArray.count;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.selectedTags addObject:self.tagsArray[indexPath.row]];
    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.selectedTags removeObject:self.tagsArray[indexPath.row]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"Categories";
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"tagCell"];
    cell.textLabel.text = self.tagsArray[indexPath.row].tagName;
    
    return cell;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
@end
