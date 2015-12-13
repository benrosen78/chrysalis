@class TBCSDisplayItem;

@interface TBCSAppSwitcherManager : NSObject

+ (NSMutableArray <TBCSDisplayItem *> *)displayItems;
+ (void)quitAllApps;
+ (void)suspend;

@end
