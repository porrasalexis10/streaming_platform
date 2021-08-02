//
//  APCDDataAccess.h
//  IXCommons
//
//   Created by Alexis Porras on 1/24/13.
//  Copyright (c) 2013 Ixaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface APCDDataAccess : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (APCDDataAccess *)sharedInstance;
- (BOOL)saveContext;
- (void)deleteObject:(NSManagedObject*)object;

- (NSURL *)applicationDocumentsDirectory;
- (NSManagedObject*)newObjectInto:(NSString*)entityName;
- (void)cleanUpEntity:(NSString*)entityName;
- (bool)cleanFilter:(NSString*)entityName;
- (NSUInteger)countResults:(NSString*)entityName with:(NSPredicate*)predicate;
- (NSFetchedResultsController*)fetchedResults:(NSString*)_fetchEntityName withPredicate:(NSPredicate*)_fetchPredicate sortedBy:(NSString*)_fetchSortColumn;
- (NSFetchedResultsController*)fetchedResults:(NSString*)_fetchEntityName withPredicate:(NSPredicate*)_fetchPredicate sortedBy:(NSString*)_fetchSortColumn ascending:(BOOL)_fetchAscending limit:(NSUInteger)_fetchLimit;
- (NSFetchedResultsController*)fetchedResults:(NSString*)_fetchEntityName withPredicate:(NSPredicate*)_fetchPredicate sortedBy:(NSString*)_fetchSortColumn ascending:(BOOL)_fetchAscending limit:(NSUInteger)_fetchLimit sectionKeyName:(NSString*)_fetchSectionKey;
- (NSArray*)fetchResults:(NSString*)entityName with:(NSPredicate*)predicate sortedBy:(NSString*)sortingColumn;
- (NSArray*)fetchResults:(NSString*)entityName with:(NSPredicate*)predicate sortedBy:(NSString*)sortingColumn ascending:(BOOL)sortingAscending limit:(NSUInteger)fetchLimit;

- (NSString *)persistentStoreVersion;


- (bool)processFromServer:(NSDictionary*)serverRow forEntity:(NSString*)entityName ignoreEnabled:(BOOL)ignoreEnabled;
-(void)uploadToServerEntities:(NSString *)entityName;


@end
