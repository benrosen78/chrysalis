#import "CSWindow.h"

@interface SBUIController

- (id)window;

@end

%hook SBUIController

- (void)_handleSwitcherForcePressGesture:(UIGestureRecognizer *)gestureRecognizer {
	CGPoint activationPoint = [gestureRecognizer locationInView:[self window]];
	[[CSWindow sharedInstance] updateToPoint:activationPoint];
}

%end
