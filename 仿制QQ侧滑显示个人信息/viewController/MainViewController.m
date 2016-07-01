//
//  MainViewController.m
//  仿制QQ侧滑显示个人信息
//
//  Created by beginner on 16/6/30.
//  Copyright © 2016年 beginner. All rights reserved.
//

#import "MainViewController.h"
#import "TabBarViewController.h"
#import "LeftViewController.h"

static const CGFloat maxHorizonSlideRatio = 0.75;   //水平最大滑动比例
static const CGFloat panEndAnimateDuration = 0.25;  //pan手势end的动画时间
static const CGFloat tabBarMinRatio = 0.85;         //tabBar的最小缩放比例

@interface MainViewController ()<LeftViewControllerDelegate>
@property (nonatomic , strong) TabBarViewController *tabBar;
@property (nonatomic , strong) LeftViewController *leftView;
@property (nonatomic , strong) UIPanGestureRecognizer *SEPanFR;
@property (nonatomic , assign) BOOL isCanPanChange;    //判断点击的位置能否滑动
@property (nonatomic , assign) CGFloat panPointX;      //点击开始滑动的位置
@property (nonatomic , assign) CGFloat dictanceLeft;   //点击位置与tabBar的x起点的距离
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

#pragma mark init
- (void)initView {
    _leftView = [LeftViewController new];
    _leftView.delegate = self;
    _leftView.tableViewWidthRatio = maxHorizonSlideRatio + (1 - tabBarMinRatio)/2;
    _tabBar = [TabBarViewController new];
    _SEPanFR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(backHandle:)];
    _SEPanFR.maximumNumberOfTouches = 1;
    [_tabBar.view addGestureRecognizer:_SEPanFR];
    

    self.view.frame = DEVICEBOUNDS;
    [self addChildViewController:_leftView];
    [self.view addSubview:_leftView.view];
    [self.view addSubview:_tabBar.view];
}


- (void)backHandle:(UIPanGestureRecognizer *)recognizer {
    _panPointX = [recognizer locationInView:self.view].x;
    
    if(recognizer.state == UIGestureRecognizerStateBegan) {
        //当滑动水平X大于tabbar宽度的(1 - maxHorizonSlideRatio)时禁止滑动
        _isCanPanChange = _panPointX <= CGRectGetMinX(_tabBar.view.frame) + (CGRectGetWidth(_tabBar.view.frame) * (1 - maxHorizonSlideRatio));
        //点击位置与tabBar的x起点的距离
        _dictanceLeft = ([recognizer locationInView:self.view].x - CGRectGetMinX(_tabBar.view.frame));
    } else if(recognizer.state == UIGestureRecognizerStateChanged) {
        
        //_panPointX相当于点击在_tabBarMinX上，这样无跳屏现象
        _panPointX = _panPointX - _dictanceLeft;
        
        CGFloat maxPanPointX = CGRectGetWidth(self.view.frame) * maxHorizonSlideRatio;
        CGFloat height = _panPointX/maxPanPointX * (CGRectGetHeight(self.view.frame) * (1 - tabBarMinRatio));
        CGFloat percent = (CGRectGetHeight(self.view.frame) - height)/CGRectGetHeight(self.view.frame);
        
        if (!_isCanPanChange) {
            return;
        } else if (_panPointX >= maxPanPointX || percent < tabBarMinRatio) {
            _panPointX = maxPanPointX;
            percent = tabBarMinRatio;
        }
        
        if (_panPointX < 0) {
            [self changeTabBarWithDistanceCenter:0 ratio:1];
            [_leftView leftTableViewAnimationWith:0];
        } else {
            [self changeTabBarWithDistanceCenter:(_panPointX) ratio:percent];
            [_leftView leftTableViewAnimationWith:_panPointX/maxPanPointX];
        }
        
    } else if(recognizer.state == UIGestureRecognizerStateEnded) {
        if (!_isCanPanChange) {
            return;
        }
        //pan手势end的动画
        [UIView animateWithDuration:panEndAnimateDuration animations:^{
            if(_panPointX > (CGRectGetWidth(_tabBar.view.frame) * maxHorizonSlideRatio/2)) {
                [self changeTabBarWithDistanceCenter:(CGRectGetWidth(self.view.frame) * maxHorizonSlideRatio) ratio:tabBarMinRatio];
                [_leftView leftTableViewAnimationWith:1];
            } else {
                [self changeTabBarWithDistanceCenter:0 ratio:1];
                [_leftView leftTableViewAnimationWith:0];
            }
        }];
    }
}

#pragma mark LeftViewControllerDelegate
- (void)didSelectItem:(NSString *)title {
    [UIView animateWithDuration:panEndAnimateDuration * 2 animations:^{
        [self changeTabBarWithDistanceCenter:0 ratio:1];
        [_leftView leftTableViewAnimationWith:0];
    }];
}

#pragma mark other
- (void)changeTabBarWithDistanceCenter:(CGFloat)distanceCenter ratio:(CGFloat)ratio {
    _tabBar.view.center = CGPointMake(self.view.center.x + distanceCenter, self.view.center.y);
    _tabBar.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, ratio, ratio);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
