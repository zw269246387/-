//
//  ViewController.m
//  加密登录-钥匙串存储密码
//
//  Created by zheng on 2018/8/28.
//  Copyright © 2018年 zheng. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) UITextField *userNameTextF;

@property (nonatomic, strong) UITextField *pwdTextF;

@property (nonatomic, strong) UIButton *postBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self createUI];
    
}

- (void)createUI {
    
    [self.view addSubview:self.userNameTextF];
    [self.view addSubview:self.pwdTextF];
    [self.view addSubview:self.postBtn];
    
    [self.userNameTextF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view).offset(50);
        make.left.equalTo(self.view).offset(22);
        make.right.equalTo(self.view).offset(-22);
        make.height.offset(30);
        
    }];
    
    [self.pwdTextF mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.top.equalTo(self.userNameTextF.mas_bottom).offset(50);
        make.leftMargin.rightMargin.equalTo(self.userNameTextF);
        make.height.offset(30);

    }];
    
    [self.postBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.pwdTextF.mas_bottom).offset(50);
        make.width.offset(150);
    }];
    
}

//登录请求
- (void)postBtnClick {
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark get and set

- (UITextField *)userNameTextF {
    
    if (!_userNameTextF) {
        
        _userNameTextF = [[UITextField alloc] init];
        _userNameTextF.backgroundColor = [UIColor redColor];
    }
    return _userNameTextF;
}

- (UITextField *)pwdTextF {
    
    if (!_pwdTextF) {
        
        _pwdTextF = [[UITextField alloc] init];
        _pwdTextF.backgroundColor = [UIColor redColor];
    }
    return _pwdTextF;
}

- (UIButton *)postBtn {
    
    if (!_postBtn) {
        
        _postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_postBtn setTitle:@"登录" forState:UIControlStateNormal];
        _postBtn.backgroundColor = [UIColor redColor];
        [_postBtn addTarget:self action:@selector(postBtnClick) forControlEvents:UIControlEventTouchUpInside];
        

    }
    return _postBtn;
}
@end
