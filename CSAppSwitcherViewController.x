#import "CSAppSwitcherViewController.h"
#import "CSAppSwitcherCollectionViewCell.h"

static NSString *const kCSAppSwitcherCollectionViewCellIdentifier = @"ChrysalisAppSwitcherCell";

@implementation CSAppSwitcherViewController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
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
	[cell setAppIdentifier:@"com.apple.MobileSMS"];
	return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 10;
}

@end
