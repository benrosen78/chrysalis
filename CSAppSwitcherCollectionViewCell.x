#import "CSAppSwitcherCollectionViewCell.h"
#import <UIKit/UIImage+Private.h>

@implementation CSAppSwitcherCollectionViewCell {
	NSString *_appIdentifier;
	UIImageView *_appIconImageView;
	UIView *_backgroundColorView;
}

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		_backgroundColorView = [[UIView alloc] init];
		_backgroundColorView.frame = CGRectMake(0, 0, 62.0, 62.0);
		_backgroundColorView.center = self.contentView.center;
		_backgroundColorView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
		_backgroundColorView.layer.masksToBounds = YES;
		_backgroundColorView.layer.cornerRadius = 18.0;
		//_backgroundColorView.alpha = 0.0;
		[self.contentView addSubview:_backgroundColorView];

		_appIconImageView = [[UIImageView alloc] init];
		_appIconImageView.frame = CGRectMake(0, 0, 55.0, 55.0);
		_appIconImageView.center = self.contentView.center;
		[self.contentView addSubview:_appIconImageView];
	}
	return self;
}

- (void)setAppIdentifier:(NSString *)appIdentifier {
	_appIdentifier = appIdentifier;
	_appIconImageView.image = [UIImage _applicationIconImageForBundleIdentifier:_appIdentifier format:MIIconVariantDefault scale:[[UIScreen mainScreen] scale]];
}

- (NSString *)appIdentifier {
	return _appIdentifier;
}

@end
