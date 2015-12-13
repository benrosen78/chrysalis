@class SBDisplayItem;

@interface TBCSDisplayItem : NSObject

+ (instancetype)displayItemWithSBDisplayItem:(SBDisplayItem *)displayItem;
+ (instancetype)displayItemWithType:(NSString *)type displayIdentifier:(NSString *)displayIdentifier;
+ (instancetype)homeScreenDisplayItem;

- (instancetype)initWithType:(NSString *)type displayIdentifier:(NSString *)displayIdentifier;

- (SBDisplayItem *)sbDisplayItem;

@property (readonly, copy, nonatomic) NSString *displayIdentifier;
@property (readonly, copy, nonatomic) NSString *type;

@end
