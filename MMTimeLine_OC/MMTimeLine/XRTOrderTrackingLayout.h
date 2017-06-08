//
//  XRTOrderTrackingLayout.h
//  Etion
//
//  Created by wyy on 2017/6/5.
//  Copyright © 2017年 GuangZhouXuanWu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRTOrderTrackingModel.h"
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, XRTOrderTrackingFoldType) {//折叠状态
    XRTOrderTackingFoldClosed = 0,                     //默认
    XRTOrderTrackingFoldOpen = 1
};

@interface XRTOrderTrackingLayout : NSObject
@property (nonatomic, assign) CGSize nameLabelSize;
@property (nonatomic, assign) CGSize orderStatusLableSize;
@property (nonatomic, assign) CGSize orderTimeLableSize;
@property (nonatomic, assign) CGSize failedReasonLableSize;
@property (nonatomic, assign) CGSize imageViewSize;

@property (nonatomic, assign) CGFloat horizontalDistance;
@property (nonatomic, assign) CGFloat distacneToLeft;
@property (nonatomic, assign) CGFloat verticalDistance;
@property (nonatomic, assign) CGFloat totalHeight;

@property (nonatomic, assign, readonly) XRTOrderTrackingFoldType foldType;
@property (nonatomic, assign) CGFloat nameLabelFont;
@property (nonatomic, assign) CGFloat orderStatusLableFont;
@property (nonatomic, assign) CGFloat orderTimeLableFont;
@property (nonatomic, assign) CGFloat failedReasonLableFont;

@property (nonatomic, strong) XRTOrderTrackingModel *model;

- (instancetype)initWithModel:(XRTOrderTrackingModel *)model;
@end
