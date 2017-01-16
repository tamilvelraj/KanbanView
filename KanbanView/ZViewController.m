//
//  ViewController.m
//  ZCalendar
//
//  Created by Thamil Selvan V on 08/11/16.
//  Copyright © 2016 Thamil Selvan V. All rights reserved.
//

#import "ZViewController.h"
#import "ZPageScrollView.h"
#import "AppDelegate.h"
#import "UIView+ZCRMAutoLayout.h"

#define CellIdentifier @"Cell"

@interface ZCustomCell : UITableViewCell
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIImageView *avatarView;
@property(nonatomic,strong) UILabel *titleLabel3;
@end

@implementation ZCustomCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        NSString *initial = @"Project Management Services is being offered by zoho";
        NSString *text = [initial stringByReplacingOccurrencesOfString:@"zoho" withString:@"Zoho"];
        
        NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:text];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(Zoho)" options:kNilOptions error:nil];
        
        NSRange range = NSMakeRange(0,text.length);
        [regex enumerateMatchesInString:text options:kNilOptions range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            NSRange subStringRange = [result rangeAtIndex:1];
            [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:subStringRange];
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.attributedText = mutableAttributedString;
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        
        if (![self.contentView viewWithTag:1300])
        {
            UIImage *avaimg = [UIImage imageNamed:[NSString stringWithFormat:@"women0.png"]];
            _avatarView = [[UIImageView alloc] initWithImage:avaimg];
            _avatarView.tag = 1300;
            [self.contentView addSubview:_avatarView];
        }
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(10, 0, CGRectGetWidth(self.contentView.bounds)-60.f, CGRectGetHeight(self.contentView.bounds));
    _avatarView.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame), 0, 40.f, 40.f);
}

@end


@interface ZViewController () <ZPageScrollViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSMutableArray *controllers;
@end

@implementation ZViewController
{
    UIPageViewController *pageviewContrller;
    ZPageScrollView *pagescrollView;
    UIInterfaceOrientation deviceOrientation;
    NSArray *colors;
    NSMutableArray *tableViews;
    NSInteger noOfPages;
    UILabel *pageIndexLabel;
    dispatch_queue_t nonUIOperationQueue;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [pagescrollView superViewWillAppear];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [pagescrollView superViewDidAppear];
}

-(UIInterfaceOrientation)GetCurrentOrientationOfDevice
{
    UIInterfaceOrientation orientation = [((UIApplication*)[UIApplication sharedApplication]) statusBarOrientation];
    return orientation;
}

- (BOOL)canChangeThisOrientation:(UIInterfaceOrientation)orientation
{
    if (orientation != deviceOrientation && orientation!= UIInterfaceOrientationUnknown) {
        return YES;
    }
    return NO;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    UIInterfaceOrientation  statusBarOrientation = [self GetCurrentOrientationOfDevice];
    BOOL canChangeOrientation = [self canChangeThisOrientation:statusBarOrientation];
    if (canChangeOrientation)
    {
        deviceOrientation = statusBarOrientation;
        [pagescrollView superViewDidLayoutSubviews:deviceOrientation];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    
    colors = @[[UIColor greenColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor blueColor],[UIColor redColor],[UIColor magentaColor],[UIColor cyanColor]];
    
    nonUIOperationQueue = dispatch_queue_create([NonUIOperationalQueue UTF8String], NULL);
    noOfPages = 100;
    
    tableViews = [[NSMutableArray alloc] init];
    
    pagescrollView = [[ZPageScrollView alloc] init];
    pagescrollView.noOfPages = noOfPages;
    pagescrollView.datasource = self;
    pagescrollView.contentInset = UIEdgeInsetsMake(0, 0.f, 0, 0);
    [self.view addSubview:pagescrollView];
    
    [pagescrollView setLeft:0];
    [pagescrollView setTop:60.f];  //Status bar height
    [pagescrollView setRelativeWidth:1.f];
    [pagescrollView setRelativeHeight:1.f constant:-60.f];
    
    pageIndexLabel = [[UILabel alloc] init];
    pageIndexLabel.numberOfLines = 0;
    pageIndexLabel.textColor = [UIColor blackColor];
    pageIndexLabel.textAlignment = NSTextAlignmentCenter;
    pageIndexLabel.font = [UIFont systemFontOfSize:17.f];
    [self.view addSubview:pageIndexLabel];
    
    [pageIndexLabel setLeft:0];
    [pageIndexLabel setTop:20];
    [pageIndexLabel setRelativeWidth:1.f];
    [pageIndexLabel setHeight:40.f];
}

-(int)randN:(int)maxN
{
    int randN = rand()%maxN;
    return (randN==0)?1: randN;
}

-(void)setReversingPageViewIn:(UIView*)reverseView currentPageView:(UIView*)currentView pageIndex:(NSInteger)pageIndex
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UITableView *tableView = (UITableView*)[[reverseView subviews] objectAtIndex:0];
            [tableView reloadData];
            [tableView setContentOffset:CGPointMake(0, 0)];
            pageIndexLabel.text = [NSString stringWithFormat:@"%d of %d",(int)pageIndex,(int)noOfPages];
        });
    });
}

-(void)setForwardingPageViewIn:(UIView*)forwardView currentPageView:(UIView*)currentView pageIndex:(NSInteger)pageIndex
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UITableView *tableView = (UITableView*)[[forwardView subviews] objectAtIndex:0];
            [tableView reloadData];
            [tableView setContentOffset:CGPointMake(0, 0)];
            pageIndexLabel.text = [NSString stringWithFormat:@"%d of %d",(int)pageIndex,(int)noOfPages];
        });
    });
}

-(UIView *)pageView {
    return [self getTableViewInstance];
}

-(UIView*)getTableViewInstance
{
//    __block UIView *pageDataView = nil;
//    [tableViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (![view superview]) {
//            pageDataView = view;
//            *stop = YES;
//        }
//    }];
//    
//    if (pageDataView==nil) {
        UIView *pageDataView = [[UIView alloc] initWithFrame:CGRectZero];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[ZCustomCell class] forCellReuseIdentifier:CellIdentifier];
        [pageDataView addSubview:tableView];
        
        tableView.tableFooterView = [[UIView alloc] init];
        
        [tableView setLeft:20];
        [tableView setTop:0];
        [tableView setRelativeWidth:1.f constant:-40.f];
        [tableView setRelativeHeight];
//        [tableViews addObject:pageDataView];
//    }
    
    return pageDataView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 300.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [AppDelegate randN:3] * 44;
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    return cell;
}

-(void)currentGridScrollOffset:(CGPoint)offset {
    _gridViewOffset = offset;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
