#import "CSAboutListController.h"
#import "CSAboutCreatorView.h"

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
}

@end
