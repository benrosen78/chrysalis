#import "TBCSPreferencesManager.h"
#import <Cephei/HBPreferences.h>

static NSString *const kTBCSPreferencesManagerHadFirstRunKey = @"HadFirstRun";

@implementation TBCSPreferencesManager {
	HBPreferences *_preferences;
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
	}
	return self;
}

- (BOOL)hadFirstRun {
	return _hadFirstRun;
}

- (void)setHadFirstRun:(BOOL)hadFirstRun {
	_hadFirstRun = YES;

	[_preferences setBool:YES forKey:kTBCSPreferencesManagerHadFirstRunKey];
	[_preferences synchronize];
}

@end
