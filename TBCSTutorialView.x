#import "TBCSTutorialView.h"
#import <SpringBoard/SBIconController.h>
#import <SpringBoard/SBIconListView.h>

@implementation TBCSTutorialView {
    UILabel *_headerLabel;
    UILabel *_pronunciationLabel;
    UILabel *_shortDescriptionLabel;
    UILabel *_tutorialLabel1;
    UILabel *_tutorialLabel2;
    UILabel *_tutorialLabel3;
}

#pragma mark TBCSTutorialView

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
        [self handleAddingTutorialView];

		// Add a light tint to create some seperation for the text
		self.backgroundColor = [UIColor colorWithRed:2.0f/255.0f green:2.0f/255.0f blue:2.0f/255.0f alpha:0.3];

		_headerLabel = [[UILabel alloc] init];
        _headerLabel.numberOfLines = 1;
        _headerLabel.font = [UIFont systemFontOfSize:36];
        _headerLabel.text = @"CHRYSALIS";
        _headerLabel.textColor = [UIColor whiteColor];
        _headerLabel.textAlignment = NSTextAlignmentCenter;
        _headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_headerLabel];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_headerLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:0.1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_headerLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];

        _pronunciationLabel = [[UILabel alloc] init];
        _pronunciationLabel.font = [UIFont systemFontOfSize:18];
        _pronunciationLabel.text = @"kriss·uh·lis";
        _pronunciationLabel.textColor = [UIColor whiteColor];
        _pronunciationLabel.textAlignment = NSTextAlignmentCenter;
        _pronunciationLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_pronunciationLabel];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_pronunciationLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_headerLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:2]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_pronunciationLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];

        _shortDescriptionLabel = [[UILabel alloc] init];
        _shortDescriptionLabel.font = [UIFont systemFontOfSize:18];
        _shortDescriptionLabel.text = @"a minimalist appswitcher for your iPhone";
        _shortDescriptionLabel.textColor = [UIColor whiteColor];
        _shortDescriptionLabel.textAlignment = NSTextAlignmentCenter;
        _shortDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_shortDescriptionLabel];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_shortDescriptionLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_pronunciationLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:2]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_shortDescriptionLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];

        _tutorialLabel1 = [[UILabel alloc] init];
        _tutorialLabel1.numberOfLines = 3;
        _tutorialLabel1.font = [UIFont systemFontOfSize:18];
        _tutorialLabel1.text = @"  -  force touch/hold \n     on the left/right side\n     of the screen to reveal the app icons.";
        _tutorialLabel1.textColor = [UIColor whiteColor];
        _tutorialLabel1.textAlignment = NSTextAlignmentLeft;
        _tutorialLabel1.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_tutorialLabel1];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_tutorialLabel1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_shortDescriptionLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:25]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_tutorialLabel1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:0.2 constant:0]];

        _tutorialLabel2 = [[UILabel alloc] init];
        _tutorialLabel2.numberOfLines = 3;
        _tutorialLabel2.font = [UIFont systemFontOfSize:18];
        _tutorialLabel2.text = @"  -  continuing to slide on the \n     appswitcher zone without\n     releasing to select an app";
        _tutorialLabel2.textColor = [UIColor whiteColor];
        _tutorialLabel2.textAlignment = NSTextAlignmentLeft;
        _tutorialLabel2.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_tutorialLabel2];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_tutorialLabel2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_tutorialLabel1 attribute:NSLayoutAttributeBottom multiplier:1 constant:15]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_tutorialLabel2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:0.2 constant:0]];

        _tutorialLabel3 = [[UILabel alloc] init];
        _tutorialLabel3.numberOfLines = 2;
        _tutorialLabel3.font = [UIFont systemFontOfSize:18];
        _tutorialLabel3.text = @"  -  slide to the x button to \n     close all apps";
        _tutorialLabel3.textColor = [UIColor whiteColor];
        _tutorialLabel3.textAlignment = NSTextAlignmentLeft;
        _tutorialLabel3.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_tutorialLabel3];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_tutorialLabel3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_tutorialLabel2 attribute:NSLayoutAttributeBottom multiplier:1 constant:15]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_tutorialLabel3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:0.2 constant:0]];
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

@end
