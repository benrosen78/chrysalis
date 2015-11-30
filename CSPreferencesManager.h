@interface CSPreferencesManager : NSObject

@property BOOL hadFirstRun;

+ (instancetype)sharedInstance;

@end
