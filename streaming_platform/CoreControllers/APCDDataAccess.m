//
//  APCDDataAccess.m
//  IXCommons
//
//   Created by Alexis Porras on 1/24/13.
//  Copyright (c) 2013 Ixaya. All rights reserved.
//

#import "APCDDataAccess.h"
//#import "CDEntities.h"

@implementation APCDDataAccess

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


static APCDDataAccess *_dataAccess;
+ (APCDDataAccess *)sharedInstance {
    if (_dataAccess == nil)
    {
        _dataAccess = [[APCDDataAccess alloc] init];
    }
    
    return _dataAccess;
}

- (BOOL)saveContext
{
    if (self.managedObjectContext != nil && [_managedObjectContext hasChanges])
    {
        NSError *error = nil;
        if (![_managedObjectContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            return NO;
        }
        return YES;
    }
    return YES;
}
- (void)deleteObject:(NSManagedObject *)object
{
    if (self.managedObjectContext)
        [_managedObjectContext deleteObject:object];
}

- (NSManagedObject*)newObjectInto:(NSString*)entityName
{
    if (self.managedObjectContext)
        return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:_managedObjectContext];
    else
        return nil;
}

- (void)cleanUpEntity:(NSString*)entityName
{
    if (self.managedObjectContext)
    {
        NSFetchRequest * allRows = [[NSFetchRequest alloc] init];
        [allRows setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:_managedObjectContext]];
        [allRows setIncludesPropertyValues:NO]; //only fetch the managedObjectID
        
        NSError * error = nil;
        NSArray * rows = [_managedObjectContext executeFetchRequest:allRows error:&error];
        if (error == nil)
        {
            for (NSManagedObject * row in rows)
                [_managedObjectContext deleteObject:row];
        }
        else
        {
            NSLog(@"Error fetching: %@", error);
        }
        
        [self saveContext];
    }
}
- (bool)processFromServer:(NSDictionary*)serverRow forEntity:(NSString*)entityName ignoreEnabled:(BOOL)ignoreEnabled
{
    if (!serverRow || ![serverRow isKindOfClass:[NSDictionary class]])
        return NO;

    NSInteger enabled = 1;
    NSManagedObject *localRow;
    
    NSString *db_id = serverRow[@"imdbID"];
    NSArray *result = [self fetchResults:entityName with:[NSPredicate predicateWithFormat:@"db_id = %@", db_id] sortedBy:nil];
    
    if (result.count == 1) {
        localRow = [result lastObject];
        if (enabled != 1){
            if ([localRow respondsToSelector:@selector(deleteLocalFile)])
                [localRow performSelector:@selector(deleteLocalFile)];
            [self deleteObject:localRow];
            return NO;
        }
    } else if (enabled == 1) {
        localRow = [self newObjectInto:entityName];
    } else {
        return NO;
    }
    
    if ([localRow respondsToSelector:@selector(processRow:)])
        [localRow performSelector:@selector(processRow:) withObject:serverRow];
    
    return YES;
}

- (bool)cleanFilter:(NSString*)entityName
{
    NSArray *result = [self fetchResults:entityName with:[NSPredicate predicateWithFormat:@"sync_status = %@", @1] sortedBy:nil];
    
    for(NSManagedObject *row in result)
        [self deleteObject:row];
    
    return YES;
}

-(void)uploadToServerEntities:(NSString *)entityName
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sync_status = %@", @0];
    NSArray *pendingRows = [[APCDDataAccess sharedInstance] fetchResults:entityName with:predicate sortedBy:@"db_id"];
    NSLog(@"%@: %lu", entityName, (unsigned long)pendingRows.count);
    for (NSManagedObject *localRow in pendingRows){
        if ([localRow respondsToSelector:@selector(uploadRow)])
            [localRow performSelector:@selector(uploadRow)];
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        [_managedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
    }
    return _managedObjectContext;
}


// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:[APKernel getAppName] withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"pylc.sqlite"];
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @true,
                              NSInferMappingModelAutomaticallyOption: @true};
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:options
                                                           error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return _persistentStoreCoordinator;
}
- (NSString *)persistentStoreVersion
{
    NSDictionary *sourceMetadata = [_persistentStoreCoordinator metadataForPersistentStore:[_persistentStoreCoordinator.persistentStores lastObject]];
    
    return [sourceMetadata[NSStoreModelVersionIdentifiersKey] lastObject];
}

- (NSUInteger)countResults:(NSString*)entityName with:(NSPredicate*)predicate
{
    
    if (_managedObjectContext != nil) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:_managedObjectContext]];
        [request setIncludesSubentities:NO]; //Omit subentities. Default is YES (i.e. include subentities)
        [request setPredicate:predicate];

        NSError *err;
        NSUInteger count = [_managedObjectContext countForFetchRequest:request error:&err];
        if(count == NSNotFound)
            return 0;
        
        return count;
    }
    
    return 0;
}

- (NSFetchedResultsController*)fetchedResults:(NSString*)_fetchEntityName withPredicate:(NSPredicate*)_fetchPredicate sortedBy:(NSString*)_fetchSortColumn
{
    return [self fetchedResults:_fetchEntityName withPredicate:_fetchPredicate sortedBy:_fetchSortColumn ascending:YES limit:0];
}
- (NSFetchedResultsController*)fetchedResults:(NSString*)_fetchEntityName withPredicate:(NSPredicate*)_fetchPredicate sortedBy:(NSString*)_fetchSortColumn ascending:(BOOL)_fetchAscending limit:(NSUInteger)_fetchLimit
{
    return [self fetchedResults:_fetchEntityName withPredicate:_fetchPredicate sortedBy:_fetchSortColumn ascending:_fetchAscending limit:_fetchLimit sectionKeyName:nil];
}
- (NSFetchedResultsController*)fetchedResults:(NSString*)_fetchEntityName withPredicate:(NSPredicate*)_fetchPredicate sortedBy:(NSString*)_fetchSortColumn ascending:(BOOL)_fetchAscending limit:(NSUInteger)_fetchLimit sectionKeyName:(NSString*)_fetchSectionKey
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	
	//nuevo gumoz
	[NSFetchedResultsController deleteCacheWithName:_fetchEntityName];
	
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:_fetchEntityName inManagedObjectContext:[self managedObjectContext]];
    
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    //    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    if (_fetchSortColumn)
    {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:_fetchSortColumn ascending:_fetchAscending];
        [fetchRequest setSortDescriptors:@[sortDescriptor]];
    }
    
    if (_fetchPredicate)
        [fetchRequest setPredicate:_fetchPredicate];
    
    if (_fetchLimit > 0)
        [fetchRequest setFetchLimit:_fetchLimit];
    
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:_fetchSectionKey cacheName:_fetchEntityName];
    
	NSError *error = nil;
	if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //	    abort();
	}
    
    return aFetchedResultsController;
}
- (NSArray*)fetchResults:(NSString*)entityName with:(NSPredicate*)predicate sortedBy:(NSString*)sortingColumn
{
    return [self fetchResults:entityName with:predicate sortedBy:sortingColumn ascending:YES limit:0];
}
- (NSArray*)fetchResults:(NSString*)entityName with:(NSPredicate*)predicate sortedBy:(NSString*)sortingColumn ascending:(BOOL)sortingAscending limit:(NSUInteger)fetchLimit
{
    if (self.managedObjectContext)
    {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:_managedObjectContext];
        [fetchRequest setEntity:entity];
        
        if (predicate)
            [fetchRequest setPredicate:predicate];
        
        if (sortingColumn != nil)
        {
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortingColumn ascending:sortingAscending];
            [fetchRequest setSortDescriptors:@[sortDescriptor]];
        }
        
        if (fetchLimit > 0)
            [fetchRequest setFetchLimit:fetchLimit];
        
        NSError *error;
        NSArray *items = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
        if (error == nil) {
            return items;
        } else {
            NSLog(@"Error fetching: %@", error);
            return nil;
        }
    }
    return nil;
}


#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
