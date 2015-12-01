#import "TBCSAboutHeaderView.h"
#import "TBCSAboutCreatorView.h"
#import <UIKit/UIImage+Private.h>

@implementation TBCSAboutHeaderView

#pragma mark initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier]) {
		TBCSAboutCreatorView *benCreatorView = [[[TBCSAboutCreatorView alloc] initWithTwitterUsername:@"benr9500" name:@"Ben Rosen" creatorType:TBCSAboutCreatorTypeDeveloper] autorelease];
		benCreatorView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:benCreatorView];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:benCreatorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:21]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:benCreatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:0.57 constant:0]];

		TBCSAboutCreatorView *carlosCreatorView = [[[TBCSAboutCreatorView alloc] initWithTwitterUsername:@"cpdigdarkroom" name:@"CP Digital Darkroom" creatorType:TBCSAboutCreatorTypeDeveloper] autorelease];
		carlosCreatorView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:carlosCreatorView];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:carlosCreatorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:21]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:carlosCreatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.43 constant:0]];

		TBCSAboutCreatorView *kirbCreatorView = [[[TBCSAboutCreatorView alloc] initWithTwitterUsername:@"hbkirb" name:@"Adam Demasi (kirb)" creatorType:TBCSAboutCreatorTypeDeveloper] autorelease];
		kirbCreatorView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:kirbCreatorView];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:kirbCreatorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:168]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:kirbCreatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:0.57 constant:0]];

		TBCSAboutCreatorView *veerklemptCreatorView = [[[TBCSAboutCreatorView alloc] initWithTwitterUsername:@"veerklempt" name:@"Veerklempt" creatorType:TBCSAboutCreatorTypeDesigner] autorelease];
		veerklemptCreatorView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:veerklemptCreatorView];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:veerklemptCreatorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:168]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:veerklemptCreatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.43 constant:0]];

		UIImage *chrysalisLogo = [[UIImage imageNamed:@"headerLogo" inBundle:[NSBundle bundleForClass:self.class]] _flatImageWithColor:[UIColor colorWithRed:0.812 green:0.812 blue:0.835 alpha:1.00]];
		UIImageView *chrysalisLogoImageView = [[[UIImageView alloc] init] autorelease];
		chrysalisLogoImageView.image = chrysalisLogo;
		chrysalisLogoImageView.backgroundColor = self.superview.superview.backgroundColor;
		chrysalisLogoImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:chrysalisLogoImageView];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:chrysalisLogoImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:chrysalisLogoImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:303]];

		UIView *leftSeparator = [[[UIView alloc] init] autorelease];
		leftSeparator.backgroundColor = [UIColor colorWithRed:0.812 green:0.812 blue:0.835 alpha:1.00];
		leftSeparator.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:leftSeparator];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:leftSeparator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:chrysalisLogoImageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:leftSeparator attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:18]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:leftSeparator attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:chrysalisLogoImageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-20]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:leftSeparator attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:1.5]];

		UIView *rightSeparator = [[[UIView alloc] init] autorelease];
		rightSeparator.backgroundColor = [UIColor colorWithRed:0.812 green:0.812 blue:0.835 alpha:1.00];
		rightSeparator.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:rightSeparator];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:rightSeparator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:chrysalisLogoImageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:rightSeparator attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:chrysalisLogoImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:20]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:rightSeparator attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-18]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:rightSeparator attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:1.5]];

		UILabel *thankLabel = [[[UILabel alloc] init] autorelease];
		thankLabel.text = @"Thank you for purchasing this tweak. Enjoy!";
		thankLabel.font = [UIFont systemFontOfSize:10];
		thankLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:thankLabel];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:thankLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:thankLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:chrysalisLogoImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:15]];

		UILabel *specialThanksLabel = [[[UILabel alloc] init] autorelease];
		specialThanksLabel.text = @"SPECIAL THANKS TO";
		specialThanksLabel.font = [UIFont systemFontOfSize:12];
		specialThanksLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:specialThanksLabel];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:specialThanksLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:specialThanksLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:thankLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:22]];

		UILabel *supportersLabel = [[[UILabel alloc] init] autorelease];
		supportersLabel.text = @"Eric, Borsato92, cj81499, winlogon0, mootjeuh, @redzrex, Jason R., CONATH, JimDotR, Boris S, Ziph0n, Andrew, /u/DervishSkater, Corporal, Acidschnee, Josh Gibson, HHumbert, Cody, Connor, @sel2by3, Shadow Games, Pixxaddict, platypusw90, echo000, Jonathan Gautreau, Blink, ShaneSparkyYYZ, kamikasky, MaxD, @tilgut, @Beezure, Matteo Piccina, josh_boothman, Moshe Siegel, Ian L, Torben, MeatyCheetos, @rauseo12, Lei33, K S LEE, @RichResk, wizage, @sekrit_, RushNY, Maortega89, @frkbmb_, Kyle, Robert, @BrianOverly, @thetomcanuck, OhSpazz, Jessyreynosa3, Jessie mejia, Jp_delon, dantesieg";
		supportersLabel.font = [UIFont systemFontOfSize:10];
		supportersLabel.numberOfLines = 0;
		supportersLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:supportersLabel];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:supportersLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:18]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:supportersLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-18]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:supportersLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:specialThanksLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:8]];

	}
	return self;
}

- (instancetype)initWithSpecifier:(PSSpecifier *)specifier {
	return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil specifier:specifier];
}

#pragma mark size

- (CGFloat)preferredHeightForWidth:(CGFloat)width {
	return 527.f;
}


@end
