#import "CSAdvancedListController.h"
#import "../CSAppSwitcherViewController.h"
#include <dlfcn.h>
#import "CSAdvancedBackgroundGradientView.h"
#import <UIKit/UIImage+Private.h>

@implementation CSAdvancedListController {
	CSAppSwitcherViewController *_liveAppSwitcherView;
}

#pragma mark Cephei - HBListController

+ (NSString *)hb_specifierPlist {
	return @"Advanced";
}

#pragma mark init method

- (instancetype)init {
	if (self = [super init]) {
		dlopen("/Library/MobileSubstrate/DynamicLibraries/Chrysalis.dylib", RTLD_LAZY);

		_liveAppSwitcherView = [[%c(CSAppSwitcherViewController) alloc] init];
		_liveAppSwitcherView.view.userInteractionEnabled = NO;
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
	self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

#pragma mark UITableView delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	CSAdvancedBackgroundGradientView *backgroundGradientView = [[CSAdvancedBackgroundGradientView alloc] init];
	//_liveAppSwitcherView.view.center = backgroundGradientView.center;
	//[backgroundGradientView addSubview:_liveAppSwitcherView.view];
    return section == 0 ? backgroundGradientView : nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 183 : 0;
}

@end
