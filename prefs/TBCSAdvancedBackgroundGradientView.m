#import "TBCSAdvancedBackgroundGradientView.h"

@implementation TBCSAdvancedBackgroundGradientView

+ (Class)layerClass {
	return CAGradientLayer.class;
}

- (instancetype)init {
	if (self = [super init]) {
		((CAGradientLayer *)self.layer).colors = @[
			(id)[UIColor colorWithRed:0.498 green:0.498 blue:0.506 alpha:1.00].CGColor,
			(id)[UIColor colorWithRed:0.651 green:0.651 blue:0.663 alpha:1.00].CGColor,
			(id)[UIColor colorWithRed:0.776 green:0.776 blue:0.792 alpha:1.00].CGColor,
			(id)[UIColor colorWithRed:0.875 green:0.875 blue:0.894 alpha:1.00].CGColor
		];

		CAGradientLayer *maskLayer = [CAGradientLayer layer];
		maskLayer.locations = @[ @0.85f, @1 ];
		maskLayer.colors = @[
			(id)[UIColor blackColor].CGColor,
			(id)[UIColor clearColor].CGColor,
		];
		self.layer.mask = maskLayer;
	}

	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];

	self.layer.mask.frame = self.bounds;
}

@end
