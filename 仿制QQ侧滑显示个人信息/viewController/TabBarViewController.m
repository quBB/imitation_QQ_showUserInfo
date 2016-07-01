//
//  TabBarViewController.m
//  仿制QQ侧滑显示个人信息
//
//  Created by beginner on 16/6/30.
//  Copyright © 2016年 beginner. All rights reserved.
//

#import "TabBarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

#pragma mark init 
- (void)initView {
    
    [UITabBar appearance].backgroundColor = [UIColor grayColor];
    [UITabBar appearance].backgroundImage = [UIImage new];
    [UITabBar appearance].tintColor = [UIColor cyanColor];

    FirstViewController *firstVC = [FirstViewController new];
    SecondViewController *secondVC = [SecondViewController new];
    ThirdViewController *thirdVC = [ThirdViewController new];
    
    
    UITabBarItem *firstItem = [[UITabBarItem alloc] initWithTitle:@"first" image:[UIImage imageNamed:@"标签栏_圈子"] selectedImage:[UIImage imageNamed:@"标签栏高亮_圈子"]];
    UITabBarItem *secondItem = [[UITabBarItem alloc] initWithTitle:@"second" image:[UIImage imageNamed:@"标签栏_排气管"] selectedImage:[UIImage imageNamed:@"标签栏_排气管"]];
    UITabBarItem *thirdItem = [[UITabBarItem alloc] initWithTitle:@"third" image:[UIImage imageNamed:@"标签栏_赛道"] selectedImage:[UIImage imageNamed:@"标签栏_赛道"]];
    
    
    firstVC.tabBarItem = firstItem;
    secondVC.tabBarItem = secondItem;
    thirdVC.tabBarItem = thirdItem;
    
    
    UINavigationController *firstNVC = [[UINavigationController alloc] initWithRootViewController:firstVC];
    UINavigationController *secondNVC = [[UINavigationController alloc] initWithRootViewController:secondVC];
    UINavigationController *ThirdNVC = [[UINavigationController alloc] initWithRootViewController:thirdVC];
    
    
    NSArray *controllers = @[firstNVC,secondNVC,ThirdNVC];
    self.viewControllers = controllers;
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
