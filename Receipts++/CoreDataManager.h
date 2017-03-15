//
//  CoreDataManager.h
//  Receipts++
//
//  Created by Ali Barış Öztekin on 2017-03-02.
//  Copyright © 2017 Ali Barış Öztekin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tag;
@class Receipt;


extern NSString* const kReceiptEntityName;
extern NSString* const kTagEntityName;

@interface CoreDataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic) NSManagedObjectContext* context;

+(id) deafultManager;
- (void)saveContext;
-(void)setupTagsArray;
-(NSArray<Tag*>*) returnTagsArray;
-(NSMutableDictionary*)dataSource;
-(void)updateDatabaseWithCompletionHandler:(void (^)(NSArray<Tag*>* tagArray, NSDictionary<NSString*,NSArray<Receipt*>*>* dataSource)) completionHandler;
-(NSArray<Receipt*>*) receiptsArrayFromFetch;
@end
