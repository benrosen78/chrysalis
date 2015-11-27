@interface CSLiveConfigurationHeaderView : UIView
@property (nonatomic,assign) UIBlurEffect *blurEffect;
@property (nonatomic,assign) UIVisualEffectView *blurEffectView;
-(void)setHomeScreenIconHidden:(BOOL)hidden;
-(void)setIconLabelsHidden:(BOOL)hidden;
-(void)setKillAllButtonHidden:(BOOL)hidden;
@end
