//
//  ZPageScrollView.h
//  ZPager
//
//  Created by Thamil Selvan V on 26/11/16.
//  Copyright © 2016 Thamil Selvan V. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NonUIOperationalQueue @"NewQueue"

@protocol ZPageScrollViewDataSource <NSObject>
-(UIView*)pageView;
-(void)setForwardingPageViewIn:(UIView*)containerView currentPageView:(UIView*)currentView pageIndex:(NSInteger)pageIndex;
-(void)setReversingPageViewIn:(UIView*)containerView currentPageView:(UIView*)currentView pageIndex:(NSInteger)pageIndex;
@end

@interface ZPageScrollView : UIScrollView {
}

@property(nonatomic,assign) NSInteger noOfPages;
@property(nonatomic,weak) id<ZPageScrollViewDataSource> datasource;
@property(nonatomic,strong) UIView *containerView;

//-(void)setPageViews:(NSArray*)views;

-(void)superViewDidAppear;
-(void)superViewWillAppear;
-(void)superViewDidLayoutSubviews:(UIInterfaceOrientation)orientation;

@end
