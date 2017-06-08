//
//  XRTOrderTrackingCell.m
//  Etion
//
//  Created by wyy on 2017/6/5.
//  Copyright © 2017年 GuangZhouXuanWu. All rights reserved.
//

#import "XRTOrderTrackingCell.h"
//#define TrackingCellDebug

#define DegreesToRadian(x) (M_PI * (x) / 180.0)
@interface XRTOrderTrackingCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *orderStatusLable;
@property (nonatomic, strong) UILabel *orderTimeLable;
@property (nonatomic, strong) UILabel *failedReasonLable;
@property (nonatomic, strong) CAShapeLayer *lineLayer1;
@property (nonatomic, assign) BOOL isAlreadyLoadLine;
@end

@implementation XRTOrderTrackingCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.orderStatusLable];
        [self addSubview:self.orderTimeLable];
        [self addSubview:self.failedReasonLable];
        [self.layer addSublayer:self.lineLayer1];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //layout
    self.nameLabel.frame = CGRectMake(_layout.distacneToLeft,_layout.verticalDistance, _layout.nameLabelSize.width, _layout.nameLabelSize.height);
    self.orderStatusLable.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame) + _layout.horizontalDistance, _layout.verticalDistance, _layout.orderStatusLableSize.width, _layout.orderStatusLableSize.height);
    self.orderTimeLable.frame = CGRectMake(_layout.distacneToLeft,CGRectGetMaxY(self.nameLabel.frame) + _layout.verticalDistance, _layout.orderTimeLableSize.width, _layout.orderTimeLableSize.height);
    self.failedReasonLable.frame =  CGRectMake(_layout.distacneToLeft,CGRectGetMaxY(self.orderTimeLable.frame) + _layout.verticalDistance, _layout.failedReasonLableSize.width, _layout.failedReasonLableSize.height);

    if (_layout.model.isAlreadyLoadLine == NO) {
        [self waveAnimationWithPositionX:3.0];
        if ([self.delegate respondsToSelector:@selector(orderTrackingCellDidFnishedLoad:)]) {
            [self.delegate orderTrackingCellDidFnishedLoad:self];
        }
    } else {
        self.lineLayer1.path = [self bezierPath1].CGPath;
    }

}

- (void)setLayout:(XRTOrderTrackingLayout *)layout {
    _layout = layout;
    //fontSize
    self.nameLabel.font = [UIFont systemFontOfSize:layout.nameLabelFont];
    self.orderStatusLable.font = [UIFont systemFontOfSize:layout.orderStatusLableFont];
    self.orderTimeLable.font = [UIFont systemFontOfSize:layout.orderStatusLableFont];
    self.failedReasonLable.font = [UIFont systemFontOfSize:layout.nameLabelFont];
    
    //update data
    self.nameLabel.text = layout.model.customerName;
    self.orderStatusLable.text = layout.model.orderStatus;
    self.orderTimeLable.text = layout.model.orderTime;
    self.failedReasonLable.text = layout.model.failedReason;
 
}

#pragma mark - animation
- (void)waveAnimationWithPositionX:(CGFloat)positionX {
    self.lineLayer1.path = [self bezierPath1].CGPath;
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation1.fromValue = @(0.0);
    animation1.toValue = @(1.0);
    self.lineLayer1.autoreverses = NO;
    animation1.duration = AnimationTime;
    [self.lineLayer1 addAnimation:animation1 forKey:nil];
}
#pragma mark - get
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
#ifdef TrackingCellDebug
        _nameLabel.backgroundColor = [UIColor redColor];
#endif

    }
    return _nameLabel;
}

- (UILabel *)orderStatusLable {
    if (_orderStatusLable == nil) {
        _orderStatusLable = [[UILabel alloc] init];
        _orderStatusLable.textAlignment = NSTextAlignmentRight;
#ifdef TrackingCellDebug
        _orderStatusLable.backgroundColor = [UIColor purpleColor];
#endif
    }
    return _orderStatusLable;
}

- (UILabel *)orderTimeLable {
    if (_orderTimeLable == nil) {
        _orderTimeLable = [[UILabel alloc] init];
        
#ifdef TrackingCellDebug
        _orderTimeLable.backgroundColor = [UIColor yellowColor];
#endif
    }
    return _orderTimeLable;
}

- (UILabel *)failedReasonLable {
    if (_failedReasonLable == nil) {
        _failedReasonLable = [[UILabel alloc] init];
        _failedReasonLable.numberOfLines = 0;
#ifdef TrackingCellDebug
        _failedReasonLable.backgroundColor = [UIColor greenColor];
#endif
    }
    return _failedReasonLable;
}

- (CAShapeLayer *)lineLayer1 {
    if (_lineLayer1 == nil) {
        _lineLayer1 = [CAShapeLayer layer];
        _lineLayer1.fillColor = [UIColor clearColor].CGColor;
        _lineLayer1.strokeColor = [UIColor blackColor].CGColor;
        _lineLayer1.lineWidth = 1.0;
    }
    return _lineLayer1;
}

- (UIBezierPath *)bezierPath1 {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 0)];
    [path addLineToPoint:CGPointMake(10, CGRectGetMaxY(self.nameLabel.frame))];
    [path addArcWithCenter:CGPointMake(10, CGRectGetMaxY(self.nameLabel.frame) + 5) radius:5 startAngle:DegreesToRadian(-90) endAngle:DegreesToRadian(360 + 90) clockwise:YES];
    [path addLineToPoint:CGPointMake(10, CGRectGetMaxY(self.failedReasonLable.frame) + _layout.verticalDistance)];
    
    return path;
}

@end
