//
//  UICollectionViewControllerFetch.h
//  ggr
//
//   Created by Alexis Porras on 20/06/2018.
//  Copyright © 2018 Ixaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewControllerFetch : UIViewController <NSFetchedResultsControllerDelegate>

@property (readwrite, strong) NSFetchedResultsController *fetchedResults;
@property (readwrite, strong) NSArray *fetchedResultsArray;
@property (readwrite, strong) IBOutlet UICollectionView *collectionView;
@property (readwrite, nonatomic) NSInteger extraRows;

- (UICollectionViewCell *)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)getTrueIndexPath:(NSIndexPath*)indexPath;
- (BOOL)indexIsExtraRow:(NSIndexPath*)indexPath;

@end
