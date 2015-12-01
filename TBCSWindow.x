#import "TBCSWindow.h"
#import "TBCSAppSwitcherViewController.h"

static CGFloat const kTBCSAppSwitcherHeight = 95.f;

@implementation TBCSWindow

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
	[UIView animateWithDuration:0.1 animations:^{
		self.transform = CGAffineTransformMakeScale(0.15, 0.15);
		self.alpha = 0;
	} completion:^(BOOL completed) {
		self.hidden = YES;
	}];
	TBCSAppSwitcherViewController *appSwitcher = (TBCSAppSwitcherViewController *)self.rootViewController;
	[appSwitcher openAppAtPoint:point];
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
