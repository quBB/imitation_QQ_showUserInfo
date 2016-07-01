# 仿制QQ侧滑显示个人信息


修改tabBal界面的滑动时缩放
```objective-c
#import "MainViewController.h"
...

static const CGFloat maxHorizonSlideRatio = 0.75;   //水平最大滑动比例
static const CGFloat panEndAnimateDuration = 0.25;  //pan手势end的动画时间
static const CGFloat tabBarMinRatio = 0.85;         //tabBar的最小缩放比例
```



修改侧面界面的缩放和透明度
```objective-c
#import "LeftViewController.h"

static const CGFloat tableViewReduceMinRatio = 0.3;  //tableview宽度最多能减小的的比例
static const CGFloat coverMaxOpcaity = 0.5;          //cover最大透明度
```

<br>
<br>
#示例
![] (https://github.com/quBB/imitation_QQ_showUserInfo/blob/master/%E4%BB%BF%E5%88%B6QQ%E4%BE%A7%E6%BB%91%E6%98%BE%E7%A4%BA%E4%B8%AA%E4%BA%BA%E4%BF%A1%E6%81%AF/resource/imitation_QQ.gif)
