//
//  GXAlertSheetMenu.m
//  CustomMenu
//
//  Created by cofco on 2017/11/20.
//  Copyright © 2017年 cofco. All rights reserved.
//

#import "GXAlertSheetMenu.h"
#import "UIView+Extension.h"

#define  RGBA_COLOR(R,G,B,A)  [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]

@interface GXAlertSheetMenu () {
    UIView * _bgView;
    CGFloat sheetMenuHeight;
    UIView * _containerView;
}
@end

@implementation GXAlertSheetMenu

const NSTimeInterval alertSheetDuration = 0.3;

+ (instancetype)menuWithTitles:(NSArray *)titles {
    return [[self alloc]initWithTitles:titles];
}
- (instancetype)initWithTitles:(NSArray *)titles {
    sheetMenuHeight = titles.count * (50 + 1) + 57.0;
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _containerView = [[UIView alloc]init];
        _containerView.backgroundColor = RGBA_COLOR(236.0, 236.0, 236.0, 1);
        [self addSubview:_containerView];
        
        for (int i = 0; i < titles.count; i++) {
            
            UIButton * btn      = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i + 1;
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            if ([titles[i] isEqualToString:@"删除"]) {
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            } else {
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            [btn addTarget:self action:@selector(menuBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = [UIColor whiteColor];
            [_containerView addSubview:btn];
            
        }
        
        UIButton * cancelBtn      = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.backgroundColor = [UIColor whiteColor];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self addSubview:cancelBtn];
    }
    return self;
}

//展示出菜单界面
- (void)show {
    UIWindow * window    = [UIApplication sharedApplication].keyWindow;
    _bgView       = [[UIView alloc] initWithFrame:window.bounds];
    _bgView.alpha = 0;
    _bgView.backgroundColor        = [UIColor blackColor];
    _bgView.userInteractionEnabled = YES;
    [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    [window addSubview:_bgView];
    
    self.frame = CGRectMake(0, window.bounds.size.height, window.bounds.size.width, sheetMenuHeight);
    [window addSubview:self];
    
    [UIView animateWithDuration:alertSheetDuration animations:^{
        _bgView.alpha = 0.5;
        self.frame           = CGRectMake(0, window.bounds.size.height - sheetMenuHeight, window.bounds.size.width, sheetMenuHeight);
    }];
}
//点击半透明部分隐藏
- (void)hide {
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    CGRect newRect    = self.frame;
    newRect.origin.y  = window.bounds.size.height;
    [UIView animateWithDuration:alertSheetDuration animations:^{
        _bgView.alpha = 0;
        self.frame = newRect;
    } completion:^(BOOL finished) {
        [_bgView removeFromSuperview];
        _bgView = nil;
        [self removeFromSuperview];
    }];
}
- (void)menuBtnDidClick:(UIButton *)button {
    self.menuBlock(button.tag-1);
    [self hide];
}
#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger menuCount = _containerView.subviews.count;
    CGFloat backView_H = menuCount * (50 + 1) + 57.0;
    for (UIView * view in self.subviews) {
        
        if ([view isKindOfClass:[UIView class]]) {
            view.frame = CGRectMake(0, self.frame.size.height - backView_H, self.frame.size.width, backView_H);
        }
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * cancelBtn = (UIButton *)view;
            cancelBtn.frame = CGRectMake(0, self.frame.size.height - 50.0, self.frame.size.width, 50.0);
        }
    }
    CGFloat button_W = self.frame.size.width;
    CGFloat button_H = 50.0;
    NSInteger index = 0;
    for (UIButton * tmpBtn in _containerView.subviews) {
        tmpBtn.x      = 0.0;
        tmpBtn.y      = index * (button_H + 1);
        tmpBtn.width  = button_W;
        tmpBtn.height = button_H;
        index++;
    }
}
- (void)dealloc {
    NSLog(@"-- GXAlertSheetMenu dealloc --");
}
@end
