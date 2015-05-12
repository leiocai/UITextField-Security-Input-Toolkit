//
//  InputSecuriyView.h
//  payViewDemo
//
//  Created by Alex cai on 15/5/12.
//  Copyright (c) 2015年 Alex cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol inputSecuriytViewDelegate <NSObject>

/**
 *  输入完成后,调用此方法
 *
 *  @param password 用户输入的内容
 */
- (void)inputSecurityDidFinished:(NSString *)password;

@end


@interface InputSecurityView : UIView

@property (nonatomic, assign) id <inputSecuriytViewDelegate>delegate;

@end
