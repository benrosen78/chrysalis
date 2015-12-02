#include "TBCSRootListController.h"
#import <UIKit/UIImage+Private.h>

@implementation TBCSRootListController

+ (NSString *)hb_specifierPlist {
	return @"Root";
}

+ (NSString *)hb_shareText {
	return @"I'm using Chrysalis to beautifully switch between apps. Download today from BigBoss! @benr9500 @cpdigdarkroom @hbkirb @veerklempt";
}

+ (NSString *)hb_shareURL {
	return @"http://tweakbattles.com/";
}

+ (UIColor *)hb_tintColor {
	return [UIColor colorWithRed:0.169f green:0.796f blue:0.518f alpha:1.00f];
}

+ (UIColor *)hb_navigationBarTintColor {
	return [UIColor colorWithRed:0.424f green:0.424f blue:0.431f alpha:1.00f];
}

+ (BOOL)hb_invertedNavigationBar {
	return YES;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	UIImage *headerLogo = [[UIImage imageNamed:@"headerLogo" inBundle:[NSBundle bundleForClass:self.class]] _flatImageWithColor:[UIColor whiteColor]];
	self.navigationItem.titleView = [[[UIImageView alloc] initWithImage:headerLogo] autorelease];
	self.navigationItem.titleView.alpha = 0.0;

	[self performSelector:@selector(animateIconAlpha) withObject:nil afterDelay:0.5];
}

- (void)animateIconAlpha {
	[UIView animateWithDuration:0.5 animations:^{
		self.navigationItem.titleView.alpha = 1;
	} completion:nil];
}

@end
