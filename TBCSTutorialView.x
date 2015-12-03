#import "TBCSTutorialView.h"
#import <SpringBoard/SBDockIconListView.h>
#import <SpringBoard/SBDockView.h>
#import <SpringBoard/SBIconController.h>
#import <SpringBoard/SBRootFolderView.h>
#import <SpringBoard/SBRootFolderController.h>
#import <SpringBoard/SBRootIconListView.h>
#import <CoreText/CoreText.h>
#import "TBCSAppSwitcherViewController.h"

@implementation TBCSTutorialView

#pragma mark TBCSTutorialView

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
        [self loadInFonts];
        [self addTutorial];

		// Add a light tint to create some seperation for the text
		self.backgroundColor = [UIColor colorWithRed:2.0f/255.0f green:2.0f/255.0f blue:2.0f/255.0f alpha:0.3];
	}
	return self;
}

#pragma mark touches

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self removeTutorial];
}

#pragma mark animations

- (void)addTutorial {
    SBIconListView *rootIcons = [[%c(SBIconController) sharedInstance] currentRootIconList];
    SBIconListView *dockIcons = [[%c(SBIconController) sharedInstance] dockListView];
    SBRootFolderController *rootController = [[%c(SBIconController) sharedInstance] _rootFolderController];

    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        rootIcons.alpha = 0.2;
        dockIcons.alpha = 0.2;
        [rootController.contentView setPageControlHidden:YES];
        [rootController.contentView.dockView setBackgroundAlpha:0.2f];
    } completion:nil];

    UILabel *headerLabel = [[[UILabel alloc] init] autorelease];
    headerLabel.font = [UIFont fontWithName:@"NexaLight" size:36];
    headerLabel.text = @"CHRYSALIS";
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:headerLabel];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:headerLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:0.1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:headerLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];

    UILabel *pronunciationLabel = [[[UILabel alloc] init] autorelease];
    pronunciationLabel.font = [UIFont fontWithName:@"NexaLight" size:15];
    pronunciationLabel.text = @"kriss·uh·lis";
    pronunciationLabel.textColor = [UIColor whiteColor];
    pronunciationLabel.textAlignment = NSTextAlignmentCenter;
    pronunciationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:pronunciationLabel];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:pronunciationLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:headerLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:pronunciationLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];

    UILabel *shortDescriptionLabel = [[[UILabel alloc] init] autorelease];
    shortDescriptionLabel.numberOfLines = 0;
    shortDescriptionLabel.font = [UIFont fontWithName:@"NexaLight" size:18];
    shortDescriptionLabel.text = [NSString stringWithFormat:@"a minimalist app switcher for your %@", [UIDevice currentDevice].localizedModel];
    shortDescriptionLabel.textColor = [UIColor whiteColor];
    shortDescriptionLabel.textAlignment = NSTextAlignmentCenter;
    shortDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:shortDescriptionLabel];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:shortDescriptionLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:pronunciationLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:2]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:shortDescriptionLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];

    UILabel *tutorialLabel1 = [[[UILabel alloc] init] autorelease];
    tutorialLabel1.numberOfLines = 0;
    tutorialLabel1.font = [UIFont fontWithName:@"billy" size:36];
    tutorialLabel1.text = @"  -  force touch/hold \n     on the left/right side\n     of the screen to reveal the app icons.";
    tutorialLabel1.textColor = [UIColor whiteColor];
    tutorialLabel1.textAlignment = NSTextAlignmentLeft;
    tutorialLabel1.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:tutorialLabel1];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:tutorialLabel1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:shortDescriptionLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:25]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:tutorialLabel1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:0.2 constant:0]];

    UILabel *tutorialLabel2 = [[[UILabel alloc] init] autorelease];
    tutorialLabel2.numberOfLines = 0;
    tutorialLabel2.font = [UIFont fontWithName:@"billy" size:36];
    tutorialLabel2.text = @"  -  continuing to slide on the \n     app switcher zone without\n     releasing to select an app";
    tutorialLabel2.textColor = [UIColor whiteColor];
    tutorialLabel2.textAlignment = NSTextAlignmentLeft;
    tutorialLabel2.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:tutorialLabel2];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:tutorialLabel2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:tutorialLabel1 attribute:NSLayoutAttributeBottom multiplier:1 constant:15]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:tutorialLabel2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:0.2 constant:0]];

    UILabel *tutorialLabel3 = [[[UILabel alloc] init] autorelease];
    tutorialLabel3.numberOfLines = 0;
    tutorialLabel3.font = [UIFont fontWithName:@"billy" size:36];
    tutorialLabel3.text = @"  -  slide to the × button to \n     close all apps";
    tutorialLabel3.textColor = [UIColor whiteColor];
    tutorialLabel3.textAlignment = NSTextAlignmentLeft;
    tutorialLabel3.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:tutorialLabel3];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:tutorialLabel3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:tutorialLabel2 attribute:NSLayoutAttributeBottom multiplier:1 constant:15]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:tutorialLabel3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:0.2 constant:0]];

    UIView *constraintedViewForAppSwitcher = [[[UIView alloc] init] autorelease];
    constraintedViewForAppSwitcher.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:constraintedViewForAppSwitcher];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:constraintedViewForAppSwitcher attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:tutorialLabel3 attribute:NSLayoutAttributeBottom multiplier:1 constant:35]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:constraintedViewForAppSwitcher attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:constraintedViewForAppSwitcher attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:constraintedViewForAppSwitcher attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:constraintedViewForAppSwitcher attribute:NSLayoutAttributeTop multiplier:1 constant:95]];

    TBCSAppSwitcherViewController *liveAppSwitcherView = [[[%c(TBCSAppSwitcherViewController) alloc] init] autorelease];
    liveAppSwitcherView.useDemoApps = YES;
    liveAppSwitcherView.view.userInteractionEnabled = NO;
    liveAppSwitcherView.view.frame = CGRectMake(0, 0, self.frame.size.width, 95);
    [constraintedViewForAppSwitcher addSubview:liveAppSwitcherView.view];

    UILabel *appSwitcherZoneLabel = [[[UILabel alloc] init] autorelease];
    appSwitcherZoneLabel.font = [UIFont fontWithName:@"billy" size:35];
    appSwitcherZoneLabel.text = @"! --- switcher zone --- !";
    appSwitcherZoneLabel.textAlignment = NSTextAlignmentCenter;
    appSwitcherZoneLabel.textColor = [UIColor whiteColor];
    appSwitcherZoneLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:appSwitcherZoneLabel];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:appSwitcherZoneLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:constraintedViewForAppSwitcher attribute:NSLayoutAttributeBottom multiplier:1 constant:15]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:appSwitcherZoneLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:36]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:appSwitcherZoneLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-46]];
}

- (void)removeTutorial {
	[self removeFromSuperview];
	[self release];

    SBRootIconListView *rootIcons = [[%c(SBIconController) sharedInstance] currentRootIconList];
    SBDockIconListView *dockIcons = [[%c(SBIconController) sharedInstance] dockListView];
    SBRootFolderController *rootController = [[%c(SBIconController) sharedInstance] _rootFolderController];

    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        rootIcons.alpha = 1.0;
        dockIcons.alpha = 1.0;
        [rootController.contentView setPageControlHidden:NO];
        [rootController.contentView.dockView setBackgroundAlpha:1.0f];
    } completion:nil];
}

#pragma mark fonts

- (void)loadInFonts {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *fonts = @[ @"Billy.ttf", @"Nexa.otf" ];
        NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/ChrysalisPrefs.bundle"];

        for (NSString *font in fonts) {
            NSURL *url = [bundle URLForResource:font.stringByDeletingPathExtension withExtension:font.pathExtension subdirectory:@"fonts"];

            CGDataProviderRef dataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)url);
            CGFontRef font = CGFontCreateWithDataProvider(dataProvider);
            CGDataProviderRelease(dataProvider);
            CTFontManagerRegisterGraphicsFont(font, nil);
            CGFontRelease(font);
        }
    });
}

@end
