//
//  ListDetailViewController.h
//  streaming_platform
//
//  Created by Alexis Porras on 01/08/21.
//

#import <UIKit/UIKit.h>
#import "UITableViewControllerFetch.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListDetailViewController : UITableViewControllerFetch
@property (readwrite, weak) Movie *parenData;
@property (readwrite, nonatomic) id parentController;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *extraDataLabel;
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *actorsLabel;
@property (strong, nonatomic) IBOutlet UILabel *createdLabel;
@property (strong, nonatomic) IBOutlet UIImageView *posterImage;
@property (strong, nonatomic) IBOutlet UIButton *favoriteButton;
@property (strong, nonatomic) IBOutlet UIButton *seasonButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightTableConstraint;
@end

NS_ASSUME_NONNULL_END
