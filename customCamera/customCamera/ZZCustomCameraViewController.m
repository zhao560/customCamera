//
//  ZZCustomCameraViewController.m
//  test
//
//  Created by root on 2018/11/2.
//  Copyright © 2018年 凉凉. All rights reserved.
//

#import "ZZCustomCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZZCustomCameraControlView.h"
#import <TZImagePickerController.h>
#import "ZZImageEditTool.h"

@interface ZZCustomCameraViewController ()
/// 捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property (nonatomic, strong) AVCaptureDevice *device;
/// AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property (nonatomic, strong) AVCaptureDeviceInput *input;
/// 照片输出流
@property (nonatomic ,strong) AVCaptureStillImageOutput *imageOutput;
/// session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property (nonatomic, strong) AVCaptureSession *session;
/// 图像预览层，实时显示捕获的图像
@property (nonatomic ,strong) AVCaptureVideoPreviewLayer *previewLayer;
/// 闪光灯
@property (nonatomic, assign) BOOL isflashOn;
/// 聚焦
@property (nonatomic, strong) UIView *focusView;
/// 拍照的照片
@property (nonatomic, strong) UIImage *takedImage;
///
@property (nonatomic, strong) ZZCustomCameraControlView *contentView;

@property (nonatomic, assign) CGFloat initialPinchZoom;
@end

@implementation ZZCustomCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customCamera];
    [self initUI];
    /// 对焦
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(focusGesture:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (BOOL)prefersStatusBarHidden
{
    return true;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)customCamera
{
    //使用AVMediaTypeVideo 指明self.device代表视频，默认使用后置摄像头进行初始化
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //使用设备初始化输入
    self.input = [[AVCaptureDeviceInput alloc]initWithDevice:self.device error:nil];
    /// 照片输出流
    self.imageOutput = [[AVCaptureStillImageOutput alloc]init];
    //生成会话，用来结合输入输出
    self.session = [[AVCaptureSession alloc]init];
    /// 输入输出设备结合
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.imageOutput]) {
        [self.session addOutput:self.imageOutput];
    }
    /// 清晰度
    if ([self.session canSetSessionPreset:AVCaptureSessionPreset1920x1080]) {
        [self.session setSessionPreset:AVCaptureSessionPreset1920x1080];
    }
    //使用self.session，初始化预览层，self.session负责驱动input进行信息的采集，layer负责把图像渲染显示
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    self.previewLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.previewLayer];
    
    //开始启动
    [self.session startRunning];
    //修改设备的属性，先加锁
    NSError *error;
    if ([self.device lockForConfiguration:&error]) {
        //闪光灯自动
        if ([self.device isFlashModeSupported:AVCaptureFlashModeAuto]) {
            [self.device setFlashMode:AVCaptureFlashModeAuto];
        }
        //自动白平衡
        if ([self.device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [self.device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        //解锁
        [self.device unlockForConfiguration];
    }
}

-(void)initUI
{
    self.focusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.focusView.layer.borderWidth = 1.0;
    self.focusView.layer.borderColor = [UIColor greenColor].CGColor;
    [self.view addSubview:self.focusView];
    self.focusView.hidden = YES;
    
    self.contentView = [[ZZCustomCameraControlView alloc] initWithFrame:KScreenBounds];
    WeakSelf;
    /// 拍照
    self.contentView.takeBlock = ^{
        [weakSelf onTakePicture];
    };
    /// 相册
    self.contentView.openPhotoBlock = ^{
        [weakSelf openPhotoLibrary];
    };
    /// 关闭
    self.contentView.closeBlock = ^{
        [weakSelf dismissViewControllerAnimated:true completion:nil];
    };
    /// 跳过
    self.contentView.skipBlock = ^{
        NSLog(@"跳过");
    };

    [self.view addSubview:self.contentView];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchDetected:)];
    [self.view addGestureRecognizer:pinch];
}

#pragma mark - 拖拽放大
- (void)pinchDetected:(UIPinchGestureRecognizer*)recogniser
{
    if (recogniser.state == UIGestureRecognizerStateBegan)
    {
        _initialPinchZoom = self.device.videoZoomFactor;
    }
    
    NSError *error = nil;
    [self.device lockForConfiguration:&error];
    
    if (!error) {
        CGFloat zoomFactor;
        CGFloat scale = recogniser.scale;
        if (scale < 1.0f) {
            zoomFactor = _initialPinchZoom - pow(self.device.activeFormat.videoMaxZoomFactor, 1.0f - recogniser.scale);
        } else {
            zoomFactor = _initialPinchZoom + pow(self.device.activeFormat.videoMaxZoomFactor, (recogniser.scale - 1.0f) / 2.0f);
        }
        
        zoomFactor = MIN(10.0f, zoomFactor);
        zoomFactor = MAX(1.0f, zoomFactor);
        
        self.device.videoZoomFactor = zoomFactor;
        [self.device unlockForConfiguration];
    }
}
#pragma mark - 对焦
/// 对焦
- (void)focusGesture:(UITapGestureRecognizer*)gesture
{
    CGPoint point = [gesture locationInView:gesture.view];
    [self focusAtPoint:point];
}

- (void)focusAtPoint:(CGPoint)point
{
    CGSize size = self.view.bounds.size;
    // focusPoint 函数后面Point取值范围是取景框左上角（0，0）到取景框右下角（1，1）之间,按这个来但位置就是不对，只能按上面的写法才可以。前面是点击位置的y/PreviewLayer的高度，后面是1-点击位置的x/PreviewLayer的宽度
    CGPoint focusPoint = CGPointMake( point.y /size.height ,1 - point.x/size.width );
    NSError *error;
    if ([self.device lockForConfiguration:&error]) {
        if ([self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            [self.device setFocusPointOfInterest:focusPoint];
            [self.device setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        
        if ([self.device isExposureModeSupported:AVCaptureExposureModeAutoExpose ]) {
            [self.device setExposurePointOfInterest:focusPoint];
            // 曝光量调节
            [self.device setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        
        [self.device unlockForConfiguration];
        self.focusView.center = point;
        self.focusView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.focusView.transform = CGAffineTransformMakeScale(1.25, 1.25);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.focusView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                self.focusView.hidden = YES;
            }];
        }];
    }
}

#pragma mark - 闪光灯
- (void)FlashOn
{
    NSError *error;
    if ([_device lockForConfiguration:&error]) {
        if (_isflashOn) {
            if ([_device isFlashModeSupported:AVCaptureFlashModeOff]) {
                [_device setFlashMode:AVCaptureFlashModeOff];
                _isflashOn = NO;
                //                [_flashButton setTitle:@"闪光灯关" forState:UIControlStateNormal];
            }
        }else{
            if ([_device isFlashModeSupported:AVCaptureFlashModeOn]) {
                [_device setFlashMode:AVCaptureFlashModeOn];
                _isflashOn = YES;
                //                [_flashButton setTitle:@"闪光灯开" forState:UIControlStateNormal];
            }
        }
        [_device unlockForConfiguration];
    }
}

#pragma mark - 切换摄像头

-(void)changeCamera
{
    //获取摄像头的数量
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    //摄像头小于等于1的时候直接返回
    if (cameraCount <= 1) return;
    
    AVCaptureDevice *newCamera = nil;
    AVCaptureDeviceInput *newInput = nil;
    //获取当前相机的方向(前还是后)
    AVCaptureDevicePosition position = [[self.input device] position];
    
    //为摄像头的转换加转场动画
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.5;
    animation.type = @"oglFlip";
    
    if (position == AVCaptureDevicePositionFront) {
        //获取后置摄像头
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
        animation.subtype = kCATransitionFromLeft;
    }else{
        //获取前置摄像头
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
        animation.subtype = kCATransitionFromRight;
    }
    
    [self.previewLayer addAnimation:animation forKey:nil];
    //输入流
    newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
    
    if (newInput != nil) {
        
        [self.session beginConfiguration];
        //先移除原来的input
        [self.session removeInput:self.input];
        
        if ([self.session canAddInput:newInput]) {
            [self.session addInput:newInput];
            self.input = newInput;
            
        } else {
            //如果不能加现在的input，就加原来的input
            [self.session addInput:self.input];
        }
        [self.session commitConfiguration];
    }
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ) return device;
    return nil;
}

#pragma mark - 拍照
/// 拍照
-(void)onTakePicture
{
    AVCaptureConnection * videoConnection = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (videoConnection ==  nil) return;
    __weak typeof(self) weakSelf = self;
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) return;
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage * image = [UIImage imageWithData:imageData];
        [weakSelf openEditToolWithImg:image];
        if ([weakSelf.session isRunning]) {
            [weakSelf.session stopRunning];
        }
    }];
}

#pragma mark - 裁剪图片
/// 裁剪图片
-(void)openEditToolWithImg:(UIImage *)image
{
    WeakSelf;
    ZZImageEditTool *tool = [ZZImageEditTool showViewWithImg:image andSelectClipRatio:0];
    tool.cancelBlock = ^{
        /// 重拍
        [weakSelf onRetake];
    };
    tool.finishBlock = ^(UIImage *image) {
        /// 保存图片
        weakSelf.takedImage = image;
        [weakSelf saveImg];
    };
}

#pragma mark - 打开相册
-(void)openPhotoLibrary
{
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    // 在内部显示拍照按钮
    imagePickerVC.allowTakePicture = false;
    // 设置是否可以选择视频
    imagePickerVC.allowPickingVideo = false;
    imagePickerVC.autoDismiss = false;
    
    WeakSelf;
    __weak typeof(imagePickerVC) weakVC = imagePickerVC;
    [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [weakSelf openEditToolWithImg:photos.lastObject];
        [weakVC dismissViewControllerAnimated:true completion:nil];
    }];
    
    [imagePickerVC setImagePickerControllerDidCancelHandle:^{
        [weakVC dismissViewControllerAnimated:true completion:nil];
    }];
    
    [self presentViewController:imagePickerVC animated:true completion:nil];
}

/// 保存图片
-(void)saveImg
{
    NSLog(@"保存图片");
    [self onRetake];
}

//重新拍照或录制
- (void)onRetake
{
    [self.session startRunning];
    [self focusAtPoint:self.view.center];
    
    /// 摄像头缩放
    NSError *error = nil;
    [self.device lockForConfiguration:&error];
    if (!error) {
        self.device.videoZoomFactor = 1.0f;
        [self.device unlockForConfiguration];
    }
}

- (void)dealloc
{
    if ([_session isRunning]) {
        [_session stopRunning];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
