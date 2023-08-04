// CustomCollectionViewController.h
#import <UIKit/UIKit.h>
#import "MagicFaceGroup.h"
#import"MagicFaceCell.h"
@protocol CustomCollectionViewControllerDelegate <NSObject>
- (void)showToastWithMessage:(NSString *)message;
@end

@interface CustomCollectionViewController : UICollectionViewController
@property (nonatomic, strong) MagicFaceGroup *group;
@property (nonatomic, weak) id<CustomCollectionViewControllerDelegate> delegate;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, strong) NSIndexPath *markedCell;//选中标记
- (instancetype)initWithMagicFaceGroup:(MagicFaceGroup *)group layout:(UICollectionViewFlowLayout *)layout;

@end

