//
//  XRTOrderTrackingModel.m
//  Etion
//
//  Created by wyy on 2017/6/5.
//  Copyright © 2017年 GuangZhouXuanWu. All rights reserved.
//

#import "XRTOrderTrackingModel.h"

@implementation XRTOrderTrackingModel
- (instancetype)init {
    if (self) {
        self.customerName = @"鲁有脚";
        self.orderStatus = @"星期一";
        self.orderTime = @"2017-03-02 14:00";
        self.failedReason = @"价格按照公司统一规定";
    }
    return self;
}
@end
