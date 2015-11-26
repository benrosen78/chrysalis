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
}

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

	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.itemSize = CGSizeMake(70.0, 70.0);
	flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	flowLayout.minimumInteritemSpacing = 0;
	flowLayout.minimumLineSpacing = 0;

	UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-60, self.view.frame.size.height) collectionViewLayout:flowLayout];
	collectionView.backgroundColor = [UIColor clearColor];
	collectionView.delegate = self;
	collectionView.dataSource = self;
	[collectionView registerClass:[CSAppSwitcherCollectionViewCell class] forCellWithReuseIdentifier:kCSAppSwitcherCollectionViewCellIdentifier];
	[self.view addSubview:collectionView];
}

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

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //UITouch *touch = [[event allTouches] anyObject];
    //CGPoint touchLocation = [touch locationInView:self];
}

@end
