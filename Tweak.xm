#import "TBCSPreferencesManager.h"
#import "TBCSWindow.h"
#import <SpringBoard/SBIconController.h>
#import <SpringBoard/SBIconListView.h>
#import <SpringBoard/SBMainDisplaySystemGestureManager.h>
#import <SpringBoard/SBScreenEdgePanGestureRecognizer.h>
#import <SpringBoard/SBUIController.h>

%hook SBUIController

- (void)_addRemoveSwitcherGesture {
	%orig;

	UIGestureRecognizer *switcherForcePressRecognizer = [self valueForKey:@"_switcherForcePressRecognizer"];

	// if the gesture recognizer doesn’t exist, the device doesn’t have 3d touch
	if (!switcherForcePressRecognizer) {
		SBScreenEdgePanGestureRecognizer *gestureRecognizer = [[%c(SBScreenEdgePanGestureRecognizer) alloc] initWithTarget:self action:@selector(_handleSwitcherForcePressGesture:) type:SBSystemGestureTypeSwitcherForcePress];
		gestureRecognizer.delegate = self;
		gestureRecognizer.edges = UIRectEdgeLeft;
		gestureRecognizer.maximumNumberOfTouches = 1;
		[self setValue:gestureRecognizer forKey:@"_switcherForcePressRecognizer"];

		SBMainDisplaySystemGestureManager *gestureManager = [%c(SBSystemGestureManager) mainDisplayManager];
		[gestureManager addGestureRecognizer:gestureRecognizer withType:SBSystemGestureTypeSwitcherForcePress];
	}
}

- (void)_handleSwitcherForcePressGesture:(UIGestureRecognizer *)gestureRecognizer {
	TBCSWindow *window = [TBCSWindow sharedInstance];
	CGPoint activationPoint = [gestureRecognizer locationInView:[self window]];
	switch (gestureRecognizer.state) {
		case UIGestureRecognizerStateBegan:
			[window startAppSwitcher:activationPoint];
			break;
		case UIGestureRecognizerStateChanged:
			[window updateToPoint:activationPoint];
			break;
		case UIGestureRecognizerStateEnded:
		case UIGestureRecognizerStateCancelled:
		case UIGestureRecognizerStateFailed:
			[window removeFromPoint:activationPoint];
			break;
	}
}

%end

%hook SBMainDisplaySystemGestureManager

- (BOOL)_shouldEnableSystemGestureWithType:(SBSystemGestureType)type {
	// override so the edge pan gesture is enabled even if 3d touch isn’t
	// available
	if (type == SBSystemGestureTypeSwitcherForcePress) {
		return YES;
	}

	return %orig;
}

%end

%hook SBLockScreenViewController
- (void)finishUIUnlockFromSource:(int)arg1 {
	%orig;

	if (![[TBCSPreferencesManager sharedInstance] hadFirstRun]) {
		[[TBCSPreferencesManager sharedInstance] setHadFirstRun:YES];
		[[TBCSWindow sharedInstance] showTutorial];
	}
}
%end

%ctor {
	if (IN_SPRINGBOARD) {
		%init;
	}
}
