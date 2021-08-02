//
//  UITableViewControllerFetch.h
//  pylc
//
//   Created by Alexis Porras on 18/5/18.
//  Copyright © 2018 Ixaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewControllerFetch : UIViewController <NSFetchedResultsControllerDelegate>

@property (readwrite, strong) NSFetchedResultsController *fetchedResults;
@property (readwrite, strong) NSArray *fetchedResultsArray;
@property (readwrite, strong) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic) NSInteger extraRows;

- (UITableViewCell *)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath*)getTrueIndexPath:(NSIndexPath*)indexPath;

@end
