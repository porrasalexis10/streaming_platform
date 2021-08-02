//
//  FavoritesViewController.h
//  streaming_platform
//
//  Created by Alexis Porras on 01/08/21.
//

#import <UIKit/UIKit.h>
#import "UICollectionViewControllerFetch.h"


NS_ASSUME_NONNULL_BEGIN

@interface FavoritesViewController : UICollectionViewControllerFetch
@property (strong, nonatomic) IBOutlet UIButton *allButton;
@property (strong, nonatomic) IBOutlet UIButton *serieButton;
@property (strong, nonatomic) IBOutlet UIButton *movieButton;

@property (strong, nonatomic) IBOutlet UIView *emptyView;
@end

NS_ASSUME_NONNULL_END
