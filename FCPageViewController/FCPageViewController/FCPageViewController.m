//
//  FCPageViewController.m
//  FCPageViewController
//
//  Created by 李晓飞 on 2019/2/24.
//  Copyright © 2019年 xiaofei. All rights reserved.
//

#import "FCPageViewController.h"
#import "FCSub1ViewController.h"
#import "FCSub2ViewController.h"

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface FCPageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong)NSMutableArray *vcArray;                       //页面数据源
@property (nonatomic, strong)UIPageViewController *pageViewController;      //pageVC控件
@property (nonatomic, assign)NSInteger curPage;                             //当前页
@property (nonatomic, strong)UIView *indicatorView;

@end

@implementation FCPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的pageVctrl";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createSelectedBtn];
    [self initForVC];
}

- (void)initForVC {
    FCSub1ViewController *sub1Vc = [[FCSub1ViewController alloc] init];
    FCSub2ViewController *sub2Vc = [[FCSub2ViewController alloc] init];
    
    [self.vcArray addObject:sub1Vc];
    [self.vcArray addObject:sub2Vc];
    
    self.pageViewController.view.frame = CGRectMake(0, 64 + 44, kScreenWidth, kScreenHeight - 64 - 44);
    
    [self.pageViewController setViewControllers:@[self.vcArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)createSelectedBtn {
    NSArray *arr = @[@"页面一",@"页面二"];
    
    for (NSInteger i=0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kScreenWidth/2*i, 64, kScreenWidth/2, 44);
        btn.tag = 100+i;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changeVc:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

#pragma mark - action
//页面选择按钮点击事件
- (void)changeVc:(UIButton *)btn {
    //获取当前第几页
    NSInteger tag = btn.tag - 100;
    [_pageViewController setViewControllers:@[_vcArray[tag]] direction:tag < _curPage animated:YES completion:^(BOOL finished) {
        _curPage = tag;
    }];
}

#pragma mark  ---UIPageViewController代理
#pragma mark - PageViewControllerDelegate
//返回后一页数据
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    //获取当前页数
    NSInteger index = [_vcArray indexOfObject:viewController];
    if (index+1 == _vcArray.count) {
        return nil;
    }
    return _vcArray[index+1];
}

//返回前一页数据
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [_vcArray indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    return _vcArray[index-1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
}

//滚动结束代理函数
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    _curPage = [_vcArray indexOfObject:pageViewController.viewControllers[0]];
}

#pragma mark - getter
- (NSMutableArray *)vcArray {
    if (!_vcArray) {
        _vcArray = [NSMutableArray array];
    }
    return _vcArray;
}

- (UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        [self.view addSubview:_pageViewController.view];
    }
    return _pageViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
