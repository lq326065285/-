//
//  UIImage+Palette.h
//  画板
//
//  Created by 李强 on 2017/4/11.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Palette)

-(UIColor *)getColorFromLocation:(CGPoint)point size:(CGSize)size;

@end
