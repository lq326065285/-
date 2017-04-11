//
//  ViewController.m
//  画板
//
//  Created by 李强 on 2017/4/11.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ViewController.h"
#import "LQDrawView.h"
#import "PaletteView.h"
#import <HandyFrame/UIView+LayoutMethods.h>
@interface ViewController ()

@property (nonatomic,strong) LQDrawView * drawView;
@property (nonatomic,strong) PaletteView * paletteView;
@property (nonatomic,strong) UISlider * slider;
@property (nonatomic,strong) UIView * currentColorView;
@end

//#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation ViewController
#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.drawView];
    [self.view addSubview:self.paletteView];
    [self.view addSubview:self.slider];
    [self.view addSubview:self.currentColorView];
    [self createButton];
}


#pragma mark - response action

-(void)clickBtn:(UIButton *)button{
    switch (button.tag) {
        case 10:
        {
            //擦除
            [self.drawView erase];
        }
            break;
        case 11:
        {
            //撤销
            [self.drawView revoke];
        }
            break;
            
        default:{
            //重绘
            [self.drawView restart];
        }
            break;
    }
}

-(void)sliderChange:(UISlider *)p{
    NSLog(@"%f",p.value);
    self.drawView.lineWidth = p.value * 20;
}

#pragma mark - provite methods

-(void)createButton{
    NSArray * arr = @[@"擦除",@"撤销",@"重绘"];
    NSInteger tag = 0;
    for(NSString * title in arr){
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button setFrame:CGRectMake(20, self.drawView.height + self.drawView.y + 10 + 10 + 60 * tag, 60, 30)];
        button.tag = 10+tag;
        [self.view addSubview:button];
        [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:[UIColor blueColor]];
        tag++;
    }
}


#pragma mark - getter setter

-(LQDrawView *)drawView{
    if (!_drawView) {
        _drawView = [[LQDrawView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT - 220)];
    }
    return _drawView;
}

-(PaletteView *)paletteView{
    if (!_paletteView) {
        _paletteView = [[PaletteView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 150) / 2.0, self.drawView.y + self.drawView.height + 20, 150, 150)];
        __weak typeof(self)weakSelf = self;
        _paletteView.selectColorCompletion = ^(UIColor * color){
            weakSelf.drawView.lineColor = color;
            weakSelf.currentColorView.backgroundColor = color;
        };
    }
    return _paletteView;
}

-(UIView *)currentColorView{
    if (!_currentColorView) {
        _currentColorView = [[UIView alloc] initWithFrame:CGRectMake(self.paletteView.x + self.paletteView.width + 20, self.drawView.y + self.drawView.height + 20, 40, 40)];
        _currentColorView.backgroundColor = [UIColor grayColor];
    }
    return _currentColorView;
}

-(UISlider *)slider{
    if (!_slider) {
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH - 40, 20)];
        _slider.value = .5;
        self.drawView.lineWidth *= .5;
        [_slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _slider;
}

@end
