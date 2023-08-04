//
//  MagicFaceGroup.m
//  jsonTest
//
//  Created by 苏洗洗 on 2023/7/28.
//

#import "MagicFaceGroup.h"

@implementation MagicFaceGroup

- (instancetype)initWithId:(NSString *)id Name:(NSString *)name magicFaces:(NSArray<MagicFace *> *)magicFaces {
    self = [super init];
    if (self) {
        self.id = id;
        self.name=name;
        self.magicFaces = magicFaces;
    }
    return self;
}

@end

