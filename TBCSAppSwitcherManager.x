#import "TBCSAppSwitcherManager.h"
#import <SpringBoard/SpringBoard.h>
#import <SpringBoard/SBApplication.h>

@interface SBDisplayItem : NSObject {
	NSString *_displayIdentifier;
}

+ (instancetype)displayItemWithType:(NSString *)type displayIdentifier:(NSString *)identifier;

@end

@interface SBAppSwitcherModel : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)mainSwitcherDisplayItems;
- (void)remove:(SBDisplayItem *)displayItem;

@end

@implementation TBCSAppSwitcherManager

+ (void)quitAllApps {
	SpringBoard *app = (SpringBoard *)[UIApplication sharedApplication];
	NSString *currentAppIdentifier = app._accessibilityFrontMostApplication.bundleIdentifier;

	for (NSString *identifier in self.switcherAppList) {
		if (![identifier isEqualToString:currentAppIdentifier]) {
			[[%c(SBAppSwitcherModel) sharedInstance] remove:[%c(SBDisplayItem) displayItemWithType:@"App" displayIdentifier:identifier]];
		}
	}

	return;
}

+ (NSArray *)switcherAppList {
	NSArray *displayItems = [[%c(SBAppSwitcherModel) sharedInstance] mainSwitcherDisplayItems];
	NSMutableArray *appIdentifiers = [NSMutableArray array];
	for (SBDisplayItem *displayItem in displayItems) {
		[appIdentifiers addObject:[displayItem valueForKey:@"_displayIdentifier"]];
	}

	SpringBoard *app = (SpringBoard *)[UIApplication sharedApplication];
	NSString *currentAppIdentifier = app._accessibilityFrontMostApplication.bundleIdentifier;

	if (currentAppIdentifier) {
		[appIdentifiers removeObject:currentAppIdentifier];
	}

	return appIdentifiers;
}

@end
