#import <Cephei/HBPreferences.h>

static NSString *const kTBCSPreferencesManagerHadFirstRunKey = @"HadFirstRun";
static NSString *const kTBCSPreferencesManagerDarkModeKey = @"DarkMode";

@interface TBCSPreferencesManager : NSObject

@property BOOL hadFirstRun;

@property BOOL darkMode;

@property (readonly) UIBlurEffectStyle blurEffectStyle;

+ (instancetype)sharedInstance;

- (void)listenForPreferenceChangeWithCallback:(HBPreferencesChangeCallback)callback;

@end
