//
//  ViewController.m
//  CustomMenu
//
//  Created by cofco on 2017/11/20.
//  Copyright © 2017年 cofco. All rights reserved.
//

#import "ViewController.h"
#import "GXPopupMenu.h"
#import "GXAlertSheetMenu.h"

@interface ViewController ()
@property (nonatomic, strong) GXPopupMenu * popupMenuView;
@property (nonatomic, strong) GXAlertSheetMenu * alertSheetMenuView;

@end

@implementation ViewController

- (GXPopupMenu *)popupMenuView {
    if(!_popupMenuView) {
        _popupMenuView = [GXPopupMenu popupMenuWithTitles:
                          @[@{@"title":@"添加好友"},
                           @{@"title":@"扫一扫"},
                           @{@"title":@"发起群聊"},
                           @{@"title":@"我的二维码"}]];
        _popupMenuView.popupBlock = ^(NSInteger index) {
            NSLog(@"---popupMenu 点击了第%zd个---",index);
        };
    }
    return _popupMenuView;
}
- (GXAlertSheetMenu *)alertSheetMenuView {
    if(!_alertSheetMenuView) {
        _alertSheetMenuView = [GXAlertSheetMenu menuWithTitles:@[@"男",@"女",@"删除"]];
        _alertSheetMenuView.menuBlock = ^(NSInteger index) {
            NSLog(@"---alertSheetMenu 点击了第%zd个---",index);

        };
    }
    return _alertSheetMenuView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)alertSheetClick:(UIButton *)sender {
    [self.alertSheetMenuView show];
}

- (IBAction)popupMenuClick:(UIButton *)sender {
    [self.popupMenuView showPopupMenu];
}



@end
