//
//  XRTOrderTrackingLayout.m
//  Etion
//
//  Created by wyy on 2017/6/5.
//  Copyright © 2017年 GuangZhouXuanWu. All rights reserved.
//

#import "XRTOrderTrackingLayout.h"
#import "NSObject+Calculate.h"

#define kScreenHeigth [UIApplication sharedApplication].keyWindow.frame.size.height
#define kScreenWidth  [UIApplication sharedApplication].keyWindow.frame.size.width
static const CGFloat LableDefaultHeight = 15.0f;
@implementation XRTOrderTrackingLayout
- (instancetype)initWithModel:(XRTOrderTrackingModel *)model {
    self = [super init];
    if (self) {
        _foldType = XRTOrderTackingFoldClosed;
        _model = model;
        [self layoutWithModel:model];
    }
    return self;
}

- (void)layoutWithModel:(XRTOrderTrackingModel *)model {
    self.horizontalDistance = 10.0;
    self.verticalDistance = 10.0;
    self.distacneToLeft = 20.0f;
    self.totalHeight = 0.0;
    self.nameLabelFont = 14.0f;
    self.orderStatusLableFont = 14.0f;
    self.orderTimeLableFont = 14.0f;
    self.failedReasonLableFont = 14.0f;
    
    self.imageViewSize = CGSizeMake(20.0, LableDefaultHeight);
    self.nameLabelSize = CGSizeMake([NSObject widthFromString:model.customerName withFont:[UIFont systemFontOfSize:self.nameLabelFont] constraintToHeight:15.0], LableDefaultHeight);
    self.orderStatusLableSize = CGSizeMake(kScreenWidth - self.distacneToLeft - self.nameLabelSize.width - 3 * self.horizontalDistance - self.imageViewSize.width , LableDefaultHeight);
    self.orderTimeLableSize = CGSizeMake(kScreenWidth - self.distacneToLeft, 10.0);
    self.failedReasonLableSize = CGSizeMake(0, LableDefaultHeight);
    
    //计算
    self.totalHeight += self.verticalDistance;
    self.totalHeight += self.nameLabelSize.height;
    self.totalHeight += self.verticalDistance;
    self.totalHeight += self.orderTimeLableSize.height;
    self.totalHeight += self.verticalDistance;
    
    self.failedReasonLableSize = CGSizeMake(kScreenWidth - self.distacneToLeft - self.horizontalDistance, [NSObject heightFromString:model.failedReason withFont:[UIFont systemFontOfSize:self.failedReasonLableFont] constraintToWidth:kScreenWidth - self.distacneToLeft - self.horizontalDistance]);
    self.totalHeight += self.failedReasonLableSize.height;
    self.totalHeight += self.verticalDistance;
}
@end
