//
//  OLMoveView.m
//  OLMoveView
//
//  Created by olive on 16/2/29.
//  Copyright © 2016年 olive. All rights reserved.
//

#import "OLMoveView.h"

@interface OLMoveView ()
@property (nonatomic, strong) UIView *bannerImgV;

@property (nonatomic, assign) CGFloat supWidth;
@property (nonatomic, assign) CGFloat supHeihgt;
@property (nonatomic, assign) BOOL    isMove;
/**
 *  按钮距离中心点x的距离
 */
@property (nonatomic, assign, readwrite) CGFloat pointToCenterX;
/**
 *  按钮距离中心点y的距离
 */
@property (nonatomic, assign, readwrite) CGFloat pointToCenterY;
@end

@implementation OLMoveView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isMove = NO;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
        
        UIImageView *bannerImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        bannerImgV.userInteractionEnabled = YES;
        bannerImgV.backgroundColor = [UIColor greenColor];
        bannerImgV.image = [UIImage imageNamed:@"icon_banner_normal"];
        [self addSubview:bannerImgV];
        self.bannerImgV = bannerImgV;
    }
    return self;
}

/**
 *  手指按下开始触摸
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /**
     *  获得触摸在按钮的父视图中的坐标
     */
    if (!self.isAutoBack) {
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:self.superview];
        self.pointToCenterX = self.center.x - currentPoint.x;
        self.pointToCenterY = self.center.y - currentPoint.y;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isAutoBack) {
        UITouch *touch = [touches anyObject];
        CGPoint movedPoint = [touch locationInView:[self superview]];
        [self setCenter:movedPoint];
    }else {
        /**
         *  获得触摸在按钮的父视图中的坐标
         */
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:self.superview];
        
        /**
         *  移动按钮到当前触摸位置
         */
        CGPoint newCenter = CGPointMake(currentPoint.x + self.pointToCenterX, currentPoint.y + self.pointToCenterY);
        
        CGFloat superViewWidth = CGRectGetWidth([self superview].frame);
        CGFloat superViewHeight = CGRectGetHeight([self superview].frame);
        CGFloat selfWidth = CGRectGetWidth(self.frame);
        CGFloat selfHeight = CGRectGetHeight(self.frame);
        
        if (newCenter.x > (superViewWidth-selfWidth)) {
            newCenter.x = superViewWidth-selfWidth;
        }
        if (newCenter.y > (superViewHeight-selfHeight)) {
            newCenter.y = superViewHeight-selfHeight;
        }
        if (newCenter.x < selfWidth) {
            newCenter.x = selfWidth;
        }
        if (newCenter.y < selfHeight) {
            newCenter.y = selfHeight;
        }
        
        //        NSLog(@"newCenter x = %f , newCenter y = %f",newCenter.x,newCenter.y);
        self.center = newCenter;
    }
    self.isMove = YES;}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.isAutoBack) {
        float x = self.center.x;
        float y = self.center.y;
        CGPoint newPoint = CGPointZero;
        newPoint.x = x;
        newPoint.y = y;
        //判断位置是在左边还是在右边(0代表左边，1代表右边)
        NSInteger lactionTag = 0;
        if (x < ([self superview].frame.size.width)/2){
            lactionTag = 0;
        }else{
            lactionTag = 1;
        }
        //重新设置XY值
        switch (lactionTag) {
            case 0:
                newPoint.x = 0 + self.frame.size.height/2;
                break;
            case 1:
                newPoint.x = [self superview].frame.size.width - self.frame.size.width/2;
                break;
        }
        //对view赋值
        [UIView animateWithDuration:0.1 animations:^{
            [self setCenter:newPoint];
        }];
    }
    if (!self.isMove) {
        // 被点击了
        if (self.delegate && [self.delegate respondsToSelector:@selector(moveViewClicked)]) {
            [self.delegate moveViewClicked];
        }
    }
    self.isMove = NO;}

- (void)deviceOrientationDidChange:(NSNotification *)notification
{
    self.supWidth = [self superview].frame.size.width;
    self.supHeihgt = [self superview].frame.size.height;
}


@end
