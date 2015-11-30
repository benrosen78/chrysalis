#import "TBCSTutorialView.h"
#import <SpringBoard/SBIconController.h>
#import <SpringBoard/SBIconListView.h>
#import <CoreText/CoreText.h>
#import "CSAppSwitcherViewController.h"

@implementation TBCSTutorialView

#pragma mark TBCSTutorialView

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
        [self loadInFonts];
        [self handleAddingTutorialView];

		// Add a light tint to create some seperation for the text
		self.backgroundColor = [UIColor colorWithRed:2.0f/255.0f green:2.0f/255.0f blue:2.0f/255.0f alpha:0.3];

		UILabel *headerLabel = [[UILabel alloc] init];
        headerLabel.numberOfLines = 1;
        headerLabel.font = [UIFont fontWithName:@"NexaLight" size:36];
        headerLabel.text = @"CHRYSALIS";
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.textAlignment = NSTextAlignmentCenter;
        headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:headerLabel];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:headerLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:0.1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:headerLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];

        UILabel *pronunciationLabel = [[UILabel alloc] init];
        pronunciationLabel.font = [UIFont fontWithName:@"NexaLight" size:18];
        pronunciationLabel.text = @"kriss·uh·lis";
        pronunciationLabel.textColor = [UIColor whiteColor];
        pronunciationLabel.textAlignment = NSTextAlignmentCenter;
        pronunciationLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:pronunciationLabel];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:pronunciationLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:headerLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:2]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:pronunciationLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];

        UILabel *shortDescriptionLabel = [[UILabel alloc] init];
        shortDescriptionLabel.font = [UIFont fontWithName:@"NexaLight" size:18];
        shortDescriptionLabel.text = @"a minimalist appswitcher for your iPhone";
        shortDescriptionLabel.textColor = [UIColor whiteColor];
        shortDescriptionLabel.textAlignment = NSTextAlignmentCenter;
        shortDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:shortDescriptionLabel];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:shortDescriptionLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:pronunciationLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:2]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:shortDescriptionLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];

        UILabel *tutorialLabel1 = [[UILabel alloc] init];
        tutorialLabel1.numberOfLines = 3;
        tutorialLabel1.font = [UIFont fontWithName:@"billy" size:36];
        tutorialLabel1.text = @"  -  force touch/hold \n     on the left/right side\n     of the screen to reveal the app icons.";
        tutorialLabel1.textColor = [UIColor whiteColor];
        tutorialLabel1.textAlignment = NSTextAlignmentLeft;
        tutorialLabel1.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:tutorialLabel1];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:tutorialLabel1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:shortDescriptionLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:25]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:tutorialLabel1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:0.2 constant:0]];

        UILabel *tutorialLabel2 = [[UILabel alloc] init];
        tutorialLabel2.numberOfLines = 3;
        tutorialLabel2.font = [UIFont fontWithName:@"billy" size:36];
        tutorialLabel2.text = @"  -  continuing to slide on the \n     appswitcher zone without\n     releasing to select an app";
        tutorialLabel2.textColor = [UIColor whiteColor];
        tutorialLabel2.textAlignment = NSTextAlignmentLeft;
        tutorialLabel2.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:tutorialLabel2];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:tutorialLabel2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:tutorialLabel1 attribute:NSLayoutAttributeBottom multiplier:1 constant:15]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:tutorialLabel2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:0.2 constant:0]];

        UILabel *tutorialLabel3 = [[UILabel alloc] init];
        tutorialLabel3.numberOfLines = 2;
        tutorialLabel3.font = [UIFont fontWithName:@"billy" size:36];
        tutorialLabel3.text = @"  -  slide to the x button to \n     close all apps";
        tutorialLabel3.textColor = [UIColor whiteColor];
        tutorialLabel3.textAlignment = NSTextAlignmentLeft;
        tutorialLabel3.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:tutorialLabel3];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:tutorialLabel3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:tutorialLabel2 attribute:NSLayoutAttributeBottom multiplier:1 constant:15]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:tutorialLabel3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:0.2 constant:0]];
	}

	return self;
}

#pragma mark touches

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleRemovingTutorialView];
}

#pragma mark animations

- (void)handleAddingTutorialView {
    SBIconListView *rootIcons = [[%c(SBIconController) sharedInstance] currentRootIconList];
    SBIconListView *dockIcons = [[%c(SBIconController) sharedInstance] dockListView];
    SBRootFolderController *rootController = [[%c(SBIconController) sharedInstance] _rootFolderController];

    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        rootIcons.alpha = 0.2;
        dockIcons.alpha = 0.2;
        [rootController.contentView setPageControlHidden:YES];
        [rootController.contentView.dockView setBackgroundAlpha:0.2f];
    } completion:nil];
}

- (void)handleRemovingTutorialView {
	[self removeFromSuperview];
	[self release];

    SBIconListView *rootIcons = [[%c(SBIconController) sharedInstance] currentRootIconList];
    SBIconListView *dockIcons = [[%c(SBIconController) sharedInstance] dockListView];
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
    NSString *billyFontPath = @"/Library/PreferenceBundles/ChrysalisPrefs.bundle/fonts/Billy.ttf";
    NSURL *billyUrl = [NSURL fileURLWithPath:billyFontPath];
    CGDataProviderRef billyFontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)billyUrl);
    CGFontRef billyFont = CGFontCreateWithDataProvider(billyFontDataProvider);
    CGDataProviderRelease(billyFontDataProvider);
    CTFontManagerRegisterGraphicsFont(billyFont, nil);
    CGFontRelease(billyFont);

    NSString *nexaFontPath = @"/Library/PreferenceBundles/ChrysalisPrefs.bundle/fonts/Nexa.otf";
    NSURL *nexaUrl = [NSURL fileURLWithPath:nexaFontPath];
    CGDataProviderRef nexaFontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)nexaUrl);
    CGFontRef nexaFont = CGFontCreateWithDataProvider(nexaFontDataProvider);
    CGDataProviderRelease(nexaFontDataProvider);
    CTFontManagerRegisterGraphicsFont(nexaFont, nil);
    CGFontRelease(nexaFont);
}

@end
