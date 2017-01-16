
#import "UIView+ZCRMAutoLayout.h"


VTOffset VTLayoutOffset(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
{
    VTOffset edges;
    edges.left=left;
    edges.top=top;
    edges.right=right;
    edges.bottom=bottom;
    return edges;
}


VTOffset translateOffsets(UIEdgeInsets uiEdges){
    VTOffset edges;
    edges.left=uiEdges.left;
    edges.top=uiEdges.top;
    edges.right=uiEdges.right;
    edges.bottom=uiEdges.bottom;
    return edges;
}

@implementation UIView (ZCRMAutoLayout)

-(void)initForView
{
    self.translatesAutoresizingMaskIntoConstraints=NO;
}


- (void) equalsTheContainerView{
    [self setLeft:0];
    [self setRight:0];
    [self setTop:0];
    [self setBottom:0];
}

- (void) setHeight:(CGFloat)constant
{
    [self setRelativeHeight:0 constant:constant];
}

- (void) setRelativeHeight
{
    [self setRelativeHeight:1.0 constant:0];
}

- (void) setRelativeHeight:(CGFloat)multiplier{
    [self setRelativeHeight:multiplier constant:0];
}


- (void) setRelativeHeight:(CGFloat)multiplier constant:(CGFloat)constant
{
    [self initForView];
    NSLayoutConstraint *htConst=[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeHeight multiplier:multiplier constant:constant];
    [self.superview addConstraint:htConst];
}

- (void) setWidth:(CGFloat) constant
{
    [self setRelativeWidth:0 constant:constant];
}

- (void) setRelativeWidth:(CGFloat)multiplier{
    [self setRelativeWidth:multiplier constant:0];
}

- (void) setRelativeWidth
{
    [self setRelativeWidth:1.0 constant:0];
}


- (void) setRelativeWidth:(CGFloat)multiplier constant:(CGFloat)constant
{
    [self initForView];
    NSLayoutConstraint *wdthConst=[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeWidth multiplier:multiplier constant:constant];
    [self.superview addConstraint:wdthConst];
}


- (void) setRelativeSize:(CGSize)sz
{
    [self setRelativeHeight: sz.height constant:0];
    [self setRelativeWidth:  sz.width  constant:0];
}


-(void) setViewSize:(CGSize) sz
{
    [self setWidth: sz.width];
    [self setHeight: sz.height];
}


- (void) setTop :(CGFloat) offset
{
    [self setTopRelatedToView:self.superview relatedWithAttribute:NSLayoutAttributeTop withMultiplier:1.0 andOffset:offset];
}

- (void) setRelativeTop: (CGFloat) multiplier top_Offset:(CGFloat) offset
{
    [self setTopRelatedToView:self.superview relatedWithAttribute:NSLayoutAttributeTop withMultiplier:multiplier andOffset:offset];
}


- (void) setTopRelatedToView:(UIView *)relatedView offset:(CGFloat)offset
{
    [self setTopRelatedToView:relatedView relatedWithAttribute:NSLayoutAttributeTop withMultiplier:1.0 andOffset:offset];
}


- (void) setTopRelatedToView:(UIView *)relatedView relatedWithAttribute:(NSLayoutAttribute)relatedAttribute offset:(CGFloat)offset
{
    [self setTopRelatedToView:relatedView relatedWithAttribute:relatedAttribute withMultiplier:1.0 andOffset:offset];
}


-(void) setTopRelatedToView:(UIView *)relatedView relatedWithAttribute:(NSLayoutAttribute)relatedAttribute withMultiplier:(CGFloat)multiplier andOffset:(CGFloat)offset
{
    [self initForView];
    NSLayoutConstraint *topConstraint=[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:relatedView attribute:relatedAttribute multiplier:multiplier constant:offset];
    [self.superview addConstraint:topConstraint];
}


- (void) setBottom:(CGFloat) offset
{
    [self setBottomRelatedToView:self.superview relatedWithAttribute:NSLayoutAttributeBottom withMultiplier:1.0 andOffset:offset];
}


-(void) setRelativeBottom:(CGFloat) multiplier bottom_Offset:(CGFloat)offset
{
    [self setBottomRelatedToView:self.superview relatedWithAttribute:NSLayoutAttributeBottom withMultiplier:multiplier andOffset:offset];
}

- (void) setBottomRelatedToView:(UIView *)relatedView offset:(CGFloat)offset
{
    [self setBottomRelatedToView:relatedView relatedWithAttribute:NSLayoutAttributeBottom withMultiplier:1.0 andOffset:offset];
}


- (void) setBottomRelatedToView:(UIView *)relatedView relatedWithAttribute:(NSLayoutAttribute)relatedAttribute offset:(CGFloat)offset
{
    [self setBottomRelatedToView:relatedView relatedWithAttribute:relatedAttribute withMultiplier:1.0 andOffset:offset];
}


- (void) setBottomRelatedToView:(UIView *)relatedView relatedWithAttribute:(NSLayoutAttribute)relatedAttribute withMultiplier:(CGFloat)multiplier andOffset:(CGFloat)offset
{
    [self initForView];
    NSLayoutConstraint *bottomConstraint=[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom  relatedBy:NSLayoutRelationEqual toItem:relatedView attribute:relatedAttribute multiplier:multiplier constant:offset];
    [self.superview addConstraint:bottomConstraint];
}


- (void) setLeft:(CGFloat) offset
{
    [self setLeftRelatedToView:self.superview relatedWithAttribute:NSLayoutAttributeLeft withMultiplier:1.0 andOffset:offset];
}


- (void) setRelativeLeft:  (CGFloat) multiplier left_Offset:(CGFloat) offset
{
    [self setLeftRelatedToView:self.superview relatedWithAttribute:NSLayoutAttributeLeft withMultiplier:multiplier andOffset:offset];
}


- (void) setLeftRelatedToView:(UIView *)relatedView offset:(CGFloat)offset
{
    [self setLeftRelatedToView:relatedView relatedWithAttribute:NSLayoutAttributeLeft withMultiplier:1.0 andOffset:offset];
}


- (void) setLeftRelatedToView:(UIView *)relatedView relatedWithAttribute:(NSLayoutAttribute)relatedAttribute offset:(CGFloat)offset
{
    [self setLeftRelatedToView:relatedView relatedWithAttribute:relatedAttribute withMultiplier:1.0 andOffset:offset];
}



- (void) setLeftRelatedToView:(UIView *)relatedView relatedWithAttribute:(NSLayoutAttribute)relatedAttribute withMultiplier:(CGFloat)multiplier andOffset:(CGFloat)offset
{
    //DLog(@"%@ \n%@ \n%ld %f %f",self, relatedView,relatedAttribute,multiplier,offset);
    [self initForView];
    NSLayoutConstraint *leftConstraint=[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft  relatedBy:NSLayoutRelationEqual toItem:relatedView attribute:relatedAttribute multiplier:multiplier constant:offset];
    [self.superview addConstraint:leftConstraint];
}


- (void) setRight:(CGFloat) offset
{
    [self setRightRelatedToView:self.superview relatedWithAttribute:NSLayoutAttributeRight withMultiplier:1.0 andOffset:offset];
}


- (void) setRelativeRight: (CGFloat) multiplier right_Offset:(CGFloat) offset
{
   [self setRightRelatedToView:self.superview relatedWithAttribute:NSLayoutAttributeRight withMultiplier:multiplier andOffset:offset];
}


- (void) setRightRelatedToView:(UIView *)relatedView offset:(CGFloat)offset
{
    [self setRightRelatedToView:relatedView relatedWithAttribute:NSLayoutAttributeRight withMultiplier:1.0 andOffset:offset];
}


- (void) setRightRelatedToView:(UIView *)relatedView relatedWithAttribute:(NSLayoutAttribute)relatedAttribute offset:(CGFloat)offset
{
    [self setRightRelatedToView:relatedView relatedWithAttribute:relatedAttribute withMultiplier:1.0 andOffset:offset];
}

- (void) setRightRelatedToView:(UIView *)relatedView relatedWithAttribute:(NSLayoutAttribute)relatedAttribute withMultiplier:(CGFloat)multiplier andOffset:(CGFloat)offset
{
    [self initForView];
    NSLayoutConstraint *rightConstraint=[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight  relatedBy:NSLayoutRelationEqual toItem:relatedView attribute:relatedAttribute multiplier:multiplier constant:offset];
    [self.superview addConstraint:rightConstraint];
}


- (void) setCenterX
{
    [self setCenterXWithOffset:0];
}


- (void) setCenterXWithOffset:(CGFloat) offset
{
    [self setCenterXWithOffset:offset andMultiplier:1.0];
}

-(void) setRelativeCenterX:(CGFloat) multiplier
{
    [self setCenterXWithOffset:0 andMultiplier:multiplier];
}

- (void) setCenterXWithOffset:(CGFloat) offset andMultiplier:(CGFloat) multiplier
{
    [self initForView];
    NSLayoutConstraint *centerXConstraint=[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:multiplier constant:offset];
    [self.superview addConstraint:centerXConstraint];
}

- (void) setCenterY
{
    [self setCenterYWithOffset: 0];
}

- (void) setCenterYWithOffset:(CGFloat) offset
{
    [self setCenterYWithOffset:offset andMultiplier:1.0];
}

-(void) setRelativeCenterY:(CGFloat) multiplier
{
    [self setCenterYWithOffset:0 andMultiplier:multiplier];
}

- (void) setCenterYWithOffset:(CGFloat) offset andMultiplier:(CGFloat) multiplier
{
    [self initForView];
    NSLayoutConstraint *centerYConstraint=[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterY multiplier:multiplier constant:offset];
    [self.superview addConstraint:centerYConstraint];
}


- (void) setOffsets: (VTOffset) edges
{
    [self setTop:edges.top];
    [self setBottom:edges.bottom];
    [self setLeft:edges.left];
    [self setRight:edges.right];
}


- (void) alignTo:(VTLayoutAlignment)align
{
    [self alignTo:align offset:VTLayoutOffset(0 , 0 ,  0 , 0)];
}


- (void) alignTo:(VTLayoutAlignment)align offset:(VTOffset) edges
{
    bool left,right,top,bottom,centerX,centerY;
    left=align & 1;
    right=align & 2;
    bottom=align & 4;
    top=align & 8;
    centerX=align & 16;
    centerY=align & 32;
    //DLog(@"%lu %d %d %d %d %d %d",align,left,right,bottom,top,centerX,centerY);
    
    if(left)
    {
        [self setLeft:edges.left];
    }
    
    if(right)
    {
        [self setRight:edges.right];
    }
    
    if(bottom)
    {
        [self setBottom:edges.bottom];
    }
    
    if(top)
    {
        [self setTop:edges.top];
    }
    
    if(centerX)
    {
        [self setCenterX];
    }
    
    if(centerY)
    {
        [self setCenterY];
    }
}


@end



