#import "CSWindow.h"

@interface SBUIController

- (id)window;

@end

%hook SBUIController

- (void)_handleSwitcherForcePressGesture:(UIGestureRecognizer *)gestureRecognizer {
	if (gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == UIGestureRecognizerStateChanged) {
		CGPoint activationPoint = [gestureRecognizer locationInView:[self window]];
		[[CSWindow sharedInstance] updateToPoint:activationPoint];
	} else {
		[[CSWindow sharedInstance] removeAppSwitcher];
	}
}

%end
