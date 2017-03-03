//
//  CoreDataManager.h
//  Receipts++
//
//  Created by Ali Barış Öztekin on 2017-03-02.
//  Copyright © 2017 Ali Barış Öztekin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

extern NSString* const kReceiptEntityName;
extern NSString* const kTagEntityName;


@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic) NSManagedObjectContext* context;

+(id) deafultManager;
- (void)saveContext;
-(void)setupTagsArray;
@end
