//
//  AppDelegate.h
//  KanbanView
//
//  Created by Thamil Selvan V on 10/01/17.
//  Copyright © 2017 Thamil Selvan V. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(CGFloat)gridScreenWidth;
+(CGFloat)gridScreenHeight;
+(int)randN:(int)maxN;
@end

