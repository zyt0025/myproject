//
//  MagicFaceDataHandler.h
//  jsonTest
//
//  Created by 苏洗洗 on 2023/7/29.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MagicFace.h"
#import "MagicFaceGroup.h"
NS_ASSUME_NONNULL_BEGIN

@interface MagicFaceDataHandler : NSObject
- (NSArray<MagicFaceGroup *> *)associateGroupsWithDetails:(NSArray *)resultArray;//从魔表详细信息数组和分组关联获取魔表分组
- (void)handleface:(NSDictionary *)magicFaceDetailDict ;
@property (nonatomic, copy) NSArray <MagicFaceGroup *> *groups;//所有魔表分组
//- (NSArray<MagicFaceGroup *> *)associateGroupsWithDetails:(NSArray *)resultArray;
- (void)fetchJSONFromURL:(NSString *)urlString completionHandler:(void (^)(NSDictionary *json, NSError *error))completionHandler;
@end

NS_ASSUME_NONNULL_END
