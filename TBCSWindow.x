#import "TBCSWindow.h"
#import "TBCSAppSwitcherViewController.h"

static CGFloat const kTBCSAppSwitcherHeight = 95.f;

@implementation TBCSWindow

+ (instancetype)sharedInstance {
	static TBCSWindow *sharedInstance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] init];
	});

	return sharedInstance;
}

- (instancetype)init {
	if (self = [super init]) {
		self.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/-2, 0, [[UIScreen mainScreen] bounds].size.width, kTBCSAppSwitcherHeight);
		self.windowLevel = UIWindowLevelAlert+2;
		self.rootViewController = [[[TBCSAppSwitcherViewController alloc] init] autorelease];
		self.backgroundColor = [UIColor clearColor];
		self.layer.anchorPoint = CGPointMake(0, 0.5f);
	}
	return self;
}

- (void)updateToPoint:(CGPoint)point {
	TBCSAppSwitcherViewController *appSwitcher = (TBCSAppSwitcherViewController *)self.rootViewController;
	[appSwitcher updateViewToNewPoint:point];
}

- (void)removeFromPoint:(CGPoint)point {
	TBCSAppSwitcherViewController *appSwitcher = (TBCSAppSwitcherViewController *)self.rootViewController;
	[appSwitcher openAppAtPoint:point];
	[UIView animateWithDuration:0.1 delay:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
		self.transform = CGAffineTransformMakeScale(0.15, 0.15);
		self.alpha = 0;
	} completion:^(BOOL completed) {
		self.hidden = YES;
	}];
}

- (void)startAppSwitcher:(CGPoint)point {
	TBCSAppSwitcherViewController *appSwitcher = (TBCSAppSwitcherViewController *)self.rootViewController;
	[appSwitcher updateAppsInSwitcher];

	self.center = CGPointMake(self.center.x, point.y);
	self.hidden = NO;
	self.alpha = 0;
	self.transform = CGAffineTransformMakeScale(0.15, 0.15);

	[UIView animateWithDuration:0.1 animations:^{
		self.alpha = 1;
		self.transform = CGAffineTransformIdentity;
	}];
}

@end
