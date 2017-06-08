//
//  MMTimeLineLayout.swift
//  MMTimeLine_Swift
//
//  Created by wyy on 2017/6/8.
//  Copyright © 2017年 wyy. All rights reserved.
//

import UIKit

extension String {
        func heightWithConstraintWidth(constraintWidth: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: constraintWidth, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }
}

class MMTimeLineLayout: NSObject {
    var timeLabelRect = CGRect.zero
    var contentLabelRect = CGRect.zero
    var totalHeight: CGFloat = 0.0
    let timeLabelFont: CGFloat = 12.0
    let contentLableFont: CGFloat = 14.0
    var linePositionX: CGFloat = 0.0
    let verticalDistance: CGFloat = 15.0
    let horizontalDistance: CGFloat = 15.0
    let model: MMTimeLineModel
    
    public init(model: MMTimeLineModel) {
        self.model = model
        super.init();
        self.layoutWithModel(model: model)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutWithModel(model: MMTimeLineModel) {
        
        let timeLabelWidth: CGFloat = 60.0
        
        timeLabelRect = CGRect(x: horizontalDistance, y: verticalDistance, width: timeLabelWidth, height: 20.0)
        let contentLabelWidth = kScreenWidth - timeLabelRect.size.width - 3 * horizontalDistance
        let contentLabelHeight = (model.textContent as String).heightWithConstraintWidth(constraintWidth: contentLabelWidth, font: UIFont.systemFont(ofSize: contentLableFont)) + 10.0
        
        contentLabelRect = CGRect(x: timeLabelRect.size.width + 2 * horizontalDistance, y: verticalDistance, width: contentLabelWidth, height: contentLabelHeight)
        
        linePositionX = horizontalDistance + timeLabelWidth + horizontalDistance/2
        //计算高度
        totalHeight += verticalDistance
        totalHeight += max(timeLabelRect.size.height, contentLabelRect.size.height)
        totalHeight += verticalDistance
    }
    
}



