#import "TBCSAppSwitcherViewController.h"
#import "TBCSAppSwitcherCollectionViewCell.h"
#import "TBCSAppSwitcherManager.h"
#import "TBCSDisplayItem.h"
#import "TBCSPreferencesManager.h"
#import <Cephei/CompactConstraint.h>
#import <SpringBoard/SpringBoard.h>
#import <UIKit/UIImage+Private.h>

static NSString *const kTBCSAppSwitcherCollectionViewCellIdentifier = @"ChrysalisAppSwitcherCell";

@implementation TBCSAppSwitcherViewController {
	NSArray <TBCSDisplayItem *> *_displayItems;

	UIView *_slidingIndicatorView;
	UICollectionView *_collectionView;
	UIView *_dividerView;
	UIImageView *_closeAppsImageView;
	UIVisualEffectView *_blurEffectView;
	UILabel *_noAppsLabel;

	CAShapeLayer *_chevronPathMaskLayer;
	CAShapeLayer *_rectanglePathMaskLayer;
	CAGradientLayer *_gradientLayer;

	BOOL _showHomeScreenButton;
}

#pragma mark - UIViewController

- (void)loadView {
	[super loadView];

	UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:[TBCSPreferencesManager sharedInstance].blurEffectStyle];
	_blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    _blurEffectView.translatesAutoresizingMaskIntoConstraints = NO;
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

	_chevronPathMaskLayer = [[CAShapeLayer alloc] init];
	_chevronPathMaskLayer.path = chevronBezierPath.CGPath;
	[containerLayer addSublayer:_chevronPathMaskLayer];

	// rectangle

	_rectanglePathMaskLayer = [[CAShapeLayer alloc] init];

	UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(14, 0, self.view.frame.size.width-14, self.view.frame.size.height) byRoundingCorners:( UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(9.0, 9.0)];
	[rectanglePath fill];
	_rectanglePathMaskLayer.path  = rectanglePath.CGPath;
	[containerLayer addSublayer:_rectanglePathMaskLayer];

	_blurEffectView.layer.mask = containerLayer;

	// other views

	_slidingIndicatorView = [[UIView alloc] init];
	_slidingIndicatorView.frame = CGRectMake(17.5, 0.0, 65.0, 65.0);
	_slidingIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	_slidingIndicatorView.center = CGPointMake(_slidingIndicatorView.center.x, self.view.center.y);
	_slidingIndicatorView.alpha = 0.4;
	_slidingIndicatorView.backgroundColor = [UIColor whiteColor];
	_slidingIndicatorView.layer.masksToBounds = YES;
	_slidingIndicatorView.layer.cornerRadius = 18.0;
	[self.view addSubview:_slidingIndicatorView];

	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.itemSize = CGSizeMake(70.0, 70.0);
	flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	flowLayout.minimumInteritemSpacing = 0;
	flowLayout.minimumLineSpacing = 0;

	_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
	_collectionView.backgroundColor = [UIColor clearColor];
	_collectionView.delegate = self;
	_collectionView.dataSource = self;
	_collectionView.scrollEnabled = NO;
	[_collectionView registerClass:[TBCSAppSwitcherCollectionViewCell class] forCellWithReuseIdentifier:kTBCSAppSwitcherCollectionViewCellIdentifier];
	[self.view addSubview:_collectionView];

	_noAppsLabel = [[UILabel alloc] init];
    _noAppsLabel.translatesAutoresizingMaskIntoConstraints = NO;
	_noAppsLabel.text = @"no apps";
	_noAppsLabel.textAlignment = NSTextAlignmentCenter;
	_noAppsLabel.alpha = 0.6;
	_noAppsLabel.font = [UIFont systemFontOfSize:30.0];
	[_collectionView addSubview:_noAppsLabel];

	_dividerView = [[UIView alloc] init];
    _dividerView.translatesAutoresizingMaskIntoConstraints = NO;
	_dividerView.alpha = 0.45;
	_dividerView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:_dividerView];

	_closeAppsImageView = [[UIImageView alloc] init];
    _closeAppsImageView.translatesAutoresizingMaskIntoConstraints = NO;
	_closeAppsImageView.image = [UIImage imageNamed:@"x" inBundle:[NSBundle bundleWithPath:@"/Library/PreferenceBundles/ChrysalisPrefs.bundle"]];
	_closeAppsImageView.alpha = 0.45;
	_closeAppsImageView.contentMode = UIViewContentModeCenter;
	[self.view addSubview:_closeAppsImageView];

	_gradientLayer = [[CAGradientLayer alloc] init];
	_gradientLayer.startPoint = CGPointMake(0.0, 0.5);
	_gradientLayer.endPoint = CGPointMake(1.0, 0.5);
	_gradientLayer.colors = @[(id)[UIColor blackColor].CGColor, (id)[UIColor clearColor].CGColor];
	_gradientLayer.locations = @[@0.93, @1.0];
	_collectionView.layer.mask = _gradientLayer;

	// auto layout

    NSDictionary <NSString *, UIView *> *views = @{
    	@"self": self.view,
		@"blurEffectView": _blurEffectView,
	    @"collectionView": _collectionView,
	    @"dividerView": _dividerView,
	    @"closeAppsImageView": _closeAppsImageView,
	    @"noAppsLabel": _noAppsLabel
	};

	[self.view hb_addCompactConstraints:@[
		@"blurEffectView.left = self.left",
		@"blurEffectView.right = self.right",
		@"blurEffectView.top = self.top",
		@"blurEffectView.bottom = self.bottom",

		@"collectionView.top = self.top",
		@"collectionView.bottom = self.bottom",

		@"dividerView.top = self.top",
		@"dividerView.bottom = self.bottom",

		@"closeAppsImageView.top = self.top",
		@"closeAppsImageView.bottom = self.bottom",

		@"noAppsLabel.left = collectionView.left",
		@"noAppsLabel.right = collectionView.right",
		@"noAppsLabel.top = collectionView.top",
		@"noAppsLabel.bottom = collectionView.bottom",
	] metrics:nil views:views];

	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[collectionView][dividerView(==0.5)][closeAppsImageView(==45)]|" options:kNilOptions metrics:nil views:views]];

	// prefs

	[self configurePreferences];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configurePreferences) name:HBPreferencesDidChangeNotification object:[TBCSPreferencesManager sharedInstance].preferences];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	[self _updateAppsInSwitcher];
	[self configurePreferences];
}

- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];

	_gradientLayer.frame = self.view.bounds;

	_chevronPathMaskLayer.frame = CGRectMake(0, self.view.frame.size.height/2-25, 14, 34);
	_rectanglePathMaskLayer.frame = self.view.bounds;

	UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(14, 0, self.view.frame.size.width-14, self.view.frame.size.height) byRoundingCorners:( UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(9.0, 9.0)];
	[rectanglePath fill];

	_rectanglePathMaskLayer.path = rectanglePath.CGPath;
}

#pragma mark - Collection View Delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	TBCSAppSwitcherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTBCSAppSwitcherCollectionViewCellIdentifier forIndexPath:indexPath];
	cell.displayItem = _displayItems[indexPath.row];
	return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [_displayItems count];
}

#pragma mark - Update

- (void)_updateAppsInSwitcher {
	[_displayItems release];

	NSMutableArray <TBCSDisplayItem *> *displayItems = [NSMutableArray array];

	if (_useDemoApps) {
		// fill in standard example apps to display in demo situations
		for (NSString *identifier in @[ @"com.apple.mobilemail", @"com.apple.AppStore", @"com.apple.Music", @"com.apple.mobilenotes", @"com.apple.mobileslideshow", @"com.apple.mobilesafari", @"com.apple.Preferences" ]) {
			[displayItems addObject:[TBCSDisplayItem displayItemWithType:@"App" displayIdentifier:identifier]];
		}
	} else {
		// get the list of apps
		displayItems = [TBCSAppSwitcherManager displayItems];
	}

	if (_showHomeScreenButton && (_useDemoApps || ((SpringBoard *)[UIApplication sharedApplication])._accessibilityFrontMostApplication)) {
		[displayItems insertObject:[TBCSDisplayItem homeScreenDisplayItem] atIndex:0];
	}

	_displayItems = [displayItems copy];

	// reload the collection view
	[_collectionView reloadData];

	// do we have any apps open?
	if (_displayItems.count > 0) {
		// if so, we can hide the label, show the sliding indicator
		_noAppsLabel.hidden = YES;
		_slidingIndicatorView.hidden = NO;
	} else {
		// otherwise, we want the opposite
		_noAppsLabel.hidden = NO;
		_slidingIndicatorView.hidden = YES;
	}
}

#pragma mark - Gesture

- (void)updateViewToNewPoint:(CGPoint)point {
	// from the point of the finger, get the index of the icon
	NSInteger index = roundf((point.x + 15) / 70.0);

	// the last 45pt are reserved for the close apps button
	if (point.x > self.view.frame.size.width - 45.0) {
		if (_closeAppsImageView.alpha != 0.7) {
			[UIView animateWithDuration:0.3 animations:^{
				_closeAppsImageView.alpha = 0.7;
			}];
		}
		return;
	} else if (_closeAppsImageView.alpha != 0.45) {
		[UIView animateWithDuration:0.3 animations:^{
			_closeAppsImageView.alpha = 0.45;
		}];
	}

	if (index < _displayItems.count) {
		CGRect closeAppsFrame = CGRectMake(self.view.frame.size.width - 45, 0, 45, _collectionView.frame.size.height);
		CGRect potentialFrame = CGRectMake((index * 70.0) + 17.5, 0, 65, 65);

		if (CGRectIntersectsRect(closeAppsFrame, potentialFrame)) {
			potentialFrame = CGRectMake(self.view.frame.size.width - 40, 0, 35, 35);
		}

		[UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:15.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
			_slidingIndicatorView.frame = potentialFrame;
			_slidingIndicatorView.center = CGPointMake(_slidingIndicatorView.center.x, self.view.center.y);
		} completion:nil];
	}
}

- (void)openAppAtPoint:(CGPoint)point {
	if (point.x > self.view.frame.size.width - 45.0) {
		[TBCSAppSwitcherManager quitAllApps];

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

		return;
	}

	NSInteger index = roundf((point.x + 15) / 70.0);

	HBLogDebug(@"_displayItems.count = %lu, index = %li", (unsigned long)_displayItems.count, (long)index);

	if (index == 0 && _showHomeScreenButton) {
		[TBCSAppSwitcherManager suspend];
	} else if (_displayItems.count > index) {
		TBCSDisplayItem *displayItem = _displayItems[index];
		[(SpringBoard *)[UIApplication sharedApplication] launchApplicationWithIdentifier:displayItem.displayIdentifier suspended:NO];
	}
}

#pragma mark - Preferences

- (void)configurePreferences {
	TBCSPreferencesManager *preferences = [TBCSPreferencesManager sharedInstance];

	_showHomeScreenButton = preferences.showHomeScreenButton;

	[UIView animateWithDuration:1 animations:^{
		_blurEffectView.effect = [UIBlurEffect effectWithStyle:[TBCSPreferencesManager sharedInstance].blurEffectStyle];

		_dividerView.alpha = 0.0;
		_closeAppsImageView.alpha = 0.0;
	}];

	UIColor *selectedColor = preferences.darkMode ? [UIColor whiteColor] : [UIColor blackColor];
	_dividerView.backgroundColor = selectedColor;
	_closeAppsImageView.image = [_closeAppsImageView.image _flatImageWithColor:selectedColor];

	[UIView animateWithDuration:0.5 animations:^{
		_dividerView.alpha = 0.45;
		_closeAppsImageView.alpha = 0.45;
	}];

	[self _updateAppsInSwitcher];
}

#pragma mark - Memory management

- (void)dealloc {
	[_displayItems release];

	[_slidingIndicatorView release];
	[_collectionView release];
	[_dividerView release];
	[_closeAppsImageView release];
	[_blurEffectView release];
	[_noAppsLabel release];

	[_chevronPathMaskLayer release];
	[_rectanglePathMaskLayer release];
	[_gradientLayer release];

	[super dealloc];
}

@end
