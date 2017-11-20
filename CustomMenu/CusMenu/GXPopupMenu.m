//
//  PopupMenu.m
//  CustomMenu
//
//  Created by cofco on 2017/11/20.
//  Copyright © 2017年 cofco. All rights reserved.
//

#import "GXPopupMenu.h"
#define Screen_Width ([UIScreen mainScreen].bounds.size.width)

@interface GXPopupMenu () {
    UIView * _bgView;
}
@property (nonatomic, assign) CGFloat backgroundImgHeight;
@end

@implementation GXPopupMenu
#pragma mark - 全局参数设置
const NSTimeInterval popupDuration = 0.2;
const CGFloat menuButtonFontSize = 14.0;

+(instancetype)popupMenuWithTitles:(NSArray *)titles {
    return [[self alloc]initWithTitles:titles];
}
- (instancetype)initWithTitles:(NSArray *)titles {
    self = [super init];
    if (self) {
        
        self.userInteractionEnabled  = YES;
        NSInteger count = titles.count;
        self.backgroundImgHeight = count * 35+15;
        CGFloat width = Screen_Width / 2.5;
        UIImageView * backgroundImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, self.backgroundImgHeight)];
        backgroundImgV.image = [UIImage imageNamed:@"popup_bg"];
        [self addSubview:backgroundImgV];
        
        for (int i = 0; i < titles.count; i++) {
            NSDictionary * dict = titles[i];
            UIButton * menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
            menuButton.tag = i + 1;
            menuButton.titleLabel.font = [UIFont systemFontOfSize:menuButtonFontSize];
            [menuButton setTitle:dict[@"title"] forState:UIControlStateNormal];
            // 如果需要设置图标
            if ([[dict allKeys] containsObject:@"image"]) {
                [menuButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
                [menuButton setImage:[UIImage imageNamed:dict[@"image"]] forState:UIControlStateNormal];
            }
            menuButton.frame = CGRectMake(0, 10 + i * 35, width, 35);
            [menuButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:menuButton];
        }
    }
    return self;
}
- (void)btnClick:(UIButton *)button {
    self.popupBlock(button.tag-1);
    [self hidePopupMenu];
}
- (void)showPopupMenu {
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    _bgView    = [[UIView alloc] initWithFrame:window.bounds];
    _bgView.backgroundColor        = [UIColor clearColor];
    _bgView.userInteractionEnabled = YES;
    [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePopupMenu)]];
    [window addSubview:_bgView];
    
    self.bounds = CGRectMake(0, 0, Screen_Width/2.5-20, self.backgroundImgHeight);
    [window addSubview:self];
    
    self.layer.anchorPoint = CGPointMake(1, 0);
    self.layer.position = CGPointMake(window.bounds.size.width-10-15, 64);
    self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    //动画
    [UIView animateWithDuration:popupDuration animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}
- (void)hidePopupMenu {
    [UIView animateWithDuration:popupDuration animations:^{
        self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    } completion:^(BOOL finished) {
        [_bgView removeFromSuperview];
        _bgView = nil;
        [self removeFromSuperview];
        
    }];
}

//#pragma mark 设置展示界面的layer
//- (void)setShowViewTransformWithScale:(CGPoint)scale
//                          anchorPoint:(CGPoint)anchor
//                             position:(CGPoint)position
//                                 view: (UIView *)view {
//    view.transform = CGAffineTransformMakeScale(scale.x, scale.y);
//    //view.layer.anchorPoint = CGPointMake(anchor.x, anchor.y);
//    view.layer.position = CGPointMake(position.x, position.y);
//}
- (void)dealloc {
    NSLog(@"-- GXPopupMenu dealloc --");
}
@end
