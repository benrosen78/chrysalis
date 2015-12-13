#import <Cephei/HBPreferences.h>

static NSString *const kTBCSPreferencesManagerHadFirstRunKey = @"HadFirstRun";
static NSString *const kTBCSPreferencesManagerDarkModeKey = @"DarkMode";
static NSString *const kTBCSPreferencesManagerQuitAppsButtonKey = @"QuitAppsButton";
static NSString *const kTBCSPreferencesManagerHomeScreenButtonKey = @"HomeScreenButton";

@interface TBCSPreferencesManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, retain, readonly) HBPreferences *preferences;

@property (nonatomic) BOOL hadFirstRun;

@property (nonatomic, readonly) BOOL darkMode;
@property (nonatomic, readonly) UIBlurEffectStyle blurEffectStyle;

@property (nonatomic, readonly) BOOL showQuitAppsButton;
@property (nonatomic, readonly) BOOL showHomeScreenButton;

@end
