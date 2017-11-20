//
//  PopupMenu.h
//  CustomMenu
//
//  Created by cofco on 2017/11/20.
//  Copyright © 2017年 cofco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GXPopupMenu : UIView

@property (nonatomic, copy) void(^popupBlock)(NSInteger index);

+(instancetype)popupMenuWithTitles:(NSArray *)titles;
- (void)showPopupMenu;
- (void)hidePopupMenu;

@end
