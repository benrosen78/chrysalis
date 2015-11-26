#import "CSAppSwitcherViewController.h"
#import "CSAppSwitcherCollectionViewCell.h"

@interface SBAppSwitcherModel : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)mainSwitcherDisplayItems;

@end

@interface SBDisplayItem : NSObject {
	NSString *_displayIdentifier;
}

@end

static NSString *const kCSAppSwitcherCollectionViewCellIdentifier = @"ChrysalisAppSwitcherCell";

@implementation CSAppSwitcherViewController {
	NSArray *_appSwitcherDisplayItems;
	UIView *_backgroundColorView;
	UICollectionView *_collectionView;
}

#pragma mark Adding views

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	_appSwitcherDisplayItems = [[[%c(SBAppSwitcherModel) sharedInstance] mainSwitcherDisplayItems] retain];

	UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
   	blurEffectView.frame = self.view.frame;

   	UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:blurEffectView.bounds byRoundingCorners:( UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(18.0, 18.0)];

   	CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
   	maskLayer.frame = self.view.bounds;
   	maskLayer.path  = maskPath.CGPath;

   	blurEffectView.layer.mask = maskLayer;

	[self.view addSubview:blurEffectView];

	_backgroundColorView = [[UIView alloc] init];
	_backgroundColorView.frame = CGRectMake(4, 0.0, 62.0, 62.0);
	_backgroundColorView.center = CGPointMake(_backgroundColorView.center.x, self.view.center.y);
	_backgroundColorView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
	_backgroundColorView.layer.masksToBounds = YES;
	_backgroundColorView.layer.cornerRadius = 18.0;
	[self.view addSubview:_backgroundColorView];

	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.itemSize = CGSizeMake(70.0, 70.0);
	flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	flowLayout.minimumInteritemSpacing = 0;
	flowLayout.minimumLineSpacing = 0;

	_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-60, self.view.frame.size.height) collectionViewLayout:flowLayout];
	_collectionView.backgroundColor = [UIColor clearColor];
	_collectionView.delegate = self;
	_collectionView.dataSource = self;
	_collectionView.scrollEnabled = NO;
	[_collectionView registerClass:[CSAppSwitcherCollectionViewCell class] forCellWithReuseIdentifier:kCSAppSwitcherCollectionViewCellIdentifier];
	[self.view addSubview:_collectionView];
}

#pragma mark Collection View Delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	CSAppSwitcherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCSAppSwitcherCollectionViewCellIdentifier forIndexPath:indexPath];

	SBDisplayItem *displayItem = _appSwitcherDisplayItems[indexPath.row];
	NSString *appIdentifier = [displayItem valueForKey:@"_displayIdentifier"];
	[cell setAppIdentifier:appIdentifier];
	return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [_appSwitcherDisplayItems count];
}

#pragma mark View updating

- (void)updateViewToNewPoint:(CGPoint)point {
	NSInteger index = roundf((point.x/70.0));

	_backgroundColorView.frame = CGRectMake(index*70.0+4, 0, _backgroundColorView.frame.size.width, _backgroundColorView.frame.size.height);
	_backgroundColorView.center = CGPointMake(_backgroundColorView.center.x, self.view.center.y);
}

@end
