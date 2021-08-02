//
//  UICollectionViewControllerFetch.m
//  ggr
//
//   Created by Alexis Porras on 20/06/2018.
//  Copyright © 2018 Ixaya. All rights reserved.
//

#import "UICollectionViewControllerFetch.h"

@interface UICollectionViewControllerFetch ()
{
    NSMutableArray *sectionChanges;
    NSMutableArray *itemChanges;
}
@end

@implementation UICollectionViewControllerFetch

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSInteger sections = 0;
    if (self.fetchedResults)
        sections = [[self.fetchedResults sections] count];
    else if ([self.fetchedResultsArray count] > 0)
        sections = 1;
    
    return sections;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.fetchedResults)
        return [self.fetchedResults.sections[section] numberOfObjects] + self.extraRows;
    else if (self.fetchedResultsArray)
        return [self.fetchedResultsArray count] + self.extraRows;
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self configureCell:nil atIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //To be implemented
}


- (UICollectionViewCell *)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    //To be implemented
    return nil;
}

#pragma mark - Fetched results delegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    sectionChanges = [[NSMutableArray alloc] init];
    itemChanges = [[NSMutableArray alloc] init];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    NSMutableDictionary *change = [[NSMutableDictionary alloc] init];
    change[@(type)] = @(sectionIndex);
    [sectionChanges addObject:change];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    if (self.extraRows > 0){
        indexPath = [NSIndexPath indexPathForRow:(indexPath.row + self.extraRows) inSection:indexPath.section];
        newIndexPath = [NSIndexPath indexPathForRow:(newIndexPath.row + self.extraRows) inSection:newIndexPath.section];
    }
    
    NSMutableDictionary *change = [[NSMutableDictionary alloc] init];
    switch(type) {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = newIndexPath;
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeUpdate:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeMove:
            change[@(type)] = @[indexPath, newIndexPath];
            break;
    }
    [itemChanges addObject:change];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.collectionView performBatchUpdates:^{
        for (NSDictionary *change in self->sectionChanges) {
            [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                switch(type) {
                    case NSFetchedResultsChangeInsert:
                        [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                        break;
                    case NSFetchedResultsChangeDelete:
                        [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                        break;
                    default:
                        break;
                }
            }];
        }
        for (NSDictionary *change in self->itemChanges) {
            [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                switch(type) {
                    case NSFetchedResultsChangeInsert:
                        [self.collectionView insertItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeDelete:
                        [self.collectionView deleteItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeUpdate:
                        [self.collectionView reloadItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeMove:
                        [self.collectionView moveItemAtIndexPath:obj[0] toIndexPath:obj[1]];
                        break;
                }
            }];
        }
    } completion:^(BOOL finished) {
        self->sectionChanges = nil;
        self->itemChanges = nil;
    }];
}

- (NSIndexPath*)getTrueIndexPath:(NSIndexPath*)indexPath
{
    if (self.extraRows == 0)
        return indexPath;
    
    //return [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 1];
    return [NSIndexPath indexPathForRow:(indexPath.row - self.extraRows) inSection:indexPath.section];
}
- (BOOL)indexIsExtraRow:(NSIndexPath*)indexPath
{
    if (indexPath.row < self.extraRows)
        return true;
    
    return false;
}

@end
