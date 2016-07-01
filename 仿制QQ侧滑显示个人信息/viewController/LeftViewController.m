//
//  LeftViewController.m
//  仿制QQ侧滑显示个人信息
//
//  Created by beginner on 16/6/30.
//  Copyright © 2016年 beginner. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftTableViewCell.h"

static NSString *cellIndetifier = @"LeftTableViewCell";
static const CGFloat tableViewReduceMinRatio = 0.3;  //tableview宽度最多能减小的的比例
static const CGFloat coverMaxOpcaity = 0.5;          //cover最大透明度

@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak  , nonatomic) IBOutlet UIView *cover;
@property (strong, nonatomic) UITableView *LeftTableView;
@property (strong, nonatomic) NSArray *titles;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

#pragma mark init
- (void)initView {
    self.view.frame= DEVICEBOUNDS;
    _LeftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame) * _tableViewWidthRatio, CGRectGetHeight(self.view.frame) - 200)];
    _LeftTableView.backgroundColor = [UIColor clearColor];
    _LeftTableView.delegate = self;
    _LeftTableView.dataSource = self;
    _LeftTableView.scrollEnabled = NO;
    _LeftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_LeftTableView registerNib:[UINib nibWithNibName:cellIndetifier bundle:nil] forCellReuseIdentifier:cellIndetifier];
    [self.view addSubview:_LeftTableView];
    [self.view insertSubview:_LeftTableView belowSubview:_cover];
    
    _titles = @[@"性别",@"名字",@"年龄"];
}

#pragma mark UITableViewDelegate   UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    cell.titleLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(didSelectItem:)]) {
        [self.delegate didSelectItem:_titles[indexPath.row]];
    }
}

#pragma mark action
- (void)leftTableViewAnimationWith:(CGFloat)ratio {
    
    //tableView的宽度
    CGFloat tableViewWidth = (CGRectGetWidth(self.view.frame) * _tableViewWidthRatio);
    //tableView需要减小的宽度
    CGFloat reduceWidth = (CGRectGetWidth(self.view.frame) * _tableViewWidthRatio) * tableViewReduceMinRatio * (1 - ratio);
    //tableView减小后的宽度比
    CGFloat tableViewRatio = (tableViewWidth - reduceWidth)/tableViewWidth;
    
    
    _LeftTableView.transform = CGAffineTransformScale(CGAffineTransformIdentity, tableViewRatio, tableViewRatio);
    _LeftTableView.center = CGPointMake(CGRectGetWidth(_LeftTableView.frame)/2, _LeftTableView.center.y);

    _cover.layer.opacity = (1 - ratio) * coverMaxOpcaity;
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
