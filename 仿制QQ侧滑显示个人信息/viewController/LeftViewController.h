//
//  LeftViewController.h
//  仿制QQ侧滑显示个人信息
//
//  Created by beginner on 16/6/30.
//  Copyright © 2016年 beginner. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftViewControllerDelegate <NSObject>
@optional
- (void)didSelectItem:(NSString *)title;
@end

@interface LeftViewController : UIViewController
@property (assign, nonatomic) CGFloat tableViewWidthRatio;
@property (weak, nonatomic) id<LeftViewControllerDelegate> delegate;

- (void)leftTableViewAnimationWith:(CGFloat)ratio;
@end
