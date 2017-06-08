//
//  MMTimeLineCell.swift
//  MMTimeLine_Swift
//
//  Created by wyy on 2017/6/8.
//  Copyright © 2017年 wyy. All rights reserved.
//

import UIKit

protocol MMTimeLineCellDelegate {
    func orderTrackingCellDidFnishedLoad(cell: MMTimeLineCell)
}

class MMTimeLineCell: UITableViewCell {
    let blueColor = UIColor.init(red: 82.0/255.0, green: 116.0/255.0, blue: 188.0/255.0, alpha: 1.0)
    let timeLabel = UILabel()
    let contentLabel = UILabel();
    var lineLayer = CAShapeLayer()
    var layout: MMTimeLineLayout?
    var delegate: MMTimeLineCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.timeLabel.frame = (self.layout?.timeLabelRect)!
        self.contentLabel.frame = (self.layout?.contentLabelRect)!
        
        //已经加载过了，防止复用，重复动画
        if (layout?.model.iscellAlreadyLoad)! {
            self.lineLayer.path = animationPath()
        } else {
            animationLayer()
            delegate?.orderTrackingCellDidFnishedLoad(cell: self)
        }
    }
    
    func setUpView() {
       timeLabel.textColor = UIColor.black
       timeLabel.textAlignment = .right
       contentView.addSubview(timeLabel)
        
       contentLabel.numberOfLines = 0
       contentLabel.backgroundColor = blueColor
       contentLabel.textColor = UIColor.white
       contentView.addSubview(contentLabel)
        
       lineLayer.fillColor = UIColor.clear.cgColor
       lineLayer.strokeColor = blueColor.cgColor
       lineLayer.lineWidth = 1.0
       lineLayer.autoreverses = false
       contentView.layer.addSublayer(lineLayer)
    }
    
    func configurationCell(layout: MMTimeLineLayout) {
        self.layout = layout
        timeLabel.font = UIFont.systemFont(ofSize: layout.timeLabelFont)
        contentLabel.font = UIFont.systemFont(ofSize: layout.contentLableFont)
        timeLabel.text = layout.model.orderTime as String
        contentLabel.text = layout.model.textContent as String
    }
    
//MARK -- CAShapeLayer
    func animationPath() -> CGPath {
         let point_x = (self.layout?.linePositionX)!
        
         let bezierPath = UIBezierPath()
         bezierPath.move(to: CGPoint(x: point_x, y: 0))
        
         let point_y = ((self.layout?.timeLabelRect.size.height)!/2) + (self.layout?.verticalDistance)!
        
         let radius: CGFloat = 3.0
         bezierPath.addLine(to: CGPoint(x: (self.layout?.linePositionX)!, y: point_y - radius))
        
         bezierPath.addArc(withCenter: CGPoint(x: point_x, y: point_y), radius: radius, startAngle: degreesToRadian(-90), endAngle: degreesToRadian(450), clockwise: true)
        
         bezierPath.addLine(to: CGPoint(x: point_x, y: (self.layout?.totalHeight)!))
         print((self.layout?.totalHeight)!)
         return bezierPath.cgPath
        
    }
    
    func degreesToRadian(_ degrees: CGFloat) -> CGFloat {
        return (CGFloat.pi * degrees) / 180.0
    }
    
    func animationLayer() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = AnimationDuring
        self.lineLayer.path = animationPath()
        self.lineLayer.add(animation, forKey: nil)
    }
   
}
