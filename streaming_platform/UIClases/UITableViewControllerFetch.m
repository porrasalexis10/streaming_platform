//
//  UITableViewControllerFetch.m
//  pylc
//
//   Created by Alexis Porras on 18/5/18.
//  Copyright © 2018 Ixaya. All rights reserved.
//

#import "UITableViewControllerFetch.h"

@interface UITableViewControllerFetch ()

@end

@implementation UITableViewControllerFetch

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sections = 0;
    if (self.fetchedResults)
        sections = [[self.fetchedResults sections] count];
    else if ([self.fetchedResultsArray count] > 0)
        sections = 1;
    
    if (sections == 0)
        return 0;
    
    if (self.extraRows > 0)
        return sections + 1;
    
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.extraRows > 0){
        if (section == 0)
            return self.extraRows;
        
        if (self.fetchedResults)
            return [self.fetchedResults.sections[section - 1] numberOfObjects];
    }
    
    if (self.fetchedResults)
        return [self.fetchedResults.sections[section] numberOfObjects];
    else if (self.fetchedResultsArray)
        return [self.fetchedResultsArray count];
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self configureCell:nil atIndexPath:indexPath];
}

- (UITableViewCell *)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    //To be implemented
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //To be implemented
}


#pragma mark - Fetched results delegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    if (self.extraRows > 0)
        sectionIndex ++;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    if (self.extraRows > 0){
        indexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section + 1];
        newIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row inSection:newIndexPath.section + 1];
    }
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (self.tableView)
        [self.tableView endUpdates];
}

- (NSIndexPath*)getTrueIndexPath:(NSIndexPath*)indexPath
{
    if (self.extraRows == 0)
        return indexPath;
    
    return [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 1];
}

@end
