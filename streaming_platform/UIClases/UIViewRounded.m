//
//  UIViewRounded.m
//  streaming_platform
//
//  Created by Alexis Porras on 25/02/21.
//

#import "UIViewRounded.h"

@implementation UIViewRounded

- (void)layoutSubviews {
    [super layoutSubviews];

    if(self.cornerTop){
        CAShapeLayer * maskLayer = [CAShapeLayer layer];
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){10.0, 10.0}].CGPath;

        self.layer.mask = maskLayer;

    }else if(self.cornerBottom){
        CAShapeLayer * maskLayer = [CAShapeLayer layer];
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0, 10.0}].CGPath;

        self.layer.mask = maskLayer;

    }else if(self.cornerEnabled){
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10.0f;
    }
}

@end
