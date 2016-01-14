//
//  PPSecretQuestionAnswerView.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-1.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPBaseView.h"
#import "PPDropDownView.h"
#import "PPMBProgressHUD.h"
#import "PPSecretQuestionsView.h"
#import "PPWebViewData.h"
#import "PPPasswordProtectionView.h"

@interface PPSecretQuestionAnswerView : PPBaseView //PPBaseView <UIGestureRecognizerDelegate,UITextFieldDelegate>
<
PPWebViewDataDelegate,
PPDropDownViewDelegate
>

{
    UIImageView *_questionImageView1;
    UIImageView *_answerImageView1;
    UIImageView *_questionImageView2;
    UIImageView *_answerImageView2;
    
    UILabel *_questionLabel1;
    UILabel *_answerLabel1;
    UILabel *_questionLabel2;
    UILabel *_answerLabel2;
    
    UITextField *_questionTextField1;
    UITextField *_questionTextField2;
    UITextField *_answerTextField1;
    UITextField *_answerTextField2;
    
    PPDropDownView *_questionDropDownView1;
    PPDropDownView *_questionDropDownView2;
    
    UIButton *_commitButton;
    PPMBProgressHUD *ppMBProgressHUD;
    UIButton *_listQuestionBtn1;
    UIButton *_listQuestionBtn2;
    NSMutableArray *_questionArray;
}


@property (nonatomic, assign) BOOL isUpdate;
@property (nonatomic, assign) int question1;
@property (nonatomic, assign) int question2;

@property (nonatomic, retain) NSString *questionStr1;
@property (nonatomic, retain) NSString *questionStr2;

@property (nonatomic, assign) PPVerificationMode nextView;




/// <summary>
/// 密保问题验证页面从右边展示
/// </summary>
/// <returns>无返回</returns>
-(void)showSecretQuestionsAnswerViewByRight;


///// <summary>
///// 密保问题验证页面从左边展示
///// </summary>
///// <returns>无返回</returns>
//-(void)showSecretQuestionsAnswerViewByLeft;
@end
