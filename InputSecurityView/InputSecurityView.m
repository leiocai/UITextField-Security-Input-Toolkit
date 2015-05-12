//
//  InputSecuriyView.m
//  payViewDemo
//
//  Created by Alex cai on 15/5/12.
//  Copyright (c) 2015年 Alex cai. All rights reserved.
//

#import "InputSecurityView.h"


#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 文本输入位数限定
static const int COUNT_NMUBER = 6;


@interface InputSecurityView()<UITextFieldDelegate>


/**
 *  密码输入记录索引
 */
@property (nonatomic ,assign) __block NSInteger passwordFlagIndex;

/**
 *  密码遮罩
 */
@property (nonatomic, weak) UIView *inputMaskview;

/**
   输入TextField
 */
@property (nonatomic, weak) UITextField *inputTextField;
@end


@implementation InputSecurityView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupMaskviewWithFram:frame];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setupMaskviewWithFram:(CGRect)frame{
    
    // 添加密码输入框
    UITextField *passTextfield = [[UITextField alloc]initWithFrame:frame];
    self.inputTextField = passTextfield;
    passTextfield.autocorrectionType = UITextAutocorrectionTypeNo;
     passTextfield.delegate = self;
    passTextfield.keyboardType = UIKeyboardTypeASCIICapable;
    [passTextfield addTarget:self action:@selector(textfieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:passTextfield];
    // 添加遮罩view
    UIView *maskView               = [[UIView alloc]initWithFrame:frame];
    maskView.layer.cornerRadius    = 5;
    maskView.clipsToBounds         = YES;
    maskView.layer.borderColor     = [UIColorFromRGB(0xd7d7d7) CGColor];
    maskView.layer.borderWidth     = 1;
    maskView.layer.backgroundColor = [[UIColor whiteColor]CGColor];
    [self addSubview:maskView];
    // 添加分割线
    for (int index = 0; index < COUNT_NMUBER - 1; index ++) {
        CGFloat verX = (self.bounds.size.width / COUNT_NMUBER) *(index + 1);
        UIView *verLine = [[UIView alloc]initWithFrame:CGRectMake(verX, 0, 1, 50)];
        verLine.backgroundColor = UIColorFromRGB(0xd7d7d7);
        [maskView addSubview:verLine];
    }
    self.inputMaskview = maskView;
    // 弹出键盘
    [passTextfield becomeFirstResponder];
}

- (void)textfieldChanged:(UITextField *)textField{
    
    if (self.passwordFlagIndex > textField.text.length ) {
        UIView *del = self.inputMaskview.subviews.lastObject;
        [del removeFromSuperview];
        self.passwordFlagIndex = textField.text.length;
        return;
    }
    if (textField.text.length <= COUNT_NMUBER) {
        CGFloat dotX = (textField.text.length - 1) * (self.inputMaskview.frame.size.width / COUNT_NMUBER) +(self.inputMaskview.frame.size.width / (COUNT_NMUBER *2)) - 4;
        CGFloat dotY = self.inputMaskview.frame.size.height * 0.43;
        UIView *dotView = [[UIView alloc]initWithFrame:CGRectMake(dotX, dotY, 10,10)];
        dotView.backgroundColor = UIColorFromRGB(0xee4d5e);
        dotView.layer.cornerRadius = 5;
        [self.inputMaskview addSubview:dotView];
        self.passwordFlagIndex = textField.text.length;
        if (self.passwordFlagIndex == COUNT_NMUBER)
        {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{[NSThread sleepForTimeInterval:0.3];dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.delegate respondsToSelector:@selector(inputSecurityDidFinished:)]) {
                    [self.delegate inputSecurityDidFinished:textField.text ];
                    return ;
                }
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"你输入的内容是" message:textField.text delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
                [alert show];
                });
            });
        }
    }
}

#pragma mark - UITextfield 代理方法,用来限制文本输入位数(本例子中限制为6)
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.inputTextField) {
        if (string.length == 0) return YES;
        if (textField.text.length >= 6) return NO;
    }
    
    return YES;
}

@end
