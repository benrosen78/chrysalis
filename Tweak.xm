#import "CSWindow.h"
#import "TBCSTutorialView.h"
#import <SpringBoard/SBUIController.h>
#import <SpringBoard/SBIconController.h>
#import <SpringBoard/SBIconListView.h>

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

%hook SBLockScreenViewController
- (void)finishUIUnlockFromSource:(int)arg1{
	%orig;

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
		UIWindow *window = [[NSClassFromString(@"SBUIController") sharedInstance] valueForKey:@"_window"];
		UIView *tutorialView = [[TBCSTutorialView alloc] initWithFrame:window.frame];
		[window addSubview:tutorialView];

		SBIconListView *rootIcons = [[%c(SBIconController) sharedInstance] currentRootIconList];
    	SBIconListView *dockIcons = [[%c(SBIconController) sharedInstance] dockListView];
    	SBRootFolderController *rootController = [[%c(SBIconController) sharedInstance] _rootFolderController];

        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationDelay:0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];

        rootIcons.alpha = 0.2;
        dockIcons.alpha = 0.2;
        [rootController.contentView setPageControlHidden:YES];
        [rootController.contentView.dockView setBackgroundAlpha:0.2f];

        [UIView commitAnimations];
    });
}
%end
