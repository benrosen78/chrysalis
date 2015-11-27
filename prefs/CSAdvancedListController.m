#import "CSAdvancedListController.h"
#import <Preferences/PSSpecifier.h>

@implementation CSAdvancedListController

#pragma mark - PSListController

+ (NSString *)hb_specifierPlist {
	return @"Advanced";
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return _configurationHeaderView;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 140;
    }
    return (CGFloat)-1;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	_configurationHeaderView = [[CSLiveConfigurationHeaderView alloc] init];
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	[super setPreferenceValue:value specifier:specifier];

	NSDictionary *properties = specifier.properties;
	NSString *key = properties[@"key"];
	if ([key isEqualToString:@"includeHomescreenIcon"]) {
		if ([value boolValue]) {
			[_configurationHeaderView setHomeScreenIconHidden:YES];
		} else {
			[_configurationHeaderView setHomeScreenIconHidden:NO];
		}
	}
	else if ([key isEqualToString:@"showIconLabels"]) {
		if ([value boolValue]) {
			[_configurationHeaderView setIconLabelsHidden:YES];
		} else {
			[_configurationHeaderView setIconLabelsHidden:NO];
		}
	}
	else if ([key isEqualToString:@"showKillAllButton"]) {
		if ([value boolValue]) {
			[_configurationHeaderView setKillAllButtonHidden:YES];
		} else {
			[_configurationHeaderView setKillAllButtonHidden:NO];
		}
	}
}

@end
