#import "CSAppSwitcherViewController.h"
#import "CSAppSwitcherCollectionViewCell.h"
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

static NSString *const kCSAppSwitcherCollectionViewCellIdentifier = @"ChrysalisAppSwitcherCell";

@implementation CSAppSwitcherViewController {
	NSMutableArray *_appSwitcherIdentifiers;
	UIView *_backgroundColorView;
	UICollectionView *_collectionView;
	UIView *_divider;
	UIImageView *_closeAppsImageView;
}

#pragma mark Adding views

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	[self updateAppsInSwitcher];

	UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
	UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
	blurEffectView.frame = self.view.frame;
	[self.view addSubview:blurEffectView];

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

	CAShapeLayer *chevronPathMaskLayer = [[CAShapeLayer alloc] init];
	chevronPathMaskLayer.frame = CGRectMake(0, self.view.frame.size.height/2-25.5, 14, 34);
	chevronPathMaskLayer.path = chevronBezierPath.CGPath;
	[containerLayer addSublayer:chevronPathMaskLayer];

	// rectangle

	UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(14, 0, self.view.frame.size.width-14, self.view.frame.size.height) byRoundingCorners:( UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(9.0, 9.0)];
	[rectanglePath fill];

	CAShapeLayer *rectanglePathMaskLayer = [[CAShapeLayer alloc] init];
	rectanglePathMaskLayer.frame = self.view.bounds;
	rectanglePathMaskLayer.path  = rectanglePath.CGPath;
	[containerLayer addSublayer:rectanglePathMaskLayer];

	blurEffectView.layer.mask = containerLayer;

	// other views

	_backgroundColorView = [[UIView alloc] init];
	_backgroundColorView.frame = CGRectMake(16.5, 0.0, 65.0, 65.0);
	_backgroundColorView.center = CGPointMake(_backgroundColorView.center.x, self.view.center.y);
	_backgroundColorView.backgroundColor = [UIColor whiteColor];
	_backgroundColorView.alpha = 0.4;
	_backgroundColorView.layer.masksToBounds = YES;
	_backgroundColorView.layer.cornerRadius = 18.0;
	[self.view addSubview:_backgroundColorView];

	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.itemSize = CGSizeMake(70.0, 70.0);
	flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	flowLayout.minimumInteritemSpacing = 0;
	flowLayout.minimumLineSpacing = 0;

	_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(14, 0, self.view.frame.size.width-(45+14), self.view.frame.size.height) collectionViewLayout:flowLayout];
	_collectionView.backgroundColor = [UIColor clearColor];
	_collectionView.delegate = self;
	_collectionView.dataSource = self;
	_collectionView.scrollEnabled = NO;
	[_collectionView registerClass:[CSAppSwitcherCollectionViewCell class] forCellWithReuseIdentifier:kCSAppSwitcherCollectionViewCellIdentifier];
	[self.view addSubview:_collectionView];

	CAGradientLayer *gradient = [CAGradientLayer layer];
	gradient.startPoint = CGPointMake(0.0, 0.5);
	gradient.endPoint = CGPointMake(1.0, 0.5);

	gradient.frame = self.view.frame;
	gradient.colors = @[(id)[UIColor blackColor].CGColor, (id)[UIColor clearColor].CGColor];
	gradient.locations = @[@0.93, @1.0];

	_collectionView.layer.mask = gradient;

	_divider = [[UIView alloc] init];
	_divider.frame = CGRectMake(self.view.frame.size.width-45, 0, 1, self.view.frame.size.height);
	_divider.backgroundColor = [UIColor blackColor];
	_divider.alpha = 0.45;
	[self.view addSubview:_divider];

	_closeAppsImageView = [[UIImageView alloc] init];
	_closeAppsImageView.image = [UIImage imageNamed:@"x" inBundle:[NSBundle bundleWithPath:@"/Library/PreferenceBundles/ChrysalisPrefs.bundle"]];
	_closeAppsImageView.frame = CGRectMake(0.0, 0.0, 22.5, 22.5);
	_closeAppsImageView.center = CGPointMake(self.view.frame.size.width-22.5, self.view.center.y);
	_closeAppsImageView.alpha = 0.45;
	[self.view addSubview:_closeAppsImageView];

}

#pragma mark Collection View Delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	CSAppSwitcherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCSAppSwitcherCollectionViewCellIdentifier forIndexPath:indexPath];

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

	if (!%c(SBAppSwitcherModel) || !%c(SBDisplayItem)) {
		// this must be the example from settings
		_appSwitcherIdentifiers = [[NSMutableArray alloc] initWithArray:@[@"com.apple.mobilemail", @"com.apple.AppStore", @"com.apple.Music", @"com.apple.mobilenotes", @"com.apple.mobileslideshow", @"com.apple.mobilesafari", @"com.apple.Preferences"]];
		return;
	}

	NSArray *displayItems = [[%c(SBAppSwitcherModel) sharedInstance] mainSwitcherDisplayItems];
	NSMutableArray *appIdentifiers = [[NSMutableArray alloc] init];
	for (SBDisplayItem *displayItem in displayItems) {
		[appIdentifiers addObject:[displayItem valueForKey:@"_displayIdentifier"]];
	}
	_appSwitcherIdentifiers = appIdentifiers;

	SpringBoard *app = (SpringBoard *)[UIApplication sharedApplication];
	NSString *currentAppIdentifier = app._accessibilityFrontMostApplication.bundleIdentifier;

	[_appSwitcherIdentifiers removeObject:currentAppIdentifier];

	[_collectionView reloadData];
}

- (void)updateViewToNewPoint:(CGPoint)point {
	NSInteger index = roundf((point.x+14)/70.0);

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
			CGRect potentialFrame = CGRectMake(index*70.0+16.5, 0, _backgroundColorView.frame.size.width, _backgroundColorView.frame.size.height);
			if (CGRectIntersectsRect(closeAppsFrame, potentialFrame)) {
				return;
			}
			_backgroundColorView.frame = potentialFrame;
			_backgroundColorView.center = CGPointMake(_backgroundColorView.center.x, self.view.center.y);
		} completion:nil];
	}

	/*BOOL scrollLeft = point.x <= 150;
	BOOL scrollRight = point.x >= self.view.frame.size.width-150;
	static BOOL shouldScroll = YES;
	if (scrollLeft || scrollRight) {
		CGFloat increment = scrollLeft ? -10 : 10;
		CGPoint newContentOffset = CGPointMake(_collectionView.contentOffset.x+increment, 0);
		[UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
			shouldScroll = NO;
			[_collectionView setContentOffset:newContentOffset animated:NO];
		} completion:^(BOOL completion) {
			shouldScroll = YES;
		}];
	}*/
}

- (void)openAppAtPoint:(CGPoint)point {
	if (point.x > self.view.frame.size.width-45.0) {
		SpringBoard *app = (SpringBoard *)[UIApplication sharedApplication];
		NSString *currentAppIdentifier = app._accessibilityFrontMostApplication.bundleIdentifier;
		for (NSString *identifier in _appSwitcherIdentifiers) {
			if (![identifier isEqualToString:currentAppIdentifier]) {
				[[%c(SBAppSwitcherModel) sharedInstance] remove:[%c(SBDisplayItem) displayItemWithType:@"App" displayIdentifier:identifier]];
			}
		}
		[self updateAppsInSwitcher];
		return;
	}
	NSInteger index = roundf((point.x+14)/70.0);
	if (_appSwitcherIdentifiers.count > index) {
		NSString *appIdentifier = _appSwitcherIdentifiers[index];;
		[(SpringBoard *)[UIApplication sharedApplication] launchApplicationWithIdentifier:appIdentifier suspended:NO];
	}
}

@end
