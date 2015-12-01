#import <Cephei/HBPreferences.h>

static NSString *const kTBCSPreferencesManagerHadFirstRunKey = @"HadFirstRun";
static NSString *const kTBCSPreferencesManagerDarkModeKey = @"DarkMode";

@interface TBCSPreferencesManager : NSObject

@property BOOL hadFirstRun;

@property (readonly) UIBlurEffectStyle blurEffectStyle;

+ (instancetype)sharedInstance;

- (void)listenForPreferenceChangeWithCallback:(HBPreferencesValueChangeCallback)callback forKey:(NSString *)key;

@end
