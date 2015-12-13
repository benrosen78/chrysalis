#import "TBCSPreferencesManager.h"
#import <Cephei/HBPreferences.h>
#include <notify.h>

@implementation TBCSPreferencesManager {
	BOOL _hadFirstRun;
}

+ (instancetype)sharedInstance {
	static TBCSPreferencesManager *sharedInstance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] init];
	});

	return sharedInstance;
}

- (instancetype)init {
	if (self = [super init]) {
		_preferences = [[HBPreferences alloc] initWithIdentifier:@"com.tweakbattles.chrysalis"];

		[_preferences registerBool:&_hadFirstRun default:NO forKey:kTBCSPreferencesManagerHadFirstRunKey];
		[_preferences registerBool:&_darkMode default:NO forKey:kTBCSPreferencesManagerDarkModeKey];

		[_preferences registerBool:&_showQuitAppsButton default:YES forKey:kTBCSPreferencesManagerQuitAppsButtonKey];
		[_preferences registerBool:&_showHomeScreenButton default:NO forKey:kTBCSPreferencesManagerHomeScreenButtonKey];
	}
	return self;
}

- (BOOL)hadFirstRun {
	return _hadFirstRun;
}

- (void)setHadFirstRun:(BOOL)hadFirstRun {
	[_preferences setBool:hadFirstRun forKey:kTBCSPreferencesManagerHadFirstRunKey];
}

- (UIBlurEffectStyle)blurEffectStyle {
	return _darkMode ? UIBlurEffectStyleDark : UIBlurEffectStyleLight;
}

#pragma mark - Memory management

- (void)dealloc {
	[_preferences release];

	[super dealloc];
}

@end
