#include "CSRootListController.h"
#import <UIKit/UIImage+Private.h>

@implementation CSRootListController

+ (NSString *)hb_specifierPlist {
	return @"Root";
}

+ (NSString *)hb_shareText {
	return @"I'm using Chrysalis to beautifully switch between apps. Download today from BigBoss! @benr9500 @cpdigdarkroom @hbkirb @veerklempt";
}

+ (NSString *)hb_shareURL {
	return @"http://tweakbattles.com";
}

+ (UIColor *)hb_tintColor {
	return [UIColor colorWithRed:0.424f green:0.424f blue:0.431f alpha:1.00f];
}

+ (BOOL)hb_invertedNavigationBar {
	return YES;
}

+ (UIColor *)hb_overrideTintColor {
	return [UIColor colorWithRed:0.169f green:0.796f blue:0.518f alpha:1.00f];
}

- (void)viewDidLoad {
	[super viewDidLoad];

	UIImage *headerLogo = [[UIImage imageNamed:@"headerLogo" inBundle:[NSBundle bundleWithPath:@"/Library/PreferenceBundles/ChrysalisPrefs.bundle"]] _flatImageWithColor:[UIColor whiteColor]];
	self.navigationItem.titleView = [[UIImageView alloc] initWithImage:headerLogo];
	self.navigationItem.titleView.alpha = 0.0;

	[self performSelector:@selector(animateIconAlpha) withObject:nil afterDelay:0.3];
}

- (void)animateIconAlpha {
	[UIView animateWithDuration:0.5 animations:^{
		self.navigationItem.titleView.alpha = 1;
	} completion:nil];
}

@end
