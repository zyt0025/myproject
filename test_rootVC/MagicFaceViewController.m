//
//  MagicFaceViewController.m
//  jsonTest
//
//  Created by 苏洗洗 on 2023/7/25.
//

#import "MagicFaceViewController.h"
#import <Masonry/Masonry.h>
@interface MagicFaceViewController ()<UIGestureRecognizerDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate,CustomCollectionViewControllerDelegate>

@end

@implementation MagicFaceViewController

- (void)viewDidLoad {
    
    NSLog(@"ccccc");
   // NSLog(@"MagicFaceViewController viewDidLoad begin");
    [super viewDidLoad];
    //[self setupViews];
   // NSLog(@"1111");
    //self.handle = [[MagicFaceDataHandler alloc]init];
    [self fetchData];//获取数据和设置ui
    //NSLog(@"MagicFaceViewController viewDidLoad end");
}


//
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"bbbcccc");
    CGFloat padding = 10.0;
    CGFloat controlHeight = 30.0;
    CGFloat topOffset = 500.0; // 顶部偏移量，你可以根据需要调整
    CGFloat availableHeight = CGRectGetHeight(self.view.bounds) - 2 * padding - controlHeight - topOffset;

////    self.segmentedControl.frame = CGRectMake(padding, padding + topOffset, CGRectGetWidth(self.view.bounds) - 2 * padding, controlHeight);
////    for (UIViewController *vc in self.collectionViewControllers) {
////        vc.view.frame = CGRectMake(padding, 2 * padding + controlHeight + topOffset, CGRectGetWidth(self.view.bounds) - 2 * padding, availableHeight);
////    }
}
- (void)showToastWithMessage:(NSString *)message {
    UILabel *toastLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    toastLabel.text = message;
    toastLabel.center = self.view.center;
    toastLabel.backgroundColor = [UIColor lightGrayColor];
    toastLabel.textAlignment = NSTextAlignmentCenter;
    toastLabel.alpha = 0.0;
    
    [self.view addSubview:toastLabel];
    //通过改变 toastLabel 的透明度（alpha）来实现显示和隐藏的效果，完成后将 toastLabel 从视图中移除
    [UIView animateWithDuration:0.5 animations:^{
        toastLabel.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:2.0 options: UIViewAnimationOptionCurveEaseOut animations:^{
            toastLabel.alpha = 0.0;
        } completion:^(BOOL finished) {
            [toastLabel removeFromSuperview];
        }];
    }];
}

- (void)setHandle:(MagicFaceDataHandler *)handle {
    NSLog(@"handle update: self %@, handle %@", self, handle);
}

- (void)fetchData {
    NSString *url = @"https://mock.corp.kuaishou.com/mock/5321/rest/n/magicFace/multi";
    self.handle = [[MagicFaceDataHandler alloc]init];
//    if (self.isFetching) {
//            return;
//        }
//
//    self.isFetching = YES;
    [self.handle fetchJSONFromURL:url completionHandler:^(NSDictionary *json, NSError *error) {
        if (error) {
            
            NSLog(@"Error: %@", error);
        } else {
            //NSLog(@"1111");
            //NSLog(@"%@",json);
            [self.handle handleface:json];
            NSLog(@"self.handle.groups after handleface: %@", self.handle.groups);
            self.groupNames = [[NSMutableArray alloc] init];
            NSLog(@"self.handle.groups: %@", self.handle.groups);
            NSLog(@"count in fetch: %lu", self.handle.groups.count);
            for(MagicFaceGroup* group in self.handle.groups){
                NSString *groupname = group.name;
                NSLog(@"%@",groupname);
                
                [self.groupNames addObject:groupname ];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"self.handle.groups before setupViews: %@", self.handle.groups);
                //[self setupViews];
                NSLog(@"Address of self.handle before setupViews: %p", self.handle);
                [self setupViews];
                //[self setupPageViewController];
            });
        }
    }];
}



- (void)setupViews {
    NSLog(@"Address of self.handle after setupViews: %p", self.handle);
    NSLog(@"Count of self.handle.groups: %lu", self.handle.groups.count);
    //self.view.backgroundColor = [UIColor whiteColor];
    self.collectionViewControllers = [NSMutableArray array];
   // NSLog(@"xxxxxgroups: %lu", self.handle.groups.count);
    NSLog(@"self.handle.groups.count before for loop: %lu", self.handle.groups.count);
    for (MagicFaceGroup *group in self.handle.groups) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CustomCollectionViewController *customVC = [[CustomCollectionViewController alloc] initWithMagicFaceGroup:group layout:layout];
        customVC.delegate=self;
        //customVC.selectedIndex = self.segmentedControl.selectedSegmentIndex;
        [self.collectionViewControllers addObject:customVC];
        NSLog(@"Added a CustomCollectionViewController for group: %@", group);

    }
    NSLog(@"Count of self.handle.groups after loop: %lu", self.handle.groups.count);
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];

    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    //CustomCollectionViewController

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger lastIndex = [defaults integerForKey:@"LastSelectedTabIndex"];

    [self.pageViewController setViewControllers:@[self.collectionViewControllers[3]]   direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self.view addSubview:self.pageViewController.view];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height - 400, self.view.bounds.size.width - 20, 30)];
    _scrollView.showsHorizontalScrollIndicator = NO;

    CGFloat tabWidth = 100;
    CGFloat xOffset = 0;


    for (NSInteger i = 0; i < self.groupNames.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(xOffset, 0, tabWidth, 30);
        [button setTitle:self.groupNames[i] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(tabButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
        
        // 根据 lastIndex 设置选中的按钮
        if (i == lastIndex) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
        
        xOffset += tabWidth;
    }

    _scrollView.contentSize = CGSizeMake(self.groupNames.count * tabWidth, 30);
    [self.view addSubview:_scrollView];

    // 更新 pageViewController 的 frame
    self.pageViewController.view.frame = CGRectMake(0, CGRectGetMaxY(_scrollView.frame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(_scrollView.frame));
    self.pageViewController.view.backgroundColor=[UIColor redColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
//
  
}
- (void)tabButtonClicked:(UIButton *)button {
    // 更新 UserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:button.tag forKey:@"LastSelectedTabIndex"];
    [defaults synchronize];
    for (UIButton *subButton in _scrollView.subviews) {
        if ([subButton isKindOfClass:[UIButton class]]) {
            if (subButton == button) {
                subButton.selected = YES;
            } else {
                subButton.selected = NO;
            }
        }
    }
    
    // 更新 Page View Controller
    // 根据 button.tag 的值来切换到相应的 view controller
    [self.pageViewController setViewControllers:@[self.collectionViewControllers[button.tag]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self.collectionViewControllers indexOfObject:viewController];
    if ((index == 0) || (index == NSNotFound)) {
    return nil;
 }
 index--;
    return [self.collectionViewControllers objectAtIndex:index];
 
}

#pragma mark 返回下一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self.collectionViewControllers indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    CustomCollectionViewController *vc = [self.collectionViewControllers objectAtIndex:index];
    NSLog(@"xxxxxx000    %@", vc.group.name);
    index++;
    if (index == [self.collectionViewControllers count]) {
        return nil;
    }
    vc = [self.collectionViewControllers objectAtIndex:index];
    NSLog(@"xxxxxx1111    %@", vc.group.name);
    return [self.collectionViewControllers objectAtIndex:index];
}

//
- (void)showPanel {
    // 设定面板和segmentedControl出现前的位置（屏幕下方）

    CGRect collectionViewFrame = self.pageViewController.view.frame;
    collectionViewFrame.origin.y = self.view.frame.size.height;
    self.pageViewController.view.frame = collectionViewFrame;
    self.pageViewController.view.hidden = NO;

    CGRect scrowControlFrame = self.segmentedControl.frame;
    scrowControlFrame.origin.y = self.view.frame.size.height;
    self.scrollView.frame = scrowControlFrame;
    self.scrollView.hidden = NO;

    // 计算它们应该出现的位置
    collectionViewFrame.origin.y = self.view.frame.size.height - collectionViewFrame.size.height;
    scrowControlFrame.origin.y = collectionViewFrame.origin.y - scrowControlFrame.size.height;

    // 执行动画
    [UIView animateWithDuration:0.5 animations:^{
        self.pageViewController.view.frame = collectionViewFrame;
        self.scrollView.frame = scrowControlFrame;
    }];
}
- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.view];
    if (!CGRectContainsPoint(self.magicFaceCollectionView.frame, location) && !CGRectContainsPoint(self.segmentedControl.frame, location)) {
        if (self.segmentedControl.hidden || self.segmentedControl.hidden) {
            // 如果它们当前是隐藏的，那么就显示
            [self showPanel];
        } else {
            // 否则就隐藏
            [self hidePanel];
        }
    }
}
- (void)hidePanel {
    // 计算面板和segmentedControl消失后的位置（屏幕下方）
    CGRect collectionViewFrame = self.pageViewController.view.frame;
    collectionViewFrame.origin.y = self.view.frame.size.height;

    CGRect scrowControlFrame = self.scrollView.frame;
    scrowControlFrame.origin.y = self.view.frame.size.height;

    // 执行动画
    [UIView animateWithDuration:0.5 animations:^{
        self.magicFaceCollectionView.frame = collectionViewFrame;
        self.segmentedControl.frame = scrowControlFrame;
    } completion:^(BOOL finished) {
        self.magicFaceCollectionView.hidden = YES;
        self.segmentedControl.hidden = YES;
    }];
}
////对手势作用进行限制
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    if ([touch.view isDescendantOfView:self.magicFaceCollectionView] || [touch.view isDescendantOfView:self.segmentedControl]) {
//        // 如果触摸的view是magicFaceCollectionView或者segmentedControl的子视图，则忽略此次手势
//        return NO;
//    }
//    return YES;
//}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.pageViewController.view] || [touch.view isDescendantOfView:self.scrollView]) {
        // 我们不希望在pageViewController.view上的点击触发手势识别器
        return NO;
    }

    return YES;
}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {

    if (completed) {
        NSInteger currentIndex = [self.collectionViewControllers indexOfObject:[self.pageViewController.viewControllers firstObject]];
        
        // 更新 UserDefaults
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:currentIndex forKey:@"LastSelectedTabIndex"];
        [defaults synchronize];

        // 更新UIScrollView中的选中项
        for (UIView *subview in _scrollView.subviews) {
            if ([subview isKindOfClass:[UIButton class]]) {
                UIButton *subButton = (UIButton *)subview;
                subButton.selected = (subButton.tag == currentIndex);
            }
        }
    }
}



//- (void)handleTappp:(UITapGestureRecognizer *)gesture {
//    if (self.isPageViewVisible) {
//        // 如果pageViewController已经显示，则移动它到屏幕之外，使其隐藏
//        [UIView animateWithDuration:0.3 animations:^{
//            self.pageViewController.view.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
//        }];
//        self.isPageViewVisible = NO;
//    } else {
//        // 如果pageViewController还未显示，则移动它到屏幕上方，使其显示
//        [UIView animateWithDuration:0.3 animations:^{
//            self.pageViewController.view.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(self.scrollView.frame));
//        }];
//        self.isPageViewVisible = YES;
//    }
//}
@end
