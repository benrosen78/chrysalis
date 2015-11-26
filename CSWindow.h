@interface CSWindow : UIWindow

+ (instancetype)sharedInstance;

- (void)updateToPoint:(CGPoint)point;

- (void)removeAppSwitcher;

@end
