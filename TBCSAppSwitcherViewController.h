@interface TBCSAppSwitcherViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) BOOL useDemoApps;

- (void)updateViewToNewPoint:(CGPoint)point;

- (void)openAppAtPoint:(CGPoint)point;

@end
