//
//  MagicFaceGroup.h
//  jsonTest
//
//  Created by 苏洗洗 on 2023/7/28.
//

#import <Foundation/Foundation.h>
#import "MagicFace.h"

@interface MagicFaceGroup : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray<MagicFace *> *magicFaces;

- (instancetype)initWithId:(NSString *)id Name:(NSString *)name magicFaces:(NSArray<MagicFace *> *)magicFaces;

@end

