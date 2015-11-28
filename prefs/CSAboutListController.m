#import "CSAboutListController.h"
#import "CSAboutCreatorView.h"
#import <UIKit/UIImage+Private.h>

@implementation CSAboutListController

#pragma mark Cephei - HBListController

+ (NSString *)hb_specifierPlist {
	return @"About";
}

- (void)viewDidLoad {
	[super viewDidLoad];

	CSAboutCreatorView *benCreatorView = [[CSAboutCreatorView alloc] initWithTwitterUsername:@"benr9500" name:@"Ben Rosen" creatorType:CSAboutCreatorTypeDeveloper];
	benCreatorView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.table addSubview:benCreatorView];
	[self.table addConstraint:[NSLayoutConstraint constraintWithItem:benCreatorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.table attribute:NSLayoutAttributeTop multiplier:1.0 constant:21]];
	[self.table addConstraint:[NSLayoutConstraint constraintWithItem:benCreatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.table attribute:NSLayoutAttributeCenterX multiplier:0.57 constant:0]];

	CSAboutCreatorView *carlosCreatorView = [[CSAboutCreatorView alloc] initWithTwitterUsername:@"cpdigdarkroom" name:@"CP Digital Darkroom" creatorType:CSAboutCreatorTypeDeveloper];
	carlosCreatorView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.table addSubview:carlosCreatorView];
	[self.table addConstraint:[NSLayoutConstraint constraintWithItem:carlosCreatorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.table attribute:NSLayoutAttributeTop multiplier:1.0 constant:21]];
	[self.table addConstraint:[NSLayoutConstraint constraintWithItem:carlosCreatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.table attribute:NSLayoutAttributeCenterX multiplier:1.43 constant:0]];

	CSAboutCreatorView *kirbCreatorView = [[CSAboutCreatorView alloc] initWithTwitterUsername:@"hbkirb" name:@"Adam Demasi (kirb)" creatorType:CSAboutCreatorTypeDeveloper];
	kirbCreatorView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.table addSubview:kirbCreatorView];
	[self.table addConstraint:[NSLayoutConstraint constraintWithItem:kirbCreatorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.table attribute:NSLayoutAttributeTop multiplier:1.0 constant:168]];
	[self.table addConstraint:[NSLayoutConstraint constraintWithItem:kirbCreatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.table attribute:NSLayoutAttributeCenterX multiplier:0.57 constant:0]];

	CSAboutCreatorView *veerklemptCreatorView = [[CSAboutCreatorView alloc] initWithTwitterUsername:@"veerklempt" name:@"Veerklempt" creatorType:CSAboutCreatorTypeDesigner];
	veerklemptCreatorView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.table addSubview:veerklemptCreatorView];
	[self.table addConstraint:[NSLayoutConstraint constraintWithItem:veerklemptCreatorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.table attribute:NSLayoutAttributeTop multiplier:1.0 constant:168]];
	[self.table addConstraint:[NSLayoutConstraint constraintWithItem:veerklemptCreatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.table attribute:NSLayoutAttributeCenterX multiplier:1.43 constant:0]];

	UIImage *chrysalisLogo = [[UIImage imageNamed:@"headerLogo" inBundle:[NSBundle bundleWithPath:@"/Library/PreferenceBundles/ChrysalisPrefs.bundle"]] _flatImageWithColor:[UIColor colorWithRed:0.431 green:0.431 blue:0.439 alpha:1.00]];
	UIImageView *chrysalisLogoImageView = [[UIImageView alloc] init];
	chrysalisLogoImageView.image = chrysalisLogo;
	chrysalisLogoImageView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.table addSubview:chrysalisLogoImageView];
	[self.table addConstraint:[NSLayoutConstraint constraintWithItem:chrysalisLogoImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.table attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
	[self.table addConstraint:[NSLayoutConstraint constraintWithItem:chrysalisLogoImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.table attribute:NSLayoutAttributeTop multiplier:1.0 constant:303]];



}

@end
