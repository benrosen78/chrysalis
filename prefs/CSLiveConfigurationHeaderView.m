#import "CSLiveConfigurationHeaderView.h"

@implementation CSLiveConfigurationHeaderView
- (id)init {
      self = [super initWithFrame:CGRectZero];

      if (self) {
            self.blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:self.blurEffect];
            self.blurEffectView.frame = CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, 95.f);

            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.blurEffectView.bounds byRoundingCorners:( UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(18.0, 18.0)];

            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.blurEffectView.bounds;
            maskLayer.path  = maskPath.CGPath;

            self.blurEffectView.layer.mask = maskLayer;

            [self addSubview:self.blurEffectView];
      }

      return self;
}

- (void)setHomeScreenIconHidden:(BOOL)hidden {
      HBLogDebug(@"Should Set HomeScreen Icon Hidden? %@", hidden ? @"YES" : @"NO");
}

- (void)setIconLabelsHidden:(BOOL)hidden {
      HBLogDebug(@"Should Set Icon Labels Be Hidden? %@", hidden ? @"YES" : @"NO");
}

- (void)setKillAllButtonHidden:(BOOL)hidden {
      HBLogDebug(@"Should Set Kill All Button Hidden? %@", hidden ? @"YES" : @"NO");
}

@end
