//
//  GXAlertSheetMenu.h
//  CustomMenu
//
//  Created by cofco on 2017/11/20.
//  Copyright © 2017年 cofco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GXAlertSheetMenu : UIView
+ (instancetype)menuWithTitles:(NSArray *)titles;
@property (nonatomic, copy) void(^menuBlock)(NSInteger index);

- (void)show;
- (void)hide;
@end
