#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDataClass : NSObject <NSCoding, NSSecureCoding>

- (instancetype)initWithHairColor:(UIColor*) color;

@property(nonatomic) UIColor *hairColor;

@end

NS_ASSUME_NONNULL_END
