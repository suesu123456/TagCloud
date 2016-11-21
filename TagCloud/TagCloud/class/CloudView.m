//
//  CloudView.m
//  Test
//
//  Created by zhangmh on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CloudView.h"

@interface CloudView()

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;

- (void)animationUpdate;


- (CGFloat)limitSpeedbettowinMINandMAX:(CGFloat)speedValue;
@end

@implementation CloudView

@synthesize delegate;

@synthesize top;
@synthesize bottom;
@synthesize left;
@synthesize right;


#pragma mark -
#pragma mark --初始化方法--
- (id)initWithFrame:(CGRect)frame andNodeCount:(NSInteger)nodeCount andPersonArray: (NSArray*)persons
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGSize nodeSize = CGSizeMake(60, 60);
        
        speedMAX      =  2.0f;//最大移动速度 
        speedMIN      = -2.0f;//最小移动速度 
        
        self.left     = frame.origin.x - nodeSize.width;
        self.right    = frame.origin.x + frame.size.width;
        self.top      = frame.origin.y - nodeSize.height;
        self.bottom   = frame.origin.y + frame.size.height;
        
        oldtouchPoint = CGPointMake(-1000, -1000);
        
        for (NSInteger i = 0;i < nodeCount; i ++) {
            
            CGFloat x = arc4random()%(int)(self.right  - nodeSize.width);
            CGFloat y = arc4random()%(int)(self.bottom - nodeSize.height);
            
            CloudButton *cloudButton = [[CloudButton alloc] initWithFrame:CGRectMake(x,
                                                                                     y,
                                                                                     nodeSize.width,
                                                                                     nodeSize.height)];

            cloudButton.tag = i;
            cloudButton.userInteractionEnabled = NO;
            
            [cloudButton setTitle: persons[i][0]
                         forState:UIControlStateNormal];
            
            [cloudButton setBackgroundImage:persons[i][1] forState: UIControlStateNormal];
            [cloudButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 50, 0)];
            [cloudButton addTarget:delegate
                            action:@selector(didSelectedNodeButton:)
                  forControlEvents:UIControlEventTouchUpInside];
            
            float fontSize = arc4random()%20+8;
            
            cloudButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
            cloudButton.alpha = fontSize/25;
            
            NSLog(@"%d.alpha==%f",i,cloudButton.alpha);
            
            [self addSubview:cloudButton];
            
        }
        
        animationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0
                                                          target:self 
                                                        selector:@selector(animationUpdate) 
                                                        userInfo:nil 
                                                         repeats:YES];
        [animationTimer setFireDate:[NSDate distantPast]];
    }
    return self;
}

#pragma mark -
#pragma mark --触摸事件--
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *theTouch = [touches anyObject];
    CGPoint currentPoint = [theTouch  locationInView:self];
    oldtouchPoint = CGPointMake(currentPoint.x, currentPoint.y);
    
    for (int i=0; i<self.subviews.count; i++) {
        CloudButton *cloud = [self.subviews objectAtIndex:i];
        cloud.userInteractionEnabled = NO;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *theTouch = [touches anyObject];
    CGPoint currentPoint = [theTouch  locationInView:self];
    if (oldtouchPoint.x != -1000 && oldtouchPoint.y != -1000) {    
        
        for (int i=0; i<self.subviews.count; i++) {
            CloudButton *cloud = [self.subviews objectAtIndex:i];
            
            cloud.distanceX = [self limitSpeedbettowinMINandMAX:(currentPoint.x - oldtouchPoint.x)];
            
            cloud.distanceY = [self limitSpeedbettowinMINandMAX:(currentPoint.y - oldtouchPoint.y)];
            
            CGFloat distance = sqrt(cloud.distanceX*cloud.distanceX+
                                    cloud.distanceY*cloud.distanceY);
            if (distance!=0) {

                if (0.001 <= cloud.acceleration) {
                    cloud.acceleration = (arc4random()%100)/200.0f;
                }
                
            }
            
        }
    } 
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (int i=0; i<self.subviews.count; i++) {
        CloudButton *cloud = [self.subviews objectAtIndex:i];
        cloud.userInteractionEnabled = YES;
    }
}
#pragma mark -

#pragma mark -
#pragma mark --动画事件--
- (void)animationUpdate
{
    for (int i=0; i<self.subviews.count; i++) {
        
		CloudButton *cloud = [self.subviews objectAtIndex:i];
        
        cloud.center = CGPointMake(cloud.center.x + cloud.distanceX*cloud.acceleration,
                                   cloud.center.y + cloud.distanceY*cloud.acceleration);
        if (cloud.center.x < self.left) {
            cloud.center = CGPointMake(self.right,self.bottom - cloud.center.y);
        }

        if (cloud.center.x > self.right) {
            cloud.center = CGPointMake(self.left, self.bottom - cloud.center.y);
        }
        
        if (cloud.center.y < self.top){
            cloud.center = CGPointMake(self.right - cloud.center.x, self.bottom);
        }
        
        if (cloud.center.y > self.bottom) {

            cloud.center = CGPointMake(self.right - cloud.center.x, self.top);
        }
        
        cloud.acceleration -= 0.001;

        if (cloud.acceleration < 0.001) {
            cloud.acceleration = 0.001;
        }
            
    }
}



- (CGFloat)limitSpeedbettowinMINandMAX:(CGFloat)speedValue
{
    if (speedValue > speedMAX) {
        speedValue = speedMAX;
    }
    
    if (speedValue < speedMIN) {
        speedValue = speedMIN;
    }
    
    return speedValue;
}
#pragma mark -
#pragma mark -
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
