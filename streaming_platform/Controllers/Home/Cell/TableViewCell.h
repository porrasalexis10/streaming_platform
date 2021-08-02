//
//  TableViewCell.h
//  streaming_platform
//
//  Created by Alexis Porras on 01/08/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString *cellIdentifier = @"chapterCell";
@interface TableViewCell : UITableViewCell
@property (readwrite, nonatomic) id parentController;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *runtimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;
@property (strong, nonatomic) IBOutlet UIImageView *posterImage;
@property (strong, nonatomic) IBOutlet UIButton *playButton;

@end

NS_ASSUME_NONNULL_END
