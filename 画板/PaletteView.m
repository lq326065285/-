//
//  PaletteView.m
//  画板
//
//  Created by 李强 on 2017/4/11.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "PaletteView.h"
#import "UIImage+Palette.h"
@interface PaletteView ()

@property (nonatomic,strong) UIImageView *paletteImage;

@end


@implementation PaletteView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.paletteImage];
    }
    return self;
}

-(void)selectColorSection:(UITapGestureRecognizer *)tgr{
    NSLog(@"%@",NSStringFromCGPoint([tgr locationInView:tgr.view]));
    UIColor * color = [self.paletteImage.image getColorFromLocation:[tgr locationInView:tgr.view] size:self.paletteImage.frame.size];
    if (self.selectColorCompletion) {
        self.selectColorCompletion(color);
    }
}


-(UIImageView *)paletteImage{
    if (!_paletteImage) {
        _paletteImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _paletteImage.image = [UIImage imageNamed:@"pickerColorWheel"];
        _paletteImage.userInteractionEnabled = YES;
        UITapGestureRecognizer * tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectColorSection:)];
        [_paletteImage addGestureRecognizer:tgr];
    }
    return _paletteImage;
}

@end
