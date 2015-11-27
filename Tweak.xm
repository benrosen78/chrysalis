#import "CSWindow.h"
#import <SpringBoard/SBUIController.h>

%hook SBUIController

- (void)_handleSwitcherForcePressGesture:(UIGestureRecognizer *)gestureRecognizer {
	CGPoint activationPoint = [gestureRecognizer locationInView:[self window]];
	if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
		[[CSWindow sharedInstance] startAppSwitcher];
	} else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
		[[CSWindow sharedInstance] updateToPoint:activationPoint];
	} else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled || gestureRecognizer.state == UIGestureRecognizerStateFailed) {
		[[CSWindow sharedInstance] removeFromPoint:activationPoint];
	}
}

%end
