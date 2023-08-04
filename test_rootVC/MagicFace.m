//
//  MagicFace.m
//  jsonTest
//
//  Created by 苏洗洗 on 2023/7/28.
//

#import "MagicFace.h"

@implementation MagicFace

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.id = dict[@"id"];
        self.name = dict[@"name"];
        self.resource = dict[@"resource"];
        self.image = dict[@"image"];
    }
    return self;
}

@end

