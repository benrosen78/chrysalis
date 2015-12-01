@interface TBCSPreferencesManager : NSObject

@property BOOL hadFirstRun;

+ (instancetype)sharedInstance;

@end
