#import "CSPreferencesManager.h"
#import <Cephei/HBPreferences.h>

static NSString *const kCSPreferencesManagerHadFirstRunKey = @"HadFirstRun";

@implementation CSPreferencesManager {
	HBPreferences *_preferences;
	BOOL _hadFirstRun;
}

+ (instancetype)sharedInstance {
	static CSPreferencesManager *sharedInstance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] init];
	});

	return sharedInstance;
}

- (instancetype)init {
	if (self = [super init]) {
		_preferences = [[HBPreferences alloc] initWithIdentifier:@"com.tweakbattles.chrysalis"];

		[_preferences registerBool:&_hadFirstRun default:NO forKey:kCSPreferencesManagerHadFirstRunKey];
	}
	return self;
}

- (BOOL)hadFirstRun {
	return _hadFirstRun;
}

- (void)setHadFirstRun:(BOOL)hadFirstRun {
	_hadFirstRun = YES;

	[_preferences setBool:YES forKey:kCSPreferencesManagerHadFirstRunKey];
	[_preferences synchronize];
}

@end
