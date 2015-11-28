#import "CSAboutCreatorView.h"

#define URL_ENCODE(string) [(NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)(string), NULL, CFSTR(":/=,!$& '()*+;[]@#?"), kCFStringEncodingUTF8) autorelease]

@implementation CSAboutCreatorView

- (instancetype)initWithTwitterUsername:(NSString *)username name:(NSString *)name creatorType:(CSAboutCreatorType)creatorType {
	if (self = [super init]) {
		UIImageView *avatarImageView = [[UIImageView alloc] init];
		avatarImageView.alpha = 0.0;
		avatarImageView.layer.masksToBounds = YES;
		avatarImageView.layer.cornerRadius = 46.5;
		avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:avatarImageView];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:avatarImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:avatarImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:93]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:avatarImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:93]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:avatarImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];

		UILabel *nameLabel = [[UILabel alloc] init];
		nameLabel.text = name;
		nameLabel.font = [UIFont systemFontOfSize:12.5];
		nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:nameLabel];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:avatarImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:4]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];

		UILabel *creatorTypeLabel = [[UILabel alloc] init];
		creatorTypeLabel.text = creatorType == CSAboutCreatorTypeDeveloper ? @"Developer" : @"Designer";
		creatorTypeLabel.font = [UIFont systemFontOfSize:10.0];
		creatorTypeLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:creatorTypeLabel];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:creatorTypeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:nameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:1.5]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:creatorTypeLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];

		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			NSError *error = nil;
			NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://twitter.com/%@/profile_image?size=original", URL_ENCODE(username)]]] returningResponse:nil error:&error];

			if (error) {
				HBLogError(@"error loading twitter avatar: %@", error);
				return;
			}

			dispatch_async(dispatch_get_main_queue(), ^{
				avatarImageView.image = [UIImage imageWithData:data];

				[UIView animateWithDuration:0.15 animations:^{
					avatarImageView.alpha = 1;
				}];
			});
		});

	}
	return self;
}

@end
