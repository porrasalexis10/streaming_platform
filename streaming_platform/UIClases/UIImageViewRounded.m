//
//  UIImageViewRounded.m
//  streaming_platform
//
//  Created by Alexis Porras on 25/02/21.
//

#import "UIImageViewRounded.h"

@implementation UIImageViewRounded

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = 12.0f;
}
@end
