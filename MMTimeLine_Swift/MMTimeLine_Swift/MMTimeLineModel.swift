//
//  XRTTimeLineModel.swift
//  MMTimeLine_Swift
//
//  Created by wyy on 2017/6/8.
//  Copyright © 2017年 wyy. All rights reserved.
//

import UIKit

class MMTimeLineModel: NSObject {
    var iscellAlreadyLoad = false
    var orderTime: NSString
    var textContent: NSString
    
    init(_ orderTime: NSString, _ textContent: NSString) {
        self.orderTime = orderTime
        self.textContent = textContent
    }
}
