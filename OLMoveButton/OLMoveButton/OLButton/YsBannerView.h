//
//  YsBannerView.h
//  YsBannerView
//
//  Created by weiying on 16/2/29.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BannerMenuDelegate <NSObject>

- (void)barnerMenuClicked;

@end

@interface YsBannerView : UIView

@property (nonatomic, assign) id<BannerMenuDelegate> delegate;
@end
