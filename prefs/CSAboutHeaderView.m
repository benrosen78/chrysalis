#import "CSAboutHeaderView.h"
#import "CSAboutCreatorView.h"
#import <UIKit/UIImage+Private.h>

@implementation CSAboutHeaderView

#pragma mark initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier]) {
		CSAboutCreatorView *benCreatorView = [[CSAboutCreatorView alloc] initWithTwitterUsername:@"benr9500" name:@"Ben Rosen" creatorType:CSAboutCreatorTypeDeveloper];
		benCreatorView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:benCreatorView];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:benCreatorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:21]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:benCreatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:0.57 constant:0]];

		CSAboutCreatorView *carlosCreatorView = [[CSAboutCreatorView alloc] initWithTwitterUsername:@"cpdigdarkroom" name:@"CP Digital Darkroom" creatorType:CSAboutCreatorTypeDeveloper];
		carlosCreatorView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:carlosCreatorView];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:carlosCreatorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:21]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:carlosCreatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.43 constant:0]];

		CSAboutCreatorView *kirbCreatorView = [[CSAboutCreatorView alloc] initWithTwitterUsername:@"hbkirb" name:@"Adam Demasi (kirb)" creatorType:CSAboutCreatorTypeDeveloper];
		kirbCreatorView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:kirbCreatorView];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:kirbCreatorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:168]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:kirbCreatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:0.57 constant:0]];

		CSAboutCreatorView *veerklemptCreatorView = [[CSAboutCreatorView alloc] initWithTwitterUsername:@"veerklempt" name:@"Veerklempt" creatorType:CSAboutCreatorTypeDesigner];
		veerklemptCreatorView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:veerklemptCreatorView];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:veerklemptCreatorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:168]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:veerklemptCreatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.43 constant:0]];

		UIImage *chrysalisLogo = [[UIImage imageNamed:@"headerLogo" inBundle:[NSBundle bundleWithPath:@"/Library/PreferenceBundles/ChrysalisPrefs.bundle"]] _flatImageWithColor:[UIColor colorWithRed:0.812 green:0.812 blue:0.835 alpha:1.00]];
		UIImageView *chrysalisLogoImageView = [[UIImageView alloc] init];
		chrysalisLogoImageView.image = chrysalisLogo;
		chrysalisLogoImageView.backgroundColor = self.superview.superview.backgroundColor;
		chrysalisLogoImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:chrysalisLogoImageView];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:chrysalisLogoImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:chrysalisLogoImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:303]];

		UIView *leftSeparator = [[UIView alloc] init];
		leftSeparator.backgroundColor = [UIColor colorWithRed:0.812 green:0.812 blue:0.835 alpha:1.00];
		leftSeparator.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:leftSeparator];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:leftSeparator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:chrysalisLogoImageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:leftSeparator attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:18]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:leftSeparator attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:chrysalisLogoImageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-20]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:leftSeparator attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:1.5]];

		UIView *rightSeparator = [[UIView alloc] init];
		rightSeparator.backgroundColor = [UIColor colorWithRed:0.812 green:0.812 blue:0.835 alpha:1.00];
		rightSeparator.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:rightSeparator];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:rightSeparator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:chrysalisLogoImageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:rightSeparator attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:chrysalisLogoImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:20]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:rightSeparator attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-18]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:rightSeparator attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:1.5]];
	}
	return self;
}

- (instancetype)initWithSpecifier:(PSSpecifier *)specifier {
	return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil specifier:specifier];
}

#pragma mark size

- (CGFloat)preferredHeightForWidth:(CGFloat)width {
	return 553.f;
}


@end
