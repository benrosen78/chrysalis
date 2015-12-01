typedef NS_ENUM(NSInteger, TBCSAboutCreatorType) {
	TBCSAboutCreatorTypeDeveloper,
	TBCSAboutCreatorTypeDesigner
};

@interface TBCSAboutCreatorView : UIView <UIGestureRecognizerDelegate>

- (instancetype)initWithTwitterUsername:(NSString *)username name:(NSString *)name creatorType:(TBCSAboutCreatorType)creatorType;

@end
