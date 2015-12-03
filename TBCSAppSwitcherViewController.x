#import "TBCSAppSwitcherViewController.h"
#import "TBCSAppSwitcherCollectionViewCell.h"
#import "TBCSPreferencesManager.h"
#import <SpringBoard/SpringBoard.h>
#import <SpringBoard/SBApplication.h>
#import <UIKit/UIImage+Private.h>

@interface SBDisplayItem : NSObject {
	NSString *_displayIdentifier;
}

+ (instancetype)displayItemWithType:(NSString *)type displayIdentifier:(NSString *)identifier;

@end

@interface SBAppSwitcherModel : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)mainSwitcherDisplayItems;

- (void)remove:(SBDisplayItem *)displayItem;

@end

static NSString *const kTBCSAppSwitcherCollectionViewCellIdentifier = @"ChrysalisAppSwitcherCell";

@implementation TBCSAppSwitcherViewController {
	NSMutableArray *_appSwitcherIdentifiers;
	UIView *_slidingIndicatorView;
	UICollectionView *_collectionView;
	UIView *_divider;
	UIImageView *_closeAppsImageView;
	UIVisualEffectView *_blurEffectView;
	UILabel *_noAppsLabel;
}

#pragma mark Adding views

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	[self updateAppsInSwitcher];
	[self managePreferences];

	UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:[TBCSPreferencesManager sharedInstance].blurEffectStyle];
	_blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
	_blurEffectView.frame = self.view.frame;
	[self.view addSubview:_blurEffectView];

	CALayer *containerLayer = [CALayer layer];

	// chevron

	UIBezierPath *chevronBezierPath = [UIBezierPath bezierPath];
	[chevronBezierPath moveToPoint: CGPointMake(1.5, 45.68)];
	[chevronBezierPath addCurveToPoint: CGPointMake(29.5, 6.68) controlPoint1: CGPointMake(1.5, 35.98) controlPoint2: CGPointMake(29.5, 38.68)];
	[chevronBezierPath addCurveToPoint: CGPointMake(29.5, 87.68) controlPoint1: CGPointMake(29.5, -25.32) controlPoint2: CGPointMake(29.5, 121.98)];
	[chevronBezierPath addCurveToPoint: CGPointMake(1.5, 45.68) controlPoint1: CGPointMake(29.5, 53.38) controlPoint2: CGPointMake(1.5, 55.38)];
	[chevronBezierPath closePath];
	chevronBezierPath.miterLimit = 4;

	[chevronBezierPath applyTransform:CGAffineTransformMakeScale(0.5, 0.5)];
	[chevronBezierPath fill];

	CAShapeLayer *chevronPathMaskLayer = [[[CAShapeLayer alloc] init] autorelease];
	chevronPathMaskLayer.frame = CGRectMake(0, self.view.frame.size.height/2-25, 14, 34);
	chevronPathMaskLayer.path = chevronBezierPath.CGPath;
	[containerLayer addSublayer:chevronPathMaskLayer];

	// rectangle

	UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(14, 0, self.view.frame.size.width-14, self.view.frame.size.height) byRoundingCorners:( UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(9.0, 9.0)];
	[rectanglePath fill];

	CAShapeLayer *rectanglePathMaskLayer = [[CAShapeLayer alloc] init];
	rectanglePathMaskLayer.frame = self.view.bounds;
	rectanglePathMaskLayer.path  = rectanglePath.CGPath;
	[containerLayer addSublayer:rectanglePathMaskLayer];

	_blurEffectView.layer.mask = containerLayer;

	// other views

	_slidingIndicatorView = [[UIView alloc] init];
	_slidingIndicatorView.frame = CGRectMake(17.5, 0.0, 65.0, 65.0);
	_slidingIndicatorView.center = CGPointMake(_slidingIndicatorView.center.x, self.view.center.y);
	_slidingIndicatorView.alpha = !_appSwitcherIdentifiers || _appSwitcherIdentifiers.count == 0 ? 0 : 0.4;
	_slidingIndicatorView.backgroundColor = [UIColor whiteColor];
	_slidingIndicatorView.layer.masksToBounds = YES;
	_slidingIndicatorView.layer.cornerRadius = 18.0;
	[self.view addSubview:_slidingIndicatorView];

	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.itemSize = CGSizeMake(70.0, 70.0);
	flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	flowLayout.minimumInteritemSpacing = 0;
	flowLayout.minimumLineSpacing = 0;

	_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width-(45+15), self.view.frame.size.height) collectionViewLayout:flowLayout];
	_collectionView.backgroundColor = [UIColor clearColor];
	_collectionView.delegate = self;
	_collectionView.dataSource = self;
	_collectionView.scrollEnabled = NO;
	[_collectionView registerClass:[TBCSAppSwitcherCollectionViewCell class] forCellWithReuseIdentifier:kTBCSAppSwitcherCollectionViewCellIdentifier];
	[self.view addSubview:_collectionView];

	UIColor *selectedColor = [TBCSPreferencesManager sharedInstance].darkMode ? [UIColor whiteColor] : [UIColor blackColor];
	_noAppsLabel = [[UILabel alloc] initWithFrame:_collectionView.frame];
	_noAppsLabel.text = @"no apps open";
	_noAppsLabel.textColor = selectedColor;
	_noAppsLabel.textAlignment = NSTextAlignmentCenter;
	_noAppsLabel.alpha = !_appSwitcherIdentifiers || _appSwitcherIdentifiers.count == 0 ? 0.6 : 0.0;
	_noAppsLabel.font = [UIFont systemFontOfSize:30.0];
	[self.view addSubview:_noAppsLabel];

	_closeAppsImageView = [[UIImageView alloc] init];
	_closeAppsImageView.image = [[UIImage imageNamed:@"x" inBundle:[NSBundle bundleWithPath:@"/Library/PreferenceBundles/ChrysalisPrefs.bundle"]] _flatImageWithColor:selectedColor];
	_closeAppsImageView.frame = CGRectMake(0.0, 0.0, 22.5, 22.5);
	_closeAppsImageView.center = CGPointMake(self.view.frame.size.width-22.5, self.view.center.y);
	_closeAppsImageView.alpha = 0.45;
	[self.view addSubview:_closeAppsImageView];

	_divider = [[UIView alloc] init];
	_divider.frame = CGRectMake(self.view.frame.size.width-45, 0, 1, self.view.frame.size.height);
	_divider.alpha = 0.45;
	_divider.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:_divider];

	CAGradientLayer *gradient = [CAGradientLayer layer];
	gradient.startPoint = CGPointMake(0.0, 0.5);
	gradient.endPoint = CGPointMake(1.0, 0.5);

	gradient.frame = self.view.frame;
	gradient.colors = @[(id)[UIColor blackColor].CGColor, (id)[UIColor clearColor].CGColor];
	gradient.locations = @[@0.93, @1.0];

	_collectionView.layer.mask = gradient;
}

#pragma mark Collection View Delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	TBCSAppSwitcherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTBCSAppSwitcherCollectionViewCellIdentifier forIndexPath:indexPath];

	NSString *identifier = _appSwitcherIdentifiers[indexPath.row];
	[cell setAppIdentifier:identifier];
	return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [_appSwitcherIdentifiers count];
}

#pragma mark View updating

- (void)updateAppsInSwitcher {
	[_appSwitcherIdentifiers release];

	if (!%c(SBAppSwitcherModel) || !%c(SBDisplayItem) || _useDemoApps) {
		// this must be the example from settings
		_appSwitcherIdentifiers = [[NSMutableArray alloc] initWithArray:@[@"com.apple.mobilemail", @"com.apple.AppStore", @"com.apple.Music", @"com.apple.mobilenotes", @"com.apple.mobileslideshow", @"com.apple.mobilesafari", @"com.apple.Preferences"]];
		return;
	}

	NSArray *displayItems = [[%c(SBAppSwitcherModel) sharedInstance] mainSwitcherDisplayItems];
	NSMutableArray *appIdentifiers = [NSMutableArray array];
	for (SBDisplayItem *displayItem in displayItems) {
		[appIdentifiers addObject:[displayItem valueForKey:@"_displayIdentifier"]];
	}

	SpringBoard *app = (SpringBoard *)[UIApplication sharedApplication];
	NSString *currentAppIdentifier = app._accessibilityFrontMostApplication.bundleIdentifier;

	if (currentAppIdentifier) {
		[appIdentifiers removeObject:currentAppIdentifier];
	}

	_appSwitcherIdentifiers = [appIdentifiers copy];

	[_collectionView reloadData];

	_noAppsLabel.alpha = !_appSwitcherIdentifiers || _appSwitcherIdentifiers.count == 0 ? 0.6 : 0.0;
	_slidingIndicatorView.alpha = !_appSwitcherIdentifiers || _appSwitcherIdentifiers.count == 0 ? 0 : 0.4;
}

- (void)updateViewToNewPoint:(CGPoint)point {
	NSInteger index = roundf((point.x+15)/70.0);

	if (point.x > self.view.frame.size.width-45.0) {
		if (_divider.alpha != 0.7) {
			[UIView animateWithDuration:0.3 animations:^{
				_divider.alpha = 0.7;
				_closeAppsImageView.alpha = 0.7;
			}];
		}
		return;
	} else if (_divider.alpha != 0.45) {
		[UIView animateWithDuration:0.3 animations:^{
			_divider.alpha = 0.45;
			_closeAppsImageView.alpha = 0.45;
		}];
	}

	if (_appSwitcherIdentifiers.count > index) {
		[UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:15.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
			CGRect closeAppsFrame = CGRectMake(self.view.frame.size.width-45, 0, 45, _collectionView.frame.size.height);
			CGRect potentialFrame = CGRectMake(index*70.0+17.5, 0, _slidingIndicatorView.frame.size.width, _slidingIndicatorView.frame.size.height);
			if (CGRectIntersectsRect(closeAppsFrame, potentialFrame)) {
				return;
			}
			_slidingIndicatorView.frame = potentialFrame;
			_slidingIndicatorView.center = CGPointMake(_slidingIndicatorView.center.x, self.view.center.y);
		} completion:nil];
	}
}

- (void)openAppAtPoint:(CGPoint)point {
	if (point.x > self.view.frame.size.width-45.0) {
		for (UICollectionViewCell *cell in _collectionView.visibleCells) {
			UIImageView *imageView = [cell valueForKey:@"_appIconImageView"];
			[UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:15.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
				imageView.transform = CGAffineTransformMakeScale(0.15, 0.15);
				imageView.alpha = 0.0;
			} completion:^(BOOL completion) {
				imageView.transform = CGAffineTransformIdentity;
				imageView.alpha = 1.0;
			}];
		}
		[UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:15.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
			_slidingIndicatorView.transform = CGAffineTransformMakeScale(0.15, 0.15);
			_slidingIndicatorView.alpha = 0.0;
		} completion:^(BOOL completion) {
			_slidingIndicatorView.transform = CGAffineTransformIdentity;
			[self updateAppsInSwitcher];
		}];
		SpringBoard *app = (SpringBoard *)[UIApplication sharedApplication];
		NSString *currentAppIdentifier = app._accessibilityFrontMostApplication.bundleIdentifier;
		for (NSString *identifier in _appSwitcherIdentifiers) {
			if (![identifier isEqualToString:currentAppIdentifier]) {
				[[%c(SBAppSwitcherModel) sharedInstance] remove:[%c(SBDisplayItem) displayItemWithType:@"App" displayIdentifier:identifier]];
			}
		}
		return;
	}
	NSInteger index = roundf((point.x+15)/70.0);
	if (_appSwitcherIdentifiers.count > index) {
		NSString *appIdentifier = _appSwitcherIdentifiers[index];
		[(SpringBoard *)[UIApplication sharedApplication] launchApplicationWithIdentifier:appIdentifier suspended:NO];
	}
}

#pragma mark Preferences

- (void)managePreferences {
	[[TBCSPreferencesManager sharedInstance] listenForPreferenceChangeWithCallback:^(NSString *key, NSString *value){
		[UIView animateWithDuration:1 animations:^{
			_blurEffectView.effect = [UIBlurEffect effectWithStyle:[TBCSPreferencesManager sharedInstance].blurEffectStyle];

			_divider.alpha = 0.0;
			_closeAppsImageView.alpha = 0.0;
		}];
		UIColor *selectedColor = [TBCSPreferencesManager sharedInstance].darkMode ? [UIColor whiteColor] : [UIColor blackColor];
		_divider.backgroundColor = selectedColor;
		_closeAppsImageView.image = [_closeAppsImageView.image _flatImageWithColor:selectedColor];
		[UIView animateWithDuration:0.5 animations:^{
			_divider.alpha = 0.45;
			_closeAppsImageView.alpha = 0.45;
		}];

	} forKey:kTBCSPreferencesManagerDarkModeKey];
}

#pragma mark - Memory management

- (void)dealloc {
	[_appSwitcherIdentifiers release];
	[_slidingIndicatorView release];
	[_collectionView release];
	[_divider release];
	[_closeAppsImageView release];
	[_blurEffectView release];

	[super dealloc];
}

@end
