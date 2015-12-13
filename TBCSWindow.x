#import "TBCSWindow.h"
#import "TBCSAppSwitcherViewController.h"
#import "TBCSTutorialViewController.h"
#import <UIKit/UIWindow+Private.h>

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
		self.frame = [UIScreen mainScreen].bounds;
		self.windowLevel = UIWindowLevelAlertReal+2;
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void)showTutorial {
	self.rootViewController = [[[TBCSTutorialViewController alloc] init] autorelease];
	[self.rootViewController viewWillAppear:YES];

	self.hidden = NO;
}

- (void)startAppSwitcher:(CGPoint)point {
	if (![self.rootViewController isKindOfClass:TBCSAppSwitcherViewController.class]) {
		self.rootViewController = [[[TBCSAppSwitcherViewController alloc] init] autorelease];
		self.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/-2, 0, [[UIScreen mainScreen] bounds].size.width, kTBCSAppSwitcherHeight);
		self.layer.anchorPoint = CGPointMake(0, 0.5f);
	}

	[self.rootViewController viewWillAppear:YES];

	// i’m self centered hahaHAHAHA GET IT
	self.center = CGPointMake(self.center.x, point.y);
	self.hidden = NO;
	self.alpha = 0;
	self.transform = CGAffineTransformMakeScale(0.15, 0.15);

	[UIView animateWithDuration:0.1 animations:^{
		self.alpha = 1;
		self.transform = CGAffineTransformIdentity;
	}];
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

- (void)updateToPoint:(CGPoint)point {
	TBCSAppSwitcherViewController *appSwitcher = (TBCSAppSwitcherViewController *)self.rootViewController;
	[appSwitcher updateViewToNewPoint:point];
}

#pragma mark - Touches

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.rootViewController viewWillDisappear:YES];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC * 0.4)), dispatch_get_main_queue(), ^{
        self.rootViewController.view.hidden = YES;
        self.hidden = YES;
    });
}

@end
