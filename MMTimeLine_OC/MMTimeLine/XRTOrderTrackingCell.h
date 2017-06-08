//
//  XRTOrderTrackingCell.h
//  Etion
//
//  Created by wyy on 2017/6/5.
//  Copyright © 2017年 GuangZhouXuanWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRTOrderTrackingLayout.h"
#define  AnimationTime .5

@protocol  XRTOrderTrackingCellDelegate;
@interface XRTOrderTrackingCell : UITableViewCell
@property (nonatomic, strong) XRTOrderTrackingLayout *layout;
@property (nonatomic, weak) id<XRTOrderTrackingCellDelegate> delegate;
@end

@protocol  XRTOrderTrackingCellDelegate <NSObject>
- (void)orderTrackingCellDidFnishedLoad:(XRTOrderTrackingCell *)cell;
@end
