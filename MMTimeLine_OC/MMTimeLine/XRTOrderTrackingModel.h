//
//  XRTOrderTrackingModel.h
//  Etion
//
//  Created by wyy on 2017/6/5.
//  Copyright © 2017年 GuangZhouXuanWu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XRTOrderTrackingModel : NSObject
@property (nonatomic, copy) NSString *customerName;
@property (nonatomic, copy) NSString *orderTime;
@property (nonatomic, copy) NSString *orderStatus;
@property (nonatomic, copy) NSString *failedReason;
@property (nonatomic, assign) BOOL isAlreadyLoadLine;
@end
