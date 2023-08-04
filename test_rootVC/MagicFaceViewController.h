//
//  MagicFaceViewController.h
//  jsonTest
//
//  Created by 苏洗洗 on 2023/7/25.
//

#import <UIKit/UIKit.h>
#import "MagicFaceGroup.h"
#import "MagicFaceDataHandler.h"
#import "MagicFaceCell.h"
//#import "MagicFaceCollectionView.h"
//#import "MagicFaceCollectionViewController.h"
#import "CustomCollectionViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface MagicFaceViewController : UIViewController
//- (NSArray<MagicFaceGroup *> *)associateGroupsWithDetails:(NSArray *)resultArray;
@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic) BOOL isPageViewVisible;
@property (nonatomic, assign) BOOL isFetching;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray<CustomCollectionViewController *> *collectionViewControllers;
@property (nonatomic, strong) NSMutableArray *buttonsArray;

@property(nonatomic,strong)UIView *View;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;//tab
@property (nonatomic, strong) UICollectionView *magicFaceCollectionView;//面板列表
@property (nonatomic, strong) MagicFaceDataHandler* handle;//数据处理对象
@property (nonatomic, strong) NSMutableArray<NSString *> *groupNames;//魔表组名，用于tab标题·

@end

NS_ASSUME_NONNULL_END
