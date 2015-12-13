#import "TBCSAppSwitcherCollectionViewCell.h"
#import "TBCSDisplayItem.h"
#import "TBCSPreferencesManager.h"
#import <UIKit/UIImage+Private.h>

@implementation TBCSAppSwitcherCollectionViewCell {
	TBCSDisplayItem *_displayItem;
	UIImageView *_appIconImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		_appIconImageView = [[UIImageView alloc] init];
		_appIconImageView.frame = CGRectMake(0, 0, 55.0, 55.0);
		_appIconImageView.center = self.contentView.center;
		_appIconImageView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
		_appIconImageView.layer.shadowOffset = CGSizeMake(0.5, 0.5);
		_appIconImageView.layer.shadowOpacity = 0.5;
		_appIconImageView.layer.shadowRadius = 0.5;
		_appIconImageView.clipsToBounds = NO;

		[self.contentView addSubview:_appIconImageView];
	}
	return self;
}

- (TBCSDisplayItem *)displayItem {
	return _displayItem;
}

- (void)setDisplayItem:(TBCSDisplayItem *)displayItem {
	if ([displayItem.type isEqualToString:@"Homescreen"]) {
		// if it‘s the home screen icon, we have our own icon for that
		BOOL darkMode = [TBCSPreferencesManager sharedInstance].darkMode;
		_appIconImageView.image = [[UIImage imageNamed:darkMode ? @"home-dark" : @"home-light" inBundle:bundle] _applicationIconImageForFormat:MIIconVariantDefault precomposed:YES scale:[[UIScreen mainScreen] scale]];
	} else {
		// get the app’s icon
		_appIconImageView.image = [UIImage _applicationIconImageForBundleIdentifier:displayItem.displayIdentifier format:MIIconVariantDefault scale:[[UIScreen mainScreen] scale]];
	}
}

#pragma mark - Memory management

- (void)dealloc {
	[_appIconImageView release];

	[super dealloc];
}

@end
