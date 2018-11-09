//
//  ViewController.m
//  customCamera
//
//  Created by root on 2018/11/9.
//  Copyright © 2018年 凉凉. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import "ZZCustomCameraViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *btn = [UIButton zz_buttonWithTitle:@"点击打开相机" color:[UIColor redColor] fontSize:17 target:self action:@selector(openCustomCamera:)];
    CGSize size = [btn sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    btn.size = size;
    btn.x = (kScreenW - btn.width) * 0.5;
    btn.y = (kScreenH - btn.height) * 0.5;
    [self.view addSubview:btn];
}

-(void)openCustomCamera:(UIButton *)sender
{
    [self haveCameraAuthorityBlock:^(BOOL isHave) {
        if (isHave) {
            ZZCustomCameraViewController *vc = [ZZCustomCameraViewController new];
            [self presentViewController:vc animated:true completion:nil];
        }
    }];
}

// 相机权限
- (void)haveCameraAuthorityBlock:(void (^)(BOOL isHave))block
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        !block ? : block(NO);
    }
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted ||
        status == AVAuthorizationStatusDenied) {
        !block ? : block(NO);
    }else if (status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {//相机权限
            !block ? : block(granted);
        }];
    }else {
        !block ? : block(YES);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
