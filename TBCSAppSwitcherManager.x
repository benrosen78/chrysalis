#import "TBCSAppSwitcherManager.h"
#import "TBCSDisplayItem.h"
#import <SpringBoard/SpringBoard.h>
#import <SpringBoard/SBApplication.h>
#import <SpringBoard/SBApplicationController.h>

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

+ (NSMutableArray <TBCSDisplayItem *> *)displayItems {
	NSArray <SBDisplayItem *> *sbDisplayItems = ((SBAppSwitcherModel *)[%c(SBAppSwitcherModel) sharedInstance]).mainSwitcherDisplayItems;
	NSMutableArray <TBCSDisplayItem *> *displayItems = [NSMutableArray array];

	for (SBDisplayItem *displayItem in sbDisplayItems) {
		[displayItems addObject:[TBCSDisplayItem displayItemWithSBDisplayItem:displayItem]];
	}

	SpringBoard *app = (SpringBoard *)[UIApplication sharedApplication];

	// if we’re in an app, it’ll be at position 0. remove it
	if (app._accessibilityFrontMostApplication) {
		[displayItems removeObjectAtIndex:0];
	}

	return displayItems;
}

+ (void)quitAllApps {
	for (TBCSDisplayItem *displayItem in self.displayItems) {
		[[%c(SBAppSwitcherModel) sharedInstance] remove:displayItem.sbDisplayItem];
	}
}

+ (void)suspend {
	SpringBoard *app = (SpringBoard *)[UIApplication sharedApplication];
	SBApplication *frontmostApp = app._accessibilityFrontMostApplication;

	if (frontmostApp) {
		[[%c(SBApplicationController) sharedInstance] applicationService:nil suspendApplicationWithBundleIdentifier:frontmostApp.bundleIdentifier];
	}
}

@end
