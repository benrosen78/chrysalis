#import "CSAdvancedBackgroundGradientView.h"

@implementation CSAdvancedBackgroundGradientView

+ (Class)layerClass {
	return CAGradientLayer.class;
}

- (instancetype)init {
	if (self = [super init]) {
		((CAGradientLayer *)self.layer).locations = @[@0, @0.5f, @0.75f, @1];
		((CAGradientLayer *)self.layer).colors = @[
			(id)[UIColor colorWithRed:0.498 green:0.498 blue:0.506 alpha:1.00].CGColor,
			(id)[UIColor colorWithRed:0.651 green:0.651 blue:0.663 alpha:1.00].CGColor,
			(id)[UIColor colorWithRed:0.776 green:0.776 blue:0.792 alpha:1.00].CGColor,
			(id)[UIColor colorWithRed:0.875 green:0.875 blue:0.894 alpha:1.00].CGColor
		];
	}
	return self;
}

@end
