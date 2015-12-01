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

	UIView *viewToAddGradientTo = [[[UIView alloc] initWithFrame:CGRectMake(0, 34, [[UIScreen mainScreen] bounds].size.width, 95)] autorelease];
	viewToAddGradientTo.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

	_liveAppSwitcherView = [[%c(TBCSAppSwitcherViewController) alloc] init];
	_liveAppSwitcherView.view.userInteractionEnabled = NO;
	_liveAppSwitcherView.view.frame = viewToAddGradientTo.bounds;

	_backgroundGradientView = [[TBCSAdvancedBackgroundGradientView alloc] init];
	_backgroundGradientView.frame = CGRectMake(0, 0, self.view.frame.size.width, 183);

	[_backgroundGradientView addSubview:viewToAddGradientTo];

	[viewToAddGradientTo addSubview:_liveAppSwitcherView.view];
	[self addChildViewController:_liveAppSwitcherView];
	[_liveAppSwitcherView didMoveToParentViewController:self];

	self.table.tableHeaderView = _backgroundGradientView;
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
