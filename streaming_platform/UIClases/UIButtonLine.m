//
//  UIButtonRounded.m
//  Ixaya
//
//   Created by Alexis Porras on on 19/01/2017.
//   .
//

#import "UIButtonLine.h"

@implementation UIButtonLine{
    CALayer *_underlineBorder;
}



- (void)layoutSubviews {
    [super layoutSubviews];

    if (_underlineBorder == nil && self.borderlineColor && self.justUnderline)
      {
          _underlineBorder = [CALayer layer];
          CGFloat borderWidth = 1.0;
          _underlineBorder.borderColor = self.borderlineColor.CGColor;
          _underlineBorder.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height);
          _underlineBorder.borderWidth = borderWidth;
          [self.layer addSublayer:_underlineBorder];
          
          self.layer.masksToBounds = YES;
          
          self.backgroundColor = [UIColor clearColor];
      }
}

@end
