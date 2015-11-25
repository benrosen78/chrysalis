@interface CSWindow : UIWindow

+ (instancetype)sharedInstance;

- (void)updateToPoint:(CGPoint)point;

@end
