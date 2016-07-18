//
//  OLMoveView.h
//  OLMoveView
//
//  Created by weiying on 16/2/29.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OLMoveViewDelegate <NSObject>

- (void)moveViewClicked;

@end

@interface OLMoveView : UIView
/**
 *  拖拽后是否自动返回两侧
 */
@property (nonatomic, assign) BOOL isAutoBack;

@property (nonatomic, assign) id<OLMoveViewDelegate> delegate;
@end
