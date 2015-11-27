//
//  CloudView.h
//  Test
//
//  Created by zhangmh on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
/*
 1. 将CloudView类和CloudButton类的.h和.m文件导入你的工程中 
 
 2. 在你的类中导入CloudView的.h文件 #import "CloudView.h"
 
 3. 在你的类里面实现CloudView类的CloudViewDelegate 方法
 
 4. 参考如下实例化代码
 
         CloudView *cloud = [[CloudView alloc] initWithFrame:self.view.bounds
         andNodeCount:100];
         
         cloud.delegate = self;
         [self.view addSubview:cloud];
         [cloud release];
 
 */
#import <UIKit/UIKit.h>

#import "CloudButton.h"

@protocol CloudViewDelegate

- (void)didSelectedNodeButton:(CloudButton *)button;

@end

@interface CloudView : UIView
{
    NSTimer *animationTimer;
    CGPoint oldtouchPoint;
    
    CGFloat speedMAX;
    CGFloat speedMIN;
   
}

- (id)initWithFrame:(CGRect)frame 
       andNodeCount:(NSInteger)nodeCount;

@property (nonatomic, assign) id<CloudViewDelegate>delegate;



@end
