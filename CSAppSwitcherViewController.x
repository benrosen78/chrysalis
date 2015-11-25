#import "CSAppSwitcherViewController.h"

@implementation CSAppSwitcherViewController {
	UIVisualEffectView *_blurEffectView;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
   _blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
   _blurEffectView.frame = self.view.frame;
	[self.view addSubview:_blurEffectView];
}

@end
