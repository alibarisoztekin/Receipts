//
//  MasterViewController.m
//  Receipts++
//
//  Created by Ali Barış Öztekin on 2017-03-02.
//  Copyright © 2017 Ali Barış Öztekin. All rights reserved.
//

#import "MasterViewController.h"
#import "AddReceiptViewController.h"
#import "CoreDataManager.h"
#import "ReceiptTableViewCell.h"

@interface MasterViewController () <UITableViewDataSource,UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) CoreDataManager* dataManager;
@property (nonatomic) NSArray<Tag*>* tagsArray;
@property (nonatomic) NSDictionary<NSString*,NSArray<Receipt*>*>* dataSource;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataManager = [CoreDataManager deafultManager];
    [self.dataManager updateDatabaseWithCompletionHandler:^(NSArray<Tag *> *tagArray, NSDictionary<NSString *,NSArray<Receipt *> *> *dataSource) {
        self.tagsArray = tagArray;
        self.dataSource = dataSource;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
    }];
    
  
}

- (IBAction)tappedAddReceipt:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"addReceipt" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    AddReceiptViewController* addRVC = segue.destinationViewController;
    addRVC.tagsArray = [[CoreDataManager deafultManager] returnTagsArray];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tagsArray.count ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString* key = self.tagsArray[section].tagName;
    return   [self.dataSource objectForKey:key].count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReceiptTableViewCell* cell= [tableView dequeueReusableCellWithIdentifier:@"receiptCell" forIndexPath:indexPath];
    NSString* key = self.tagsArray[indexPath.section].tagName;
    [cell configureCellWithReceipt:[self.dataSource objectForKey:key][indexPath.row]];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.tagsArray[section].tagName;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.dataManager updateDatabaseWithCompletionHandler:^(NSArray<Tag *> *tagArray, NSDictionary<NSString *,NSArray<Receipt *> *> *dataSource) {
        self.tagsArray = tagArray;
        self.dataSource = dataSource;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
    }];}

@end
