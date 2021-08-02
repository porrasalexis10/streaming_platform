//
//  UIButtonRounded.m
//  streaming_platform
//
//  Created by Alexis Porras on 25/02/21.
//

#import "UIButtonRounded.h"

@implementation UIButtonRounded


- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.outlineColor){
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = self.outlineColor.CGColor;
    }
    
    self.layer.cornerRadius = 10.0f;
    self.clipsToBounds = YES;
}

@end
