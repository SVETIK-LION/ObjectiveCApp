#import "UserDataClass.h"

@implementation UserDataClass

@synthesize hairColor;

+ (BOOL)supportsSecureCoding{
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.hairColor forKey:@"HairColor"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self){
        UIColor *userHairColor = [coder decodeObjectOfClass:[UIColor class] forKey:@"HairColor"];
        return [self initWithHairColor:hairColor];
    }
    return self;
}

- (instancetype)initWithHairColor:(UIColor *) color {
    self = [super init];
    if (self){
        self.hairColor = color;
    }
    return self;
}

@end
