//
//  MagicFaceDataHandler.m
//  jsonTest
//
//  Created by 苏洗洗 on 2023/7/29.
//

#import "MagicFaceDataHandler.h"

@implementation MagicFaceDataHandler
//获取魔表详细信息
- (void)fetchJSONFromURL:(NSString *)urlString completionHandler:(void (^)(NSDictionary *json, NSError *error))completionHandler {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {//NSData二进制流
        if (error) {
            completionHandler(nil, error);
            return;
        }
        NSError *jsonError;
        //提供json和系统对象之间的转换
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        completionHandler(json, jsonError);
    }];
    [task resume];//恢复状态，还有两种挂起和取消，默认挂起，调用恢复是开始执行
}



//根据魔表详细信息数组以及解析魔表分组信息，做一个关联，得到groups
- (NSArray<MagicFaceGroup *> *)associateGroupsWithDetails:(NSArray *)resultArray {
    // 创建一个新的数组来保存 MagicFaceGroup 对象
    NSMutableArray<MagicFaceGroup *> *groups = [[NSMutableArray alloc] init];

    // 获取所有分组的魔表信息
    NSURL *groupUrl = [NSURL URLWithString:@"https://mock.corp.kuaishou.com/mock/5321/rest/n/magicFace/union/brief"];
    NSData *groupData = [NSData dataWithContentsOfURL:groupUrl];
    NSDictionary *groupJson = [NSJSONSerialization JSONObjectWithData:groupData options:0 error:nil];
    NSArray *groupDataArray = groupJson[@"data"];

    for (NSDictionary *groupDict in groupDataArray) {
        NSString *groupId = groupDict[@"id"];
        NSString *groupName=groupDict[@"name"];
        NSArray *magicFacesDicts = groupDict[@"magicFaces"];

        NSMutableArray<MagicFace *> *magicFaces = [[NSMutableArray alloc] init];

        for (NSDictionary *magicFaceDict in magicFacesDicts) {
            NSString *magicFaceId = [NSString stringWithFormat:@"%@", magicFaceDict[@"id"]];

            // 在 resultArray 中查找匹配的魔表详细信息
            for (NSDictionary *magicFaceDetail in resultArray) {
                NSString *detailIdString = [NSString stringWithFormat:@"%@", magicFaceDetail[@"id"]];
                if ([detailIdString isEqualToString:magicFaceId]) {
                    // 如果找到匹配的详细信息，创建一个新的 MagicFace 对象并将其添加到 magicFaces 数组中
                    MagicFace *magicFace = [[MagicFace alloc] initWithDictionary:magicFaceDetail];
                    [magicFaces addObject:magicFace];
                    break;
                }
            }
        }

        // 创建一个新的 MagicFaceGroup 对象并将其添加到 groups 数组中
        MagicFaceGroup *group = [[MagicFaceGroup alloc] initWithId:groupId Name:groupName magicFaces:magicFaces];
        [groups addObject:group];
    }
    
    return [groups copy];
}


//根据mul字典，生成groups包含所有魔表分组的魔表详细信息
- (void)handleface:(NSDictionary *)magicFaceDetailDict {
    NSArray *dataDict = magicFaceDetailDict[@"data"];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];

    for (NSDictionary *subDict in dataDict) {
        NSString *idString = subDict[@"id"] ?: @"";
        NSString *nameString = subDict[@"name"] ?: @"";
        NSString *resourceString = subDict[@"resource"] ?: @"";
        NSString *imageString = subDict[@"image"] ?: @"";
        
        NSDictionary *resultDict = @{@"id": idString,
                                     @"name": nameString,
                                     @"resource": resourceString,
                                     @"image": imageString};
        [resultArray addObject:resultDict];
    }
    //resultArray是魔表详细信息
    self.groups = [self associateGroupsWithDetails:resultArray];

}

@end
