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
 The view to edit the quadrangle to edit the perspective correction.

 It displays an editable quadrangle overlaid on the original image.
 */
@interface GSKEditFrameView : UIImageView

- (void)clearSelection;

@property (nonatomic, readonly) GSKEditableFrame *imageSelection;

// Normalized quadrangle
@property (nonatomic, strong) GSKQuadrangle *quadrangle;

/**
 Sets the quadrangle on the view.

 The quadrangle must be in normalized coordinates.

 @param animated If true, the new quadrangle will fade in.
 */
- (void)setQuadrangle:(GSKQuadrangle *)quadrangle animated:(BOOL)animated;

@property (nonatomic, assign) BOOL noCrop;

@end

NS_ASSUME_NONNULL_END
