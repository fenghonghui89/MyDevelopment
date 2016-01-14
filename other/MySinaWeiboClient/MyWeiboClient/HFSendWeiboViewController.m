//
//  HFSendWeiboViewController.m
//  MyWeiboClient
//
//  Created by hanyfeng on 14-9-10.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFSendWeiboViewController.h"
#import "HFButton.h"
#define keyboardHight 216 //键盘高度
#define eachPageFacesCount 28 //每页的表情数
@interface HFSendWeiboViewController ()<UITextViewDelegate>
@property(nonatomic,retain)UIScrollView *imagesSV;
@property(nonatomic,retain)UIView *toolView;
@property(nonatomic,retain)UITextView *textView;
@property(nonatomic,retain)UIScrollView *facesSV;

@property(nonatomic,strong)NSArray* faces;
@end

@implementation HFSendWeiboViewController

#pragma mark - vc life
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
    [self addobserver];
    [self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - notification
-(void)addobserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - UI/frame

-(void)initNavi
{
    self.navigationItem.title = @"发表微博";
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 25, 34)];
    [cancleBtn setTintColor:[UIColor whiteColor]];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setBackgroundColor:[UIColor grayColor]];
    [cancleBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [cancleBtn addTarget:self action:@selector(cancleBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:cancleBtn];
    
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(UIScreen_Width - 30, 5, 25, 34)];
    [sendBtn setTintColor:[UIColor whiteColor]];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setBackgroundColor:[UIColor grayColor]];
    [sendBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [sendBtn addTarget:self action:@selector(sendBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:sendBtn];
}

-(void)initUI
{
    [self initNavi];
    
    UIScrollView *imagesSV = [[UIScrollView alloc] init];
    [imagesSV setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:imagesSV];
    self.imagesSV = imagesSV;
    [imagesSV release];
    
    UIView *toolView = [[UIView alloc] init];
    [toolView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:toolView];
    self.toolView = toolView;
    [toolView release];
    
    NSArray *btnImagesNames = @[@"compose_locatebutton_background.png",
                              @"compose_camerabutton_background.png",
                              @"compose_trendbutton_background.png",
                              @"compose_mentionbutton_background.png",
                              @"compose_emoticonbutton_background.png",
                              @"compose_keyboardbutton_background.png"];
    NSArray *btnHimagesNames = @[@"compose_locatebutton_background_highlighted.png",
                                 @"compose_camerabutton_background_highlighted.png",
                                 @"compose_trendbutton_background_highlighted.png",
                                 @"compose_mentionbutton_background_highlighted.png",
                                 @"compose_emoticonbutton_background_highlighted.png",
                                 @"compose_keyboardbutton_background_highlighted.png"];
    for (int i = 0; i<6; i++) {
        HFButton *btn = [[HFButton alloc] initWithFrame:CGRectMake(26+i*49, 0, 23, 19) andImageName:btnImagesNames[i] andHImageName:btnHimagesNames[i]];
        btn.tag = i;
        [btn addTarget:self action:@selector(toolBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.toolView addSubview:btn];
        [btn release];
    }
    
    UITextView *textView = [[UITextView alloc] init];
    textView.delegate = self;
    [textView setBackgroundColor:[UIColor greenColor]];
    [textView setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:textView];
    self.textView = textView;
    [textView release];
    
    [self initFrame];
//    [self initFaces];
}

-(void)initFaces
{
    //读取表情的plist文件
    NSString *facePlistPath = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    self.faces = [NSArray arrayWithContentsOfFile:facePlistPath];
    
    //创建scrollView
    self.facesSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, UIScreen_Height, UIScreen_Width, keyboardHight)];
    [self.facesSV setBackgroundColor:[UIColor whiteColor]];
    [self.facesSV setContentSize:CGSizeMake(4*UIScreen_Width, keyboardHight)];
    
    //加入表情
    for (int i = 1 ; i<self.faces.count-1; i++) {
        NSString* faceName = [NSString stringWithFormat:@"%03d.png",i];
        UIImage* faceImage = [HFCommon getImagePathWithDirectoryName:@"face" andImageName:faceName];
        UIButton* face = [[UIButton alloc] initWithFrame:CGRectMake(5+(i-1)%eachPageFacesCount*(15+30), 19+(i-1)/eachPageFacesCount*(15+30), 30, 30)];
        face.tag = i;
        [face addTarget:self action:@selector(clickedFace:) forControlEvents:UIControlEventTouchUpInside];
        [face setBackgroundImage:faceImage forState:UIControlStateNormal];
        [self.facesSV addSubview:face];
    }
    
    [self.view addSubview:self.facesSV];
}

-(void)initFrame
{
    [self.textView setFrame:CGRectMake(0, 0, UIScreen_Width,UIScreen_Height - 19 - 80 - 44)];
    [self.toolView setFrame:CGRectMake(0, UIScreen_Height - 44 - 19, UIScreen_Width, 19)];
    [self.imagesSV setFrame:CGRectMake(0, self.toolView.frame.origin.y - 80, UIScreen_Width, 80)];
}

#pragma mark - actions
-(void)cancleBtnPress
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendBtnPress
{

    
}

-(void)toolBtnPress:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            if ([self.textView isFirstResponder]) {
                [self.textView resignFirstResponder];
            }else{
                [self.textView becomeFirstResponder];
            }
            
            break;
        default:
            break;
    }
}

-(void)clickedFace:(UIButton*)sender
{
    for (NSDictionary* dic in self.faces) {
        NSArray* arr = [(NSString*)[dic objectForKey:@"png"] componentsSeparatedByString:@"."];
        int faceTage = [(NSString*)arr[0] intValue];
        if (faceTage == sender.tag) {
            
            //获得光标的位置
            NSRange range = [self.textView selectedRange];
            int textViewLocation  = range.location;
            
            //拼接字符串
            NSString* textViewText = self.textView.text;
            NSString* faceString = [dic objectForKey:@"chs"];
            textViewText = [NSString stringWithFormat:@"%@%@%@",[textViewText substringToIndex:textViewLocation],faceString,[textViewText substringFromIndex:textViewLocation]];
            self.textView.text = textViewText;
            
            //把光标移动到表情后面
            NSUInteger length = range.location + [faceString length];
            self.textView.selectedRange = NSMakeRange(length,0);
        }
    }
}

-(void)keyboardWillShowOrHide:(NSNotification *)notification
{
    //把键盘坐标系从window转到指定view
    NSDictionary *info = notification.userInfo;
    NSValue *value = info[UIKeyboardFrameEndUserInfoKey];
    CGRect frameOfKeyboard = [value CGRectValue];
    UIWindow * window =[[[UIApplication sharedApplication] delegate] window];
    frameOfKeyboard =[self.view convertRect:frameOfKeyboard fromView:window];
    
    //获取键盘时间和动画效果
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey]unsignedIntegerValue];
    
    //修改坐标
    [UIView animateWithDuration:duration delay:0.0 options:options animations:nil completion:^(BOOL finished) {
        CGRect toolViewFrame = self.toolView.frame;
        toolViewFrame.origin.y = frameOfKeyboard.origin.y - self.toolView.frame.size.height;
        self.toolView.frame = toolViewFrame;
        
        CGRect imagesSVFrame = self.imagesSV.frame;
        imagesSVFrame.origin.y = self.toolView.frame.origin.y - self.imagesSV.frame.size.height;
        self.imagesSV.frame = imagesSVFrame;
        
        CGRect textViewFrame = self.textView.frame;
        textViewFrame.size.height = self.imagesSV.frame.origin.y;
        self.textView.frame = textViewFrame;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    
}

//#pragma mark - textview delegate
//-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
//{
//    [self.textView becomeFirstResponder];
//    return YES;
//}

@end
