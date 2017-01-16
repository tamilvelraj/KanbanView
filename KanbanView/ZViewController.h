//
//  ViewController.h
//  KanbanView
//
//  Created by Thamil Selvan V on 08/11/16.
//  Copyright © 2016 Thamil Selvan V. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ZCalendarScrollDelegate <NSObject>
-(void)currentGridScrollOffset:(CGPoint)offset;
@end

@interface ZViewController : UIViewController
@property(nonatomic,strong) NSDate *date;
@property(nonatomic,assign) CGPoint gridViewOffset;
@end

