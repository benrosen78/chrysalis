@interface CSWindow : UIWindow

+ (instancetype)sharedInstance;

- (void)updateToPoint:(CGPoint)point;

- (void)removeFromPoint:(CGPoint)point;

- (void)startAppSwitcher;

@end
