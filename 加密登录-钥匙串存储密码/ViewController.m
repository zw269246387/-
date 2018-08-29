//
//  ViewController.m
//  加密登录-钥匙串存储密码
//
//  Created by zheng on 2018/8/28.
//  Copyright © 2018年 zheng. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "NSString+Hash.h"
#import <SSKeychain.h>
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
    //注册的时候 服务器保存密码

    [self createUI];
    
    [self loadUserInfo];
}

/**
 加载本地的账号 密码
 */
- (void)loadUserInfo {

    self.userNameTextF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];

    NSLog(@"%@",[SSKeychain allAccounts]);
 
    self.pwdTextF.text = [SSKeychain passwordForService:@"com.ImageResizing.------------" account:self.userNameTextF.text];
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
    
    NSString *userName = self.userNameTextF.text;
    
    NSString *pwd = self.pwdTextF.text;
    
    
    //加密处理
    //1 md5直接加密 123456 --> e10adc3949ba59abbe56e057f20f883e
    /*
    pwd = pwd.md5String;
    NSLog(@"现在的密码是%@",pwd);
    
    */
    
    //2 加盐
    //不足  盐是固定的 有泄漏的风险  修改困难
    /*
    NSString *salt = @"213sfffmfdkkdkkfkfk_+(#(#(#-Mksmkmfkmsdfkdmskfmdfmdkfm";
    pwd = [pwd stringByAppendingString:salt];
    pwd = pwd.md5String;
    NSLog(@"现在的密码是%@",pwd);
    */
    
    //3 HMAC 加密算法
    // 给定一个秘钥 对明文进行加密 并且做了两次散列 ---> 32位字符
    
    pwd = [pwd hmacMD5StringWithKey:@"hank"];
    NSLog(@"现在的密码是%@",pwd);
    /*
    HMAC  登录思路
    1 输入账号 密码 ,本地查找秘钥，如果没有，向服务器获取该账户的秘钥
    2 向服务器 获取秘钥，服务不一定给（设备锁）
     */
    
    //模拟发送登录请求 获取权限  不安全
    
//    pwd = [pwd stringByAppendingString:@"201808291103"].md5String;
    
    if ([self isSuccessWithUserName:userName pwd:pwd]) {
        
        NSLog(@"登录成功");
    }else {
        
        NSLog(@"登录失败");
    }
}

- (BOOL)isSuccessWithUserName:(NSString *)userName pwd:(NSString *)pwd {
    
    if ([userName isEqualToString:@"zw"] && [pwd isEqualToString:@"e9cdab82d48dcd37af7734b6617357e6"]) {
        
        //下次进入 直接登录  记住密码
        [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
        //同步
        [[NSUserDefaults standardUserDefaults] synchronize];
        //保存密码 用钥匙串访问
        //AES加密
        /*
         1.密码明文
         2.forService 服务：APP的唯一标识
         3.账号
         */
        [SSKeychain setPassword:self.pwdTextF.text forService:@"com.ImageResizing.------------" account:userName];
        
        return YES;
    }

    return NO;
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
