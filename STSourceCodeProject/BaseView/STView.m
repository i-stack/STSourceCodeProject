//
//  STView.m
//  STSourceCodeProject
//
//  Created by song on 2021/11/10.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STView.h"

@implementation STView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.alpha <= 0.01 || self.userInteractionEnabled == NO || self.hidden) {
        return nil;
    }

    BOOL inside = [self pointInside:point withEvent:event];
    if (inside) {
        NSArray *subViews = self.subviews;
        // 对子视图从上向下找
        for (NSInteger i = subViews.count - 1; i >= 0; i--) {
            UIView *subView = subViews[i];
            CGPoint insidePoint = [self convertPoint:point toView:subView];
            UIView *hitView = [subView hitTest:insidePoint withEvent:event];
            if (hitView) {
                return hitView;
            }
        }
        return self;
    }
    return nil;
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    return true;//[self pointInside:point withEvent:event];
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@--%s", self, __func__);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@--%s", self, __func__);
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@--%s", self, __func__);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@--%s", self, __func__);
}

@end
