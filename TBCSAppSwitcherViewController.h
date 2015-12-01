@interface TBCSAppSwitcherViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

- (void)updateViewToNewPoint:(CGPoint)point;

- (void)openAppAtPoint:(CGPoint)point;

- (void)updateAppsInSwitcher;

@end
