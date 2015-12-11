#import "TBCSAdvancedListController.h"
#import "../TBCSAppSwitcherViewController.h"
#include <dlfcn.h>
#import "TBCSAdvancedBackgroundGradientView.h"
#import <UIKit/UIImage+Private.h>
#import <UIKit/UINavigationBar+Private.h>

@implementation TBCSAdvancedListController {
	TBCSAdvancedBackgroundGradientView *_backgroundGradientView;
	TBCSAppSwitcherViewController *_appSwitcherViewController;
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
	_backgroundGradientView.frame = CGRectMake(0, 0, self.view.frame.size.width, 183);

	UIView *containerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 34, self.table.frame.size.width, 95)] autorelease];
	containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[_backgroundGradientView addSubview:containerView];

	_appSwitcherViewController = [[%c(TBCSAppSwitcherViewController) alloc] init];
	_appSwitcherViewController.useDemoApps = YES;
	_appSwitcherViewController.view.userInteractionEnabled = NO;
	_appSwitcherViewController.view.frame = containerView.bounds;

	[containerView addSubview:_appSwitcherViewController.view];
	[self addChildViewController:_appSwitcherViewController];
	[_appSwitcherViewController didMoveToParentViewController:self];

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
	[_appSwitcherViewController removeFromParentViewController];
}

#pragma mark - Memory management

- (void)dealloc {
	[_backgroundGradientView release];
	[_appSwitcherViewController release];

	[super dealloc];
}

@end
