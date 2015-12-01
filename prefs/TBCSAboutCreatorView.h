typedef NS_ENUM(NSInteger, TBCSAboutCreatorType) {
	TBCSAboutCreatorTypeDeveloper,
	TBCSAboutCreatorTypeDesigner
};

@interface TBCSAboutCreatorView : UIButton

+ (instancetype)buttonWithTwitterUsername:(NSString *)username name:(NSString *)name creatorType:(TBCSAboutCreatorType)creatorType;

@end
