#include "TBCSRootListController.h"
#import <UIKit/UIImage+Private.h>
#import <MobileGestalt/MobileGestalt.h>

@implementation TBCSRootListController

+ (NSString *)hb_specifierPlist {
	return @"Root";
}

+ (NSString *)hb_shareText {
	return @"I'm using Chrysalis to beautifully switch between apps. Download today from BigBoss! @benr9500 @cpdigdarkroom @hbkirb @veerklempt";
}

+ (NSString *)hb_shareURL {
	return @"http://tweakbattles.com/";
}

+ (UIColor *)hb_tintColor {
	return [UIColor colorWithRed:0.169f green:0.796f blue:0.518f alpha:1.00f];
}

+ (UIColor *)hb_navigationBarTintColor {
	return [UIColor colorWithRed:0.424f green:0.424f blue:0.431f alpha:1.00f];
}

+ (BOOL)hb_invertedNavigationBar {
	return YES;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	UIImage *headerLogo = [[UIImage imageNamed:@"headerLogo" inBundle:[NSBundle bundleForClass:self.class]] _flatImageWithColor:[UIColor whiteColor]];
	self.navigationItem.titleView = [[[UIImageView alloc] initWithImage:headerLogo] autorelease];
	self.navigationItem.titleView.alpha = 0.0;

	[self performSelector:@selector(animateIconAlpha) withObject:nil afterDelay:0.5];
}

- (void)animateIconAlpha {
	[UIView animateWithDuration:0.5 animations:^{
		self.navigationItem.titleView.alpha = 1;
	} completion:nil];
}

- (void)showSupportEmailController {
    MFMailComposeViewController *emailController = [[MFMailComposeViewController alloc] init];
    emailController.subject = @"Chrysalis Support";
    emailController.toRecipients = @[@"HASHBANG Productions Support <support@hbang.ws>"];

    NSString *product = (NSString *)MGCopyAnswer(kMGProductType);
    NSString *version = (NSString *)MGCopyAnswer(kMGProductVersion);
    NSString *build = (NSString *)MGCopyAnswer(kMGBuildVersion);

    [emailController setMessageBody:[NSString stringWithFormat:@"\n\nCurrent Device: %@, iOS %@ (%@)", product, version, build] isHTML:NO];

    system("/usr/bin/dpkg -l >/tmp/dpkgl.log");
    [emailController addAttachmentData:[NSData dataWithContentsOfFile:@"/tmp/dpkgl.log"] mimeType:@"text/plain" fileName:@"dpkgl.txt"];
    [self.navigationController presentViewController:emailController animated:YES completion:nil];
    emailController.mailComposeDelegate = self;
    [emailController release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end
