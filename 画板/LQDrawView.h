//
//  LQDrawView.h
//  画板
//
//  Created by 李强 on 2017/4/11.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQDrawView : UIView
@property (nonatomic,assign) CGFloat lineWidth;
@property (nonatomic,strong) UIColor * lineColor;

//清除
-(void)erase;
//撤回
-(void)revoke;
//重绘
-(void)restart;
@end
