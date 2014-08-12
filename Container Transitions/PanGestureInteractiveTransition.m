//
//  PanGestureInteractiveTransition.m
//  Container Transitions
//
//  Created by Alek Astrom on 2014-05-11.
//
//

#import "PanGestureInteractiveTransition.h"

@implementation PanGestureInteractiveTransition

- (id)initWithGestureRecognizerInView:(UIView *)view recognizedBlock:(void (^)(BOOL leftToRight))gestureRecognizedBlock {

    self = [super init];
    if (self) {
        _gestureRecognizedBlock = [gestureRecognizedBlock copy];

        _leftRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]
                initWithTarget:self
                        action:@selector(pan:)];
        [_leftRecognizer setEdges:UIRectEdgeLeft];
        [view addGestureRecognizer:_leftRecognizer];

        _rightRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]
                initWithTarget:self
                        action:@selector(pan:)];
        [_rightRecognizer setEdges:UIRectEdgeRight];
        [view addGestureRecognizer:_rightRecognizer];
    }
    return self;
}

- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super startInteractiveTransition:transitionContext];
}

- (void)pan:(UIScreenEdgePanGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.gestureRecognizedBlock([self isTransitionLeftToRight:recognizer]);
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:recognizer.view];
        CGFloat d = translation.x / CGRectGetWidth(recognizer.view.bounds);
        if (![self isTransitionLeftToRight:recognizer]) d *= -1;
        [self updateInteractiveTransition:d * 0.5f];
    } else if (recognizer.state >= UIGestureRecognizerStateEnded) {
        if (self.percentComplete > 0.2) {
            [self finishInteractiveTransition];
        } else {
            [self cancelInteractiveTransition];
        }
    }
}

- (BOOL)isTransitionLeftToRight:(UIScreenEdgePanGestureRecognizer *)recognizer {
    return [recognizer velocityInView:recognizer.view].x > 0;
}

- (BOOL)recognizerStateBegan {
    return self.leftRecognizer.state == UIGestureRecognizerStateBegan || self.rightRecognizer.state == UIGestureRecognizerStateBegan;
}
@end
