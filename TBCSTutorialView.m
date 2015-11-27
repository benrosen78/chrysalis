#import "TBCSTutorialView.h"
#import <SpringBoard/SBIconController.h>
#import <SpringBoard/SBIconListView.h>

@implementation TBCSTutorialView
- (id)initWithFrame:(CGRect)frame {

	self = [super initWithFrame:frame];

	if(self) {

		// Add a light tint to create some seperation for the text
		self.backgroundColor = [UIColor colorWithRed:2.0f/255.0f green:2.0f/255.0f blue:2.0f/255.0f alpha:0.3];

		self.headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.headerLabel setNumberOfLines:1];
        [self.headerLabel setFont:[UIFont systemFontOfSize:36]];
        [self.headerLabel setText:@"CHRYSALIS"];
        [self.headerLabel setBackgroundColor:[UIColor clearColor]];
        [self.headerLabel setTextColor:[UIColor whiteColor]];
        [self.headerLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.headerLabel];
        [self.headerLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:0.1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];

        self.pronunciationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.pronunciationLabel setNumberOfLines:1];
        [self.pronunciationLabel setFont:[UIFont systemFontOfSize:18]];
        [self.pronunciationLabel setText:@"kriss·uh·lis"];
        [self.pronunciationLabel setBackgroundColor:[UIColor clearColor]];
        [self.pronunciationLabel setTextColor:[UIColor whiteColor]];
        [self.pronunciationLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.pronunciationLabel];
        [self.pronunciationLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pronunciationLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:2]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pronunciationLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];

        self.shortDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.shortDescriptionLabel setNumberOfLines:1];
        [self.shortDescriptionLabel setFont:[UIFont systemFontOfSize:18]];
        [self.shortDescriptionLabel setText:@"a minimalist appswitcher for your iPhone"];
        [self.shortDescriptionLabel setBackgroundColor:[UIColor clearColor]];
        [self.shortDescriptionLabel setTextColor:[UIColor whiteColor]];
        [self.shortDescriptionLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.shortDescriptionLabel];
        [self.shortDescriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.shortDescriptionLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.pronunciationLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:2]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.shortDescriptionLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];

        self.tutorialLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.tutorialLabel1 setNumberOfLines:3];
        [self.tutorialLabel1 setFont:[UIFont systemFontOfSize:18]];
        [self.tutorialLabel1 setText:@"  -  force touch/hold \n     on the left/right side\n     of the screen to reveal the app icons."];
        [self.tutorialLabel1 setBackgroundColor:[UIColor clearColor]];
        [self.tutorialLabel1 setTextColor:[UIColor whiteColor]];
        [self.tutorialLabel1 setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.tutorialLabel1];
        [self.tutorialLabel1 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tutorialLabel1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.shortDescriptionLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:25]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tutorialLabel1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:0.2 constant:0]];

        self.tutorialLabel2 = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.tutorialLabel2 setNumberOfLines:3];
        [self.tutorialLabel2 setFont:[UIFont systemFontOfSize:18]];
        [self.tutorialLabel2 setText:@"  -  continuing to slide on the \n     appswitcher zone without\n     releasing to select an app"];
        [self.tutorialLabel2 setBackgroundColor:[UIColor clearColor]];
        [self.tutorialLabel2 setTextColor:[UIColor whiteColor]];
        [self.tutorialLabel2 setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.tutorialLabel2];
        [self.tutorialLabel2 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tutorialLabel2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tutorialLabel1 attribute:NSLayoutAttributeBottom multiplier:1 constant:15]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tutorialLabel2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:0.2 constant:0]];

        self.tutorialLabel3 = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.tutorialLabel3 setNumberOfLines:2];
        [self.tutorialLabel3 setFont:[UIFont systemFontOfSize:18]];
        [self.tutorialLabel3 setText:@"  -  slide to the x button to \n     close all apps"];
        [self.tutorialLabel3 setBackgroundColor:[UIColor clearColor]];
        [self.tutorialLabel3 setTextColor:[UIColor whiteColor]];
        [self.tutorialLabel3 setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.tutorialLabel3];
        [self.tutorialLabel3 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tutorialLabel3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tutorialLabel2 attribute:NSLayoutAttributeBottom multiplier:1 constant:15]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tutorialLabel3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:0.2 constant:0]];
	}

	return self;
}
- (void)handleRemovingTutorialView
{
	[self removeFromSuperview];
	[self release];

	SBIconListView *rootIcons = [[NSClassFromString (@"SBIconController") sharedInstance] currentRootIconList];
    SBIconListView *dockIcons = [[NSClassFromString (@"SBIconController") sharedInstance] dockListView];
    SBRootFolderController *rootController = [[NSClassFromString (@"SBIconController") sharedInstance] _rootFolderController];

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];

    rootIcons.alpha = 1.0;
    dockIcons.alpha = 1.0;
    [rootController.contentView setPageControlHidden:NO];
    [rootController.contentView.dockView setBackgroundAlpha:1.0f];

    [UIView commitAnimations];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self handleRemovingTutorialView];
}
@end
