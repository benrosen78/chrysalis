#import "TBCSAdvancedListController.h"
#import "../TBCSAppSwitcherViewController.h"
#include <dlfcn.h>
#import "TBCSAdvancedBackgroundGradientView.h"
#import <UIKit/UIImage+Private.h>
#import <UIKit/UINavigationBar+Private.h>

@implementation TBCSAdvancedListController {
	TBCSAdvancedBackgroundGradientView *_backgroundGradientView;
	TBCSAppSwitcherViewController *_liveAppSwitcherView;
}

#pragma mark Cephei - HBListController

+ (NSString *)hb_specifierPlist {
	return @"Advanced";
}

#pragma mark TBCSAdvancedListController

- (instancetype)init {
	if (self = [super init]) {
		dlopen("/Library/MobileSubstrate/DynamicLibraries/Chrysalis.dylib", RTLD_NOW);
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	_backgroundGradientView = [[TBCSAdvancedBackgroundGradientView alloc] init];
	_backgroundGradientView.frame = CGRectMake(0, 0, self.table.frame.size.width, 183);
	_backgroundGradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

	_liveAppSwitcherView = [[%c(TBCSAppSwitcherViewController) alloc] init];
	_liveAppSwitcherView.view.userInteractionEnabled = NO;
	_liveAppSwitcherView.view.frame = CGRectMake(0, 0, _backgroundGradientView.frame.size.width, 95);
	_liveAppSwitcherView.view.center = CGPointMake(_liveAppSwitcherView.view.center.x, _backgroundGradientView.frame.size.height / 2);
	_liveAppSwitcherView.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;

	[_backgroundGradientView addSubview:_liveAppSwitcherView.view];
	[self addChildViewController:_liveAppSwitcherView];
	[_liveAppSwitcherView didMoveToParentViewController:self];

	self.table.tableHeaderView = _backgroundGradientView;

	UIView *pullDownView = [[[UIView alloc] initWithFrame:CGRectMake(0, -1000.f, self.table.frame.size.width, 1000.f)] autorelease];
	pullDownView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	pullDownView.backgroundColor = [UIColor colorWithRed:0.498 green:0.498 blue:0.506 alpha:1.00];
	[self.table addSubview:pullDownView];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self.realNavigationController.navigationBar _setHidesShadow:YES];
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	[self.realNavigationController.navigationBar _setHidesShadow:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self.realNavigationController.navigationBar _setHidesShadow:NO];
	[_liveAppSwitcherView removeFromParentViewController];
}

#pragma mark - Memory management

- (void)dealloc {
	[_backgroundGradientView release];
	[_liveAppSwitcherView release];

	[super dealloc];
}

@end
