#import "CSWindow.h"
#import "CSAppSwitcherViewController.h"

static CGFloat const kCSAppSwitcherHeight = 95.f;

@implementation CSWindow

+ (instancetype)sharedInstance {
	static CSWindow *sharedInstance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] init];
	});

	return sharedInstance;
}

- (instancetype)init {
	if (self = [super init]) {
		self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, kCSAppSwitcherHeight);
		self.windowLevel = UIWindowLevelAlert+2;
		self.rootViewController = [[CSAppSwitcherViewController alloc] init];
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void)updateToPoint:(CGPoint)point {
	if (self.hidden) {
		// this is where it is set
		self.frame = CGRectMake(0, point.y, [[UIScreen mainScreen] bounds].size.width, kCSAppSwitcherHeight);
		self.hidden = NO;
	} else {
		// here, we forward to the view controller, so that the user can slide across the collection view
	}
}

@end
