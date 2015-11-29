#import "CSWindow.h"
#import "TBCSTutorialView.h"
#import <SpringBoard/SBUIController.h>
#import <SpringBoard/SBIconController.h>
#import <SpringBoard/SBIconListView.h>

CSWindow *window;

%hook SBUIController

- (void)_handleSwitcherForcePressGesture:(UIGestureRecognizer *)gestureRecognizer {
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
	}
}

%end

%hook SpringBoard

- (void)applicationDidFinishLaunching:(UIApplication *)arg1 {
	%orig;
	window = [[CSWindow alloc] init];
}

%end

%hook SBLockScreenViewController
- (void)finishUIUnlockFromSource:(int)arg1{
	%orig;

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
		UIWindow *window = [[%c(SBUIController) sharedInstance] valueForKey:@"_window"];
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
