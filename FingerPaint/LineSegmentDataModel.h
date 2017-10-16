//
//  LineSegmentDataModel.h
//  FingerPaint
//
//  Created by Nicholas Fung on 2017-10-13.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

@import UIKit;

@interface LineSegmentDataModel : NSObject

@property (nonatomic, assign, readonly) CGPoint firstPoint;
@property (nonatomic, assign, readonly) CGPoint secondPoint;
@property (nonatomic, strong, readonly) UIColor *color;

-(instancetype)initWithFirstPoint:(CGPoint)firstPoint andSecondPoint:(CGPoint)secondPoint andColor:(UIColor *)color;

@end
