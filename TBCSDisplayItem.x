#import "TBCSDisplayItem.h"
#import <FrontBoard/FBSystemApp.h>
#import <SpringBoard/SBDisplayItem.h>

@implementation TBCSDisplayItem

+ (instancetype)displayItemWithSBDisplayItem:(SBDisplayItem *)displayItem {
	if (!%c(SBDisplayItem)) {
		return nil;
	}

	return [self displayItemWithType:displayItem.type displayIdentifier:displayItem.displayIdentifier];
}

+ (instancetype)displayItemWithType:(NSString *)type displayIdentifier:(NSString *)displayIdentifier {
	return [[[self alloc] initWithType:type displayIdentifier:displayIdentifier] autorelease];
}

+ (instancetype)homeScreenDisplayItem {
	return [self displayItemWithType:@"Homescreen" displayIdentifier:FBSystemAppBundleID()];
}

- (instancetype)initWithType:(NSString *)type displayIdentifier:(NSString *)displayIdentifier {
	self = [self init];

	if (self) {
		_type = [type copy];
		_displayIdentifier = [displayIdentifier copy];
	}

	return self;
}

- (SBDisplayItem *)sbDisplayItem {
	if (!%c(SBDisplayItem)) {
		return nil;
	}

	return [%c(SBDisplayItem) displayItemWithType:self.type displayIdentifier:self.displayIdentifier];
}

@end
