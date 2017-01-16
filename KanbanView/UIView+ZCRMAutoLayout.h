
#import <UIKit/UIKit.h>

typedef struct
{
    CGFloat left;
    CGFloat right;
    CGFloat top;
    CGFloat bottom;
}VTOffset;

VTOffset VTLayoutOffset(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);
VTOffset translateOffsets(UIEdgeInsets uiEdge);

@interface UIView (ZCRMAutoLayout)

typedef enum: NSUInteger
{
    VTLayoutAlignLeft = 1,
    VTLayoutAlignRight = 2,
    VTLayoutAlignBottom = 4,
    VTLayoutAlignBottomLeft = 5,
    VTLayoutAlignBottomRight = 6,
    VTLayoutAlignTop = 8,
    VTLayoutAlignTopLeft = 9,
    VTLayoutAlignTopRight = 10,
    VTLayoutAlignCenterX = 16,
    VTLayoutAlignCenterY = 32,
    VTLayoutAlignCenterLeft = 33,
    VTLayoutAlignCenterRight = 34,
    VTLayoutAlignCenterBottom = 20,
    VTLayoutAlignCenterTop = 24,
    VTLayoutAlignCenter = 48
    
}VTLayoutAlignment;

//initialization
-(void) initForView;


- (void) equalsTheContainerView;
////Alignment of Subview
-(void) alignTo:(VTLayoutAlignment) align;
-(void) alignTo:(VTLayoutAlignment) align offset: (VTOffset) edges;
//
////Width related methods
//- (void) halfTheWidthOfTheContainer;
//- (void) equalsTheWidthOfTheContainer;
- (void) setWidth: (CGFloat) constant;
- (void) setRelativeWidth;
- (void) setRelativeWidth: (CGFloat) multiplier;
- (void) setRelativeWidth: (CGFloat) multiplier constant:(CGFloat) constant;
//
////Height related methods
//- (void) halfTheHeightOfTheContainer;
//- (void) equalsHeightOfTheContainer;
- (void) setHeight:(CGFloat) constant;
- (void) setRelativeHeight;
- (void) setRelativeHeight:   (CGFloat) multiplier;
- (void) setRelativeHeight:   (CGFloat) multiplier constant:(CGFloat) constant;
//
////Bounds related methods
- (void) setTop: (CGFloat) offset;
- (void) setBottom: (CGFloat) offset;
- (void) setLeft:   (CGFloat) offset;
- (void) setRight:  (CGFloat) offset;
//- (void) setRelativeTop:   (CGFloat) multiplier top_Offset:(CGFloat) offset;
//- (void) setRelativeLeft:  (CGFloat) multiplier left_Offset:(CGFloat) offset;
- (void) setRelativeBottom:(CGFloat) multiplier bottom_Offset:(CGFloat) offset;
//- (void) setRelativeRight: (CGFloat) multiplier right_Offset:(CGFloat) offset;


//
//
////Bounds related Methods with respect to other view
//- (void) setTopRelatedToView: (UIView *) relatedView offset:(CGFloat) offset;
- (void) setTopRelatedToView: (UIView *) relatedView relatedWithAttribute:(NSLayoutAttribute ) relatedAttribute offset:(CGFloat) offset;
- (void) setTopRelatedToView: (UIView *) relatedView relatedWithAttribute:(NSLayoutAttribute ) relatedAttribute withMultiplier:(CGFloat) multiplier andOffset:(CGFloat)offset;
//
//
//- (void) setBottomRelatedToView: (UIView *) relatedView offset:(CGFloat) offset;
-(void) setBottomRelatedToView: (UIView *) relatedView relatedWithAttribute:(NSLayoutAttribute) relatedAttribute offset:(CGFloat) offset;
- (void) setBottomRelatedToView: (UIView *) relatedView relatedWithAttribute:(NSLayoutAttribute) relatedAttribute withMultiplier:(CGFloat) multiplier andOffset:(CGFloat)offset;
//
//
- (void) setLeftRelatedToView: (UIView *) relatedView offset:(CGFloat) offset;
- (void) setLeftRelatedToView: (UIView *) relatedView relatedWithAttribute:(NSLayoutAttribute) relatedAttribute offset:(CGFloat) offset;
-(void) setLeftRelatedToView: (UIView *) relatedView relatedWithAttribute:(NSLayoutAttribute) relatedAttribute withMultiplier:(CGFloat) multiplier andOffset:(CGFloat)offset;
//
//
- (void) setRightRelatedToView: (UIView *) relatedView offset:(CGFloat) offset;
- (void) setRightRelatedToView: (UIView *) relatedView relatedWithAttribute:(NSLayoutAttribute) relatedAttribute offset:(CGFloat) offset;
- (void) setRightRelatedToView: (UIView *) relatedView relatedWithAttribute:(NSLayoutAttribute) relatedAttribute withMultiplier:(CGFloat) multiplier andOffset:(CGFloat)offset;
//
////Setting Origin
//- (void) setOrigin:     (CGPoint) pt;
//
////Setting size
-(void) setRelativeSize: (CGSize) sz;
-(void) setViewSize: (CGSize) sz;

//CenterPoint related methods
- (void) setCenterX;
- (void) setCenterXWithOffset:(CGFloat) offset;
- (void) setRelativeCenterX:(CGFloat) multiplier;
- (void) setCenterY;
- (void) setCenterYWithOffset:(CGFloat) offset;
- (void) setRelativeCenterY:(CGFloat) multiplier;

//Offset Method
- (void) setOffsets: (VTOffset) edges;
@end





