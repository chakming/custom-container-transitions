//
//  PanGestureInteractiveTransition.h
//  Container Transitions
//
//  Created by Alek Astrom on 2014-05-11.
//
//

#import "AWPercentDrivenInteractiveTransition.h"

/// Instances of this class perform the interactive transition by using a UIPanGestureRecognizer to control the animation.
@interface PanGestureInteractiveTransition : AWPercentDrivenInteractiveTransition

- (id)initWithGestureRecognizerInView:(UIView *)view recognizedBlock:(void (^)(BOOL leftToRight))gestureRecognizedBlock;

- (BOOL)recognizerStateBegan;

@property (nonatomic, readonly) UIScreenEdgePanGestureRecognizer *leftRecognizer;
@property (nonatomic, readonly) UIScreenEdgePanGestureRecognizer *rightRecognizer;

/// This block gets run when the gesture recognizer start recognizing a pan. Inside, the start of a transition can be triggered.
@property (nonatomic, copy) void (^gestureRecognizedBlock)(BOOL leftToRight);

@end
