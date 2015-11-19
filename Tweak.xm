%hook SBDeckSwitcherViewController

- (void)viewDidAppear:(_Bool)arg1 {
	HBLogDebug(@"Hey!");
	%orig;
	abort();
}

%end