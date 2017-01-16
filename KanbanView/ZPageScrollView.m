//
//  ZPageScrollView.m
//  ZPager
//
//  Created by Thamil Selvan V on 26/11/16.
//  Copyright © 2016 Thamil Selvan V. All rights reserved.
//

#import "ZPageScrollView.h"
#import "UIView+ZCRMAutoLayout.h"

@interface ZPageScrollView() <UIScrollViewDelegate> {
    CGSize screenSize;
    NSInteger currentpageIndex;
    dispatch_queue_t nonUIOperationQueue;
}
@property(nonatomic,assign) CGFloat pageDataWidth;
@end

@implementation ZPageScrollView
@synthesize containerView=containerView;

-(int)randN:(int)maxN
{
    int randN = rand()%maxN;
    return (randN==0)?1: randN;
}

-(CGFloat)pageDataWidth {
    return CGRectGetWidth([UIScreen mainScreen].bounds)*1.f;
}

-(CGFloat)pageDataHeight {
    return  CGRectGetHeight(self.bounds);
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        screenSize = [UIScreen mainScreen].bounds.size;
        nonUIOperationQueue = dispatch_queue_create([NonUIOperationalQueue UTF8String], NULL);
        
        self.showsHorizontalScrollIndicator = YES;
        self.alwaysBounceHorizontal = YES;
        self.alwaysBounceVertical = NO;
        self.pagingEnabled = NO;
        self.delegate = self;
        self.bounces = NO;
        
        containerView = [[UIView alloc] initWithFrame:CGRectZero];
        containerView.backgroundColor = [UIColor clearColor];
        [self addSubview:containerView];
        
        [containerView setTop:0];
        [containerView setLeft:0];
        [containerView setWidth:_noOfPages*self.pageDataWidth];
        [containerView setRelativeHeight];
    }
    return self;
}

-(void)setNoOfPages:(NSInteger)noOfPages
{
    _noOfPages = noOfPages;
    
    [containerView.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * constraint, NSUInteger idx, BOOL * _Nonnull stop) {
        if (constraint.firstItem==containerView && constraint.firstAttribute==NSLayoutAttributeWidth) {
            [containerView.superview removeConstraint:constraint];
        }
    }];
    [containerView setWidth:_noOfPages*self.pageDataWidth];
}

-(void)superViewDidAppear {}
-(void)superViewWillAppear
{
    [self setContainerViewAndSize];
    //[self setInitialOffsetAnimation];
}
-(void)superViewDidLayoutSubviews:(UIInterfaceOrientation)orientation {}

-(void)setInitialOffsetAnimation
{
    self.contentOffset = CGPointMake(self.pageDataWidth*0.5f, 0);
    [UIView animateWithDuration:0.4f animations:^{
        self.contentOffset = CGPointMake(0, 0);
    }];
}

-(void)setContainerViewAndSize
{
    self.contentSize = CGSizeMake(self.pageDataWidth*_noOfPages, self.pageDataHeight);

    NSInteger noOfPageViews = (_noOfPages > 3)? 3: _noOfPages;
    for (int i=0; i<noOfPageViews; i++)
    {
        UIView *pageView = [_datasource pageView];
        [containerView addSubview:pageView];
        
        if (i==0) {
            [pageView setLeft:0];
        }
        else {
            UIView *prevview = [containerView.subviews objectAtIndex:i-1];
            [pageView setLeftRelatedToView:prevview relatedWithAttribute:NSLayoutAttributeRight offset:0];
        }
        
        [pageView setTop:0];
        [pageView setWidth:self.pageDataWidth];
        [pageView setRelativeHeight];
    }
}

-(void)setupForReverseScroll:(NSInteger)pageIndex
{
    UIView *relocateView = [containerView.subviews objectAtIndex:2];
    [self removeLeftConstraintForPageViews];
    
    [containerView insertSubview:relocateView atIndex:0];
    
    [containerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx==0) {
            [view setLeft:(pageIndex-1)*self.pageDataWidth];
        }
        else
        {
            UIView *prevview = [[containerView subviews] objectAtIndex:idx-1];
            [view setLeftRelatedToView:prevview relatedWithAttribute:NSLayoutAttributeRight offset:0];
        }
    }];
    
    [containerView layoutIfNeeded];
    
    UIView *prevView = [containerView.subviews objectAtIndex:1];
    [_datasource setReversingPageViewIn:relocateView currentPageView:prevView pageIndex:pageIndex];
}

-(void)setupForForwardScroll:(NSInteger)pageIndex
{
    UIView *relocateView = [containerView.subviews objectAtIndex:0];
    [self removeLeftConstraintForPageViews];
    [containerView insertSubview:relocateView atIndex:2];
    
    [containerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx==0) {
            [view setLeft:(pageIndex-1)*self.pageDataWidth];
        }
        else
        {
            UIView *prevview = [[containerView subviews] objectAtIndex:idx-1];
            [view setLeftRelatedToView:prevview relatedWithAttribute:NSLayoutAttributeRight offset:0];
        }
    }];
    
    [containerView layoutIfNeeded];
    
    UIView *prevView = [containerView.subviews objectAtIndex:1];
    [_datasource setForwardingPageViewIn:relocateView currentPageView:prevView pageIndex:pageIndex];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat xoffset = self.contentOffset.x;
    NSInteger halfwidth = self.pageDataWidth*0.5f;
    NSInteger pagewidth = self.pageDataWidth;
    NSInteger pageIndex = round((xoffset+halfwidth)/pagewidth);
    
    if (currentpageIndex!=pageIndex)
    {
        if (currentpageIndex < pageIndex) {
            [self setupForForwardScroll:pageIndex];
        }
        else if(currentpageIndex > pageIndex) {
            [self setupForReverseScroll:pageIndex];
        }
        
        currentpageIndex = pageIndex;
    }
}

-(void)removeLeftConstraintForPageViews
{
    [containerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *constraints = containerView.constraints;
        [constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL * _Nonnull stop) {
            if (constraint.firstAttribute==NSLayoutAttributeLeft && constraint.firstItem==view) {
                [containerView removeConstraint:constraint];
            }
        }];
    }];
}

@end


