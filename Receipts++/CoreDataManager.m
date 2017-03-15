//
//  CoreDataManager.m
//  Receipts++
//
//  Created by Ali Barış Öztekin on 2017-03-02.
//  Copyright © 2017 Ali Barış Öztekin. All rights reserved.
//

#import "CoreDataManager.h"
#import "Receipts__+CoreDataModel.h"

 NSString* const kReceiptEntityName = @"Receipt";
 NSString* const kTagEntityName =  @"Tag";

@interface CoreDataManager ()

@property (nonatomic) NSArray<Tag*>* tagsArray;

@end

@implementation CoreDataManager


@synthesize persistentContainer = _persistentContainer;


+ (id)deafultManager {
    static CoreDataManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        NSManagedObjectContext *context = sharedManager.persistentContainer.viewContext;
        sharedManager.context = context;
    });
    return sharedManager;
}

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Receipts__"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                  
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

#pragma mark -  Data Source Management-

-(void)setupTagsArray{
    
    NSArray<Tag*>* tagArray;
    NSFetchRequest* tagFetchRequest = [[NSFetchRequest alloc] init];
    tagFetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"tagName" ascending:YES]];
    NSEntityDescription *entity = [NSEntityDescription entityForName:kTagEntityName inManagedObjectContext:self.context];
    [tagFetchRequest setEntity:entity];
    
    
    NSError *fetchError;
    tagArray = [NSArray arrayWithArray:[self.context executeFetchRequest:tagFetchRequest error:&fetchError]];
    
    if(!tagArray || tagArray.count==0 ){
        
        Tag* personal = [NSEntityDescription insertNewObjectForEntityForName:kTagEntityName inManagedObjectContext:self.context];
        Tag* family= [NSEntityDescription insertNewObjectForEntityForName:kTagEntityName inManagedObjectContext:self.context];
        Tag* business = [NSEntityDescription insertNewObjectForEntityForName:kTagEntityName inManagedObjectContext:self.context];
        personal.tagName = @"Personal";
        family.tagName = @"Family";
        business.tagName = @"Business";
        [self saveContext];
        
        tagArray = [NSArray arrayWithArray:[self.context executeFetchRequest:tagFetchRequest error:&fetchError]];
        
    }
        self.tagsArray = [NSArray arrayWithArray:tagArray];
        
}

-(NSArray<Tag*>*) returnTagsArray{
    
    if(!self.tagsArray )
        [self setupTagsArray];
    return self.tagsArray;
}

-(NSArray<Receipt*>*) receiptsArrayFromFetch{
    NSArray<Receipt*>* receiptsArray;
    NSFetchRequest* receiptFetchRequest = [NSFetchRequest fetchRequestWithEntityName:kReceiptEntityName];
    receiptFetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"timeStamp" ascending:YES]];
    NSError* fetchError;
    receiptsArray =  [self.context executeFetchRequest:receiptFetchRequest error:&fetchError];
    if(!receiptsArray || receiptsArray.count ==0)
        NSLog(@"Fetch error");
    return receiptsArray;
    
}
-(NSMutableDictionary*)dataSource{
    
    NSMutableDictionary* tempDictionary =[NSMutableDictionary new];
    
    
    
    for(Tag* tag in self.tagsArray){
        NSMutableArray* receiptArray = [[tag.receipts allObjects] mutableCopy];
        NSSortDescriptor* sortByDate =  [NSSortDescriptor sortDescriptorWithKey:@"timeStamp" ascending:YES];
        [receiptArray sortedArrayUsingDescriptors:@[sortByDate]];
        
        [tempDictionary setObject:receiptArray forKey:tag.tagName];
    };
    return tempDictionary;
}

-(void)updateDatabaseWithCompletionHandler:(void (^)(NSArray<Tag*>* tagArray, NSDictionary<NSString*,NSArray<Receipt*>*>* dataSource)) completionHandler{
    NSArray* array= [self returnTagsArray];
    NSDictionary* dictionary = [self dataSource];
    
    completionHandler(array,dictionary);
}

@end
