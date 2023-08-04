//
//  MagicFaceCell.h
//  jsonTest
//
//  Created by 苏洗洗 on 2023/7/29.
//
#import <SDWebImage/UIImageView+WebCache.h>


#import <UIKit/UIKit.h>
#import "MagicFace.h"
#import "MagicFaceGroup.h"
NS_ASSUME_NONNULL_BEGIN

@interface MagicFaceCell : UICollectionViewCell< UICollectionViewDelegate,UICollectionViewDataSource >

@property (nonatomic, strong) MagicFace *magicFace;
// 更多属性...

@end

NS_ASSUME_NONNULL_END
