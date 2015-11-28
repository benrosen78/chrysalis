typedef NS_ENUM(NSInteger, CSAboutCreatorType) {
	CSAboutCreatorTypeDeveloper,
	CSAboutCreatorTypeDesigner
};

@interface CSAboutCreatorView : UIView

- (instancetype)initWithTwitterUsername:(NSString *)username name:(NSString *)name creatorType:(CSAboutCreatorType)creatorType;

@end
