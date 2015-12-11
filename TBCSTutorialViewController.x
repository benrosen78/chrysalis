#import "TBCSTutorialViewController.h"
#import "TBCSAppSwitcherViewController.h"
#import <SpringBoard/SBDockIconListView.h>
#import <SpringBoard/SBDockView.h>
#import <SpringBoard/SBIconController.h>
#import <SpringBoard/SBRootFolderView.h>
#import <SpringBoard/SBRootFolderController.h>
#import <SpringBoard/SBRootIconListView.h>
#import <UIKit/UIDevice+Private.h>

@import CoreText;

@implementation TBCSTutorialViewController {
    UIView *_containerView;
}

#pragma mark - UIViewController

- (void)loadView {
	[super loadView];

    [self loadInFonts];

	// Add a light tint to create some seperation for the text
	self.view.backgroundColor = [UIColor colorWithWhite:2.0f/255.0f alpha:0.3];

    UIView *containerView = [[[UIView alloc] init] autorelease];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:containerView];

    UILabel *headerLabel = [[[UILabel alloc] init] autorelease];
    headerLabel.font = [UIFont fontWithName:@"NexaLight" size:36];
    headerLabel.text = @"CHRYSALIS";
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:headerLabel];

    UILabel *pronunciationLabel = [[[UILabel alloc] init] autorelease];
    pronunciationLabel.font = [UIFont fontWithName:@"NexaLight" size:15];
    pronunciationLabel.text = @"kriss·uh·lis";
    pronunciationLabel.textColor = [UIColor whiteColor];
    pronunciationLabel.textAlignment = NSTextAlignmentCenter;
    pronunciationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:pronunciationLabel];

    UILabel *shortDescriptionLabel = [[[UILabel alloc] init] autorelease];
    shortDescriptionLabel.numberOfLines = 0;
    shortDescriptionLabel.font = [UIFont fontWithName:@"NexaLight" size:18];
    shortDescriptionLabel.text = [NSString stringWithFormat:@"a minimalist app switcher for your %@", [UIDevice currentDevice].localizedModel];
    shortDescriptionLabel.textColor = [UIColor whiteColor];
    shortDescriptionLabel.textAlignment = NSTextAlignmentCenter;
    shortDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:shortDescriptionLabel];

    UILabel *detailLabel = [[[UILabel alloc] init] autorelease];
    detailLabel.numberOfLines = 0;
    detailLabel.font = [UIFont fontWithName:@"billy" size:36];
    detailLabel.text =
        [NSString stringWithFormat:@"%@\n\n%@\n\n%@", [UIDevice currentDevice]._supportsForceTouch
            ? @"force touch/hold on the left side of the screen to reveal the app icons."
            : @"swipe from the left side of the screen to reveal the app icons.",
            @"continuing to slide on the app switcher zone without releasing to select an app",
            @"slide to the × button to close all apps"];
    detailLabel.textColor = [UIColor whiteColor];
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:detailLabel];

    UIView *switcherContainerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, 95)] autorelease];
    switcherContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:switcherContainerView];

    TBCSAppSwitcherViewController *switcherViewController = [[[%c(TBCSAppSwitcherViewController) alloc] init] autorelease];
    switcherViewController.useDemoApps = YES;
    switcherViewController.view.userInteractionEnabled = NO;
    switcherViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:switcherViewController];
    [switcherContainerView addSubview:switcherViewController.view];
    [switcherViewController didMoveToParentViewController:self];
    [switcherViewController viewWillAppear:NO];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];

    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:headerLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeLeading multiplier:1 constant:15]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:headerLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-15]];

    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:pronunciationLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:headerLabel attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:pronunciationLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:headerLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];

    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:shortDescriptionLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:headerLabel attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:shortDescriptionLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:headerLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];

    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:detailLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:headerLabel attribute:NSLayoutAttributeLeading multiplier:1 constant:10]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:detailLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:headerLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:-10]];

    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:switcherContainerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [containerView addConstraint:[NSLayoutConstraint constraintWithItem:switcherContainerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];

    [switcherContainerView addConstraint:[NSLayoutConstraint constraintWithItem:switcherViewController.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:switcherContainerView attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [switcherContainerView addConstraint:[NSLayoutConstraint constraintWithItem:switcherViewController.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:switcherContainerView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    [switcherContainerView addConstraint:[NSLayoutConstraint constraintWithItem:switcherViewController.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:switcherContainerView attribute:NSLayoutAttributeHeight multiplier:1 constant:95]];

    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-55-[headerLabel][pronunciationLabel]-4-[shortDescriptionLabel]-35-[detailLabel]-35-[switcherContainerView(==95)]|" options:kNilOptions metrics:nil views:@{
        @"headerLabel": headerLabel,
        @"pronunciationLabel": pronunciationLabel,
        @"shortDescriptionLabel": shortDescriptionLabel,
        @"detailLabel": detailLabel,
        @"switcherContainerView": switcherContainerView
    }]];
}

#pragma mark - Show/Hide

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    SBIconListView *rootIcons = [[%c(SBIconController) sharedInstance] currentRootIconList];
    SBIconListView *dockIcons = [[%c(SBIconController) sharedInstance] dockListView];
    SBRootFolderController *rootController = [[%c(SBIconController) sharedInstance] _rootFolderController];

    self.view.alpha = 0;

    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.view.alpha = 1;

        rootIcons.alpha = 0.2;
        dockIcons.alpha = 0.2;
        [rootController.contentView setPageControlHidden:YES];
        [rootController.contentView.dockView setBackgroundAlpha:0.2f];
    } completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    SBRootIconListView *rootIcons = [[%c(SBIconController) sharedInstance] currentRootIconList];
    SBDockIconListView *dockIcons = [[%c(SBIconController) sharedInstance] dockListView];
    SBRootFolderController *rootController = [[%c(SBIconController) sharedInstance] _rootFolderController];

    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.view.alpha = 0;

        rootIcons.alpha = 1.0;
        dockIcons.alpha = 1.0;
        [rootController.contentView setPageControlHidden:NO];
        [rootController.contentView.dockView setBackgroundAlpha:1.0f];
    } completion:nil];
}

#pragma mark - Fonts

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
