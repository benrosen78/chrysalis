NSBundle *bundle;

%ctor {
	bundle = [[NSBundle bundleWithPath:@"/Library/PreferenceBundles/ChrysalisPrefs.bundle"] retain];
}
