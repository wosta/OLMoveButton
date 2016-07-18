//
//  OLMoveMenu.h
//  OLMoveMenu
//
//  Created by olive on 16/7/13.
//  Copyright © 2016年 olive. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OLMoveMenuDelegate <NSObject>

- (void)moveMenuClicked;

@end

@interface OLMoveMenu : UIView

/**
 *  拖拽后是否自动返回两侧
 */
@property (nonatomic, assign) BOOL isAutoBack;
/** delegate */
@property (nonatomic, assign) id<OLMoveMenuDelegate> delegate;
@end
