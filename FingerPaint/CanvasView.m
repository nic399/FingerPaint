//
//  CanvasView.m
//  FingerPaint
//
//  Created by Nicholas Fung on 2017-10-13.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//


// Credit (and thanks) goes to Roland who wrote a lot of this code during his lecture on how to utilize this dark magic

#import "CanvasView.h"
#import "LineSegmentDataModel.h"

@interface CanvasView()

@property (nonatomic, strong, readonly)NSMutableArray<LineSegmentDataModel *> *lines;
@property (nonatomic, strong, readwrite)UIColor *colorOfLine;
@property (nonatomic, strong, readwrite)NSMutableArray<UIBezierPath *> *pathArray;

@end

// At some later date, there will be changes so that each line drawn previously stops converting to whatever the color of the last line is
// by making each line it's own bezier path object




@implementation CanvasView

-(instancetype)init {
    self = [super init];
    if (self) {
        _lines = [NSMutableArray new];
        _colorOfLine = [UIColor blackColor];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _lines = [NSMutableArray new];
        _colorOfLine = [UIColor blackColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint first = [touch previousLocationInView:self];
    // First line segment is from the initial touch point to the initial touch point, so
    // basically a point
    LineSegmentDataModel *segment = [[LineSegmentDataModel alloc] initWithFirstPoint:first
                                                                      andSecondPoint:first
                                                                            andColor:self.colorOfLine];
    [self.lines addObject:segment];
    
    // Tell the system that we need to be redrawn, so the system will call drawRect: before
    // the end of the current event loop
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint second = [touch locationInView:self];        // Current touch location
    CGPoint first = [touch previousLocationInView:self]; // Previous touch location
    NSLog(@"%d: %@, %@", __LINE__, NSStringFromCGPoint(first), NSStringFromCGPoint(second));
    // Line segment is from previous touch location to current touch location
    LineSegmentDataModel *segment = [[LineSegmentDataModel alloc] initWithFirstPoint:first
                                                                      andSecondPoint:second
                                                                            andColor:self.colorOfLine];
    [self.lines addObject:segment];
    
    // Tell the system that we need to be redrawn, so the system will call drawRect: before
    // the end of the current event loop
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound;
    [self.colorOfLine setStroke];
    BOOL firstLine = true;
    // Loop through all elements in the segment array and draw each line
    for (LineSegmentDataModel *segment in self.lines) {
        if (CGPointEqualToPoint(segment.firstPoint, segment.secondPoint)) {
            // If start/end point of line segment is the same (i.e. this is the first
            // point, then move to that point so that line is drawn starting from that
            // point
            if (!firstLine) {
                [path stroke];
                firstLine = false;
                [segment.color setStroke];

            }
            
            [path moveToPoint:segment.firstPoint];
            continue;
        }
        // Draw a line from the previous line segment to the first point
        [path addLineToPoint:segment.firstPoint];
        // Draw a line from the first point to the second point
        [path addLineToPoint:segment.secondPoint];
    }
    [path stroke];
}

-(void)setLineColor:(UIColor *)color {
    self.colorOfLine = color;
}











/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
