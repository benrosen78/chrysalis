#import <Cephei/HBPreferences.h>

static NSString *const kTBCSPreferencesManagerHadFirstRunKey = @"HadFirstRun";
static NSString *const kTBCSPreferencesManagerDarkModeKey = @"DarkMode";

@interface TBCSPreferencesManager : NSObject

@property (nonatomic, retain, readonly) HBPreferences *preferences;

@property (nonatomic) BOOL hadFirstRun;
@property (nonatomic, readonly) BOOL darkMode;
@property (nonatomic, readonly) UIBlurEffectStyle blurEffectStyle;

+ (instancetype)sharedInstance;

@end
