// CustomCollectionViewController.m
#import "CustomCollectionViewController.h"
#import "MagicFaceCell.h"
@interface CustomCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@end
@implementation CustomCollectionViewController

- (instancetype)initWithMagicFaceGroup:(MagicFaceGroup *)group layout:(UICollectionViewFlowLayout *)layout {
    self = [super init];
    if (self) {
//        if (self.group == nil) {
//            self.group = [[MagicFaceGroup alloc] init];
//        }
        //self.markedCells = [NSMutableSet set];
        // 直接保存传入的 group 对象，不复制
        self.group = group;
        NSLog(@"MagicFaces count in initWithMagicFaceGroup: %lu", self.group.magicFaces. count);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.collectionView registerClass:[MagicFaceCell class] forCellWithReuseIdentifier:@"MagicFaceCell"];
        
        // 设置数据源和代理
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        
//        [self.collectionView reloadData];
        [self.view addSubview:self.collectionView];  // 添加collectionView到视图层级中
        
    }
      
    return self;
}


- (void)viewDidLayoutSubviews {
    self.collectionView.frame = self.view.bounds;
}

- (void)setGroup:(MagicFaceGroup *)group {
    _group = group;
    
//    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat itemSize = screenWidth / 6; // 你也可以根据需要调整这个值
    return  CGSizeMake(itemSize, itemSize);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return self.group.magicFaces.count;
    NSInteger count = self.group.magicFaces.count;
    NSLog(@"MagicFaces count in numberOfItemsInSection: %lu %p %@", count, self, self.group.name);
    return count;// self.group.magicFaces.count;
//    NSInteger index = self.selectedIndex;
//    if (index >= 0 && index < self.handle.groups.count) {
//        MagicFaceGroup *group = self.handle.groups[index];
//        return group.magicFaces.count;
//    } else {
//        return 0;
//    }
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"hahhaahahaah");
    MagicFaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MagicFaceCell" forIndexPath:indexPath];
    NSLog(@"MagicFace name at %p indexPath: %@, name: %@", self, indexPath, cell.magicFace.name);
    cell.magicFace = self.group.magicFaces[indexPath.item];
    return cell;
//    MagicFaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MagicFaceCell" forIndexPath:indexPath];
//    NSInteger index = self.selectedIndex;
//    //if (index >= 0 && index < self.handle.groups.count) {
//        MagicFaceGroup *group = self.handle.groups[index];
//        cell.magicFace = group.magicFaces[indexPath.item];
//    }
//    return cell;
    
}

#pragma mark - UICollectionViewDelegate

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    MagicFace *selectedMagicFace = self.group.magicFaces[indexPath.item];
//    NSString *magicFaceName = selectedMagicFace.name;
//    [self.delegate showToastWithMessage:[NSString stringWithFormat:@"已选中 %@ 魔表", magicFaceName]];
//   // [self showToastWithMessage:[NSString stringWithFormat:@"已选中 %@ 魔表", magicFaceName]];
//    MagicFaceCell *cell = (MagicFaceCell *)[collectionView cellForItemAtIndexPath:indexPath];
////    [UIView animateWithDuration:0.3 animations:^{
////        cell.transform = CGAffineTransformIdentity;
////    }];
//    [UIView animateWithDuration:0.3 animations:^{
//        cell.transform = CGAffineTransformMakeScale(1.2, 1.2); // 缩放到1.2倍大小
//        cell.layer.borderWidth = 2.0;
//        cell.layer.borderColor = [UIColor redColor].CGColor;
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.3 animations:^{
//            cell.transform = CGAffineTransformIdentity; // 恢复原始大小
//            cell.layer.borderWidth = 0.0;
//                        cell.layer.borderColor = nil;
//        }];
//    }];
//}
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    MagicFace *selectedMagicFace = self.group.magicFaces[indexPath.item];
//    NSString *magicFaceName = selectedMagicFace.name;
//    [self.delegate showToastWithMessage:[NSString stringWithFormat:@"已选中 %@ 魔表", magicFaceName]];
//    MagicFaceCell *cell = (MagicFaceCell *)[collectionView cellForItemAtIndexPath:indexPath];
//
//    if ([self.markedCells containsObject:indexPath]) {
//        // If the cell is already marked, unmark it
//        [UIView animateWithDuration:0.3 animations:^{
//            cell.transform = CGAffineTransformIdentity;
//            cell.layer.borderWidth = 0.0;
//            cell.layer.borderColor = nil;
//        }completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.3 animations:^{
//                cell.transform = CGAffineTransformIdentity; // 恢复原始大小
//            }];}];
//
//        [self.markedCells removeObject:indexPath];
//    } else {
//        // If the cell is not marked, mark it
//        [UIView animateWithDuration:0.3 animations:^{
//            cell.transform = CGAffineTransformMakeScale(1.2, 1.2); // 缩放到1.2倍大小
//            cell.layer.borderWidth = 1.6;
//            cell.layer.borderColor = [UIColor redColor].CGColor;
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.3 animations:^{
//                cell.transform = CGAffineTransformIdentity; // 恢复原始大小
//            }];
//        }];
//
//        [self.markedCells addObject:indexPath];
//    }
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MagicFace *selectedMagicFace = self.group.magicFaces[indexPath.item];
    NSString *magicFaceName = selectedMagicFace.name;
   
    
    MagicFaceCell *cell = (MagicFaceCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    // Unmark the previously selected cell
    if (self.markedCell) {
        [self.delegate showToastWithMessage:[NSString stringWithFormat:@"已选中 %@ 魔表", magicFaceName]];
        MagicFaceCell *prevCell = (MagicFaceCell *)[collectionView cellForItemAtIndexPath:self.markedCell];
        [UIView animateWithDuration:0.3 animations:^{
            prevCell.transform = CGAffineTransformIdentity;
            prevCell.layer.borderWidth = 0.0;
            prevCell.layer.borderColor = nil;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                cell.transform = CGAffineTransformIdentity; // Scale back down
            }];
        }];
    }
    
    // If the same cell is selected again, just return
    if ([self.markedCell isEqual:indexPath]) {
        self.markedCell = nil;
        return;
    }
    [self.delegate showToastWithMessage:[NSString stringWithFormat:@"已选中 %@ 魔表", magicFaceName]];
    // Mark the new cell
    [UIView animateWithDuration:0.3 animations:^{
        
        cell.transform = CGAffineTransformMakeScale(1.2, 1.2); // Scale up
        cell.layer.borderWidth = 2.0;
        cell.layer.borderColor = [UIColor redColor].CGColor;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            cell.transform = CGAffineTransformIdentity; // Scale back down
        }];
    }];
    
    // Remember the newly selected cell
    self.markedCell = indexPath;
}

@end
