//
//  TableViewCell.m
//  streaming_platform
//
//  Created by Alexis Porras on 01/08/21.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)playChapter:(id)sender {
    if ([self.parentController respondsToSelector:@selector(reproduceVideo)]){
        [self.parentController performSelector:@selector(reproduceVideo) withObject:nil];
    }
}
@end
