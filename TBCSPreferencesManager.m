#import "TBCSPreferencesManager.h"
#import <Cephei/HBPreferences.h>
#include <notify.h>

@implementation TBCSPreferencesManager {
	HBPreferences *_preferences;
	BOOL _hadFirstRun;
	BOOL _darkMode;
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
	}
	return self;
}

- (BOOL)hadFirstRun {
	return _hadFirstRun;
}

- (void)setHadFirstRun:(BOOL)hadFirstRun {
	_hadFirstRun = YES;

	[_preferences setBool:YES forKey:kTBCSPreferencesManagerHadFirstRunKey];
	notify_post("com.tweakbattles.chrysalis/ReloadPrefs"); // urg, i'm sorry
}

- (UIBlurEffectStyle)blurEffectStyle {
	return _darkMode ? UIBlurEffectStyleDark : UIBlurEffectStyleLight;
}

- (void)listenForPreferenceChangeWithCallback:(HBPreferencesValueChangeCallback)callback forKey:(NSString *)key {
	[_preferences registerPreferenceChangeBlock:callback forKey:key];
}

#pragma mark - Memory management

- (void)dealloc {
	[_preferences release];

	[super dealloc];
}

@end
