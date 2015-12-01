@interface TBCSAppSwitcherViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property BOOL useDemoApps;

- (void)updateViewToNewPoint:(CGPoint)point;

- (void)openAppAtPoint:(CGPoint)point;

- (void)updateAppsInSwitcher;

@end
