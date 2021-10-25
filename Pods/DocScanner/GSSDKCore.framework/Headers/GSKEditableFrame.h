//
// Genius Scan SDK
//
// Copyright 2010-2019 The Grizzly Labs
//
// Subject to the Genius Scan SDK Licensing Agreement
// sdk@thegrizzlylabs.com
//

#import <UIKit/UIKit.h>

@class GSKEditableFrame;
@class GSKQuadrangle;

NS_ASSUME_NONNULL_BEGIN

/**
 Represents the quadrangle in the quadrangle edition screen.
 */
@protocol GSKEditableFrameDelegate

- (void)editableFrameDidChange:(GSKEditableFrame *)frame;
- (CGRect)editableFrameBoundsForFrameCorners:(GSKEditableFrame *)editableFrame ;
- (void)editableFrame:(GSKEditableFrame *)editableFrame userDidTouchPoint:(CGPoint)currentTouchPosition;
- (void)editableFrame:(GSKEditableFrame *)editableFrame userDidSelectCorner:(CGPoint)cornerPosition withFingerLocation:(CGPoint)pt;
- (void)editableFrameUserDidEndSelectCorner:(GSKEditableFrame *)editableFrame;
- (void)editableFrameUserDidDoubleTap:(GSKEditableFrame *)editableFrame;
@end

@interface GSKEditableFrame : UIView

@property (nonatomic, strong) GSKQuadrangle *quadrangle;

@property (nonatomic, weak, nullable) id <GSKEditableFrameDelegate> delegate;

@property (nonatomic, copy) UIColor *shadeColor;
@property (nonatomic, copy) UIColor *lineColor;

@property (nonatomic, assign) BOOL noCrop;

@end

NS_ASSUME_NONNULL_END
