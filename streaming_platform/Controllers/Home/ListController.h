//
//  ViewController.h
//  streaming_platform
//
//  Created by Alexis Porras on 25/02/21.
//

#import <UIKit/UIKit.h>
#import "UICollectionViewControllerFetch.h"

@interface ListController : UICollectionViewControllerFetch
@property (strong, nonatomic) IBOutlet UIButton *allButton;
@property (strong, nonatomic) IBOutlet UIButton *serieButton;
@property (strong, nonatomic) IBOutlet UIButton *movieButton;

@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@end

