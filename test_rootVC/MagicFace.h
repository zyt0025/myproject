//
//  MagicFace.h
//  jsonTest
//
//  Created by 苏洗洗 on 2023/7/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface MagicFace : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *resource;
@property (nonatomic, strong) NSString *image;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end


NS_ASSUME_NONNULL_END
