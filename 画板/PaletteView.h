//
//  PaletteView.h
//  画板
//
//  Created by 李强 on 2017/4/11.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaletteView : UIView

@property(nonatomic,copy) void(^selectColorCompletion)(UIColor * color);

@end
