#import "CSAdvancedListController.h"

@implementation CSAdvancedListController {
	UIView *_liveAppSwitcherView;
}

#pragma mark Cephei - HBListController

+ (NSString *)hb_specifierPlist {
	return @"Advanced";
}

#pragma mark init method

- (instancetype)init {
	if (self = [super init]) {
		_liveAppSwitcherView = [[UIView alloc] init];
	}
	return self;
}

#pragma mark UITableView delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return section == 0 ? _liveAppSwitcherView : nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 95 : 0;
}

@end
