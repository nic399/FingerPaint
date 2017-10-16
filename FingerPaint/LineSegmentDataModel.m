//
//  LineSegmentDataModel.m
//  FingerPaint
//
//  Created by Nicholas Fung on 2017-10-13.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import "LineSegmentDataModel.h"

@implementation LineSegmentDataModel

-(instancetype)initWithFirstPoint:(CGPoint)firstPoint andSecondPoint:(CGPoint)secondPoint andColor:(UIColor *)color{
    self = [super init];
    if (self) {
        _firstPoint = firstPoint;
        _secondPoint = secondPoint;
        _color = color;
    }
    return self;
}

@end
