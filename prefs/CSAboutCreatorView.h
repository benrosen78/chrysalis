typedef NS_ENUM(NSInteger, CSAboutCreatorType) {
	CSAboutCreatorTypeDeveloper,
	CSAboutCreatorTypeDesigner
};

@interface CSAboutCreatorView : UIView <UIGestureRecognizerDelegate>

- (instancetype)initWithTwitterUsername:(NSString *)username name:(NSString *)name creatorType:(CSAboutCreatorType)creatorType;

@end
