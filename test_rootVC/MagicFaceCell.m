//
//  MagicFaceCell.m
//  jsonTest
//
//  Created by 苏洗洗 on 2023/7/29.
//

#import "MagicFaceCell.h"
@interface MagicFaceCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;

@end


@implementation MagicFaceCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化imageView和label
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
        
        self.label = [[UILabel alloc] init];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat padding = 5.0;
    
    // 设置imageView的frame
    CGFloat imageHeight = self.contentView.bounds.size.height - 2 * padding;
    self.imageView.frame = CGRectMake(padding, padding, imageHeight, imageHeight);
    
    // 设置label的frame
    CGFloat labelHeight = 20.0;
    self.label.frame = CGRectMake(padding, CGRectGetMaxY(self.imageView.frame), imageHeight, labelHeight);
    self.transform = self.isSelected ? CGAffineTransformMakeScale(1.1, 1.1) : CGAffineTransformIdentity;
}

- (void)setMagicFace:(MagicFace *)magicFace {
    _magicFace = magicFace;
    
    // 使用SDWebImage异步下载和缓存图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:magicFace.image]
                      placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.label.text = magicFace.name;
    self.label.font = [UIFont systemFontOfSize:10];
}
//- (void)setSelected:(BOOL)selected {
//    [super setSelected:selected];
//
//    [UIView animateWithDuration:0.3 animations:^{
//        if (selected) {
//            self.transform = CGAffineTransformMakeScale(1.1, 1.1); // 放大1.1倍
//        } else {
//            self.transform = CGAffineTransformIdentity; // 还原到原始大小
//        }
//    }];
//}

@end

