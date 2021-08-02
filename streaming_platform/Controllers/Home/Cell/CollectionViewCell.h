//
//  CollectionViewCell.h
//  streaming_platform
//
//  Created by Alexis Porras on 01/08/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString *cellIdentifier = @"movieCell";
@interface CollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *posterImage;

@property (readwrite, nonatomic) id parentController;
@property (strong, nonatomic) NSIndexPath *indexPath;
@end

NS_ASSUME_NONNULL_END
