#import "CSWindow.h"

@interface SBUIController

- (id)window;

@end

%hook SBUIController

- (void)_handleSwitcherForcePressGesture:(UIGestureRecognizer *)gestureRecognizer {
	CGPoint activationPoint = [gestureRecognizer locationInView:[self window]];
	HBLogDebug(@"This tweak");

	[[CSWindow sharedInstance] updateToPoint:activationPoint];
}

%end
