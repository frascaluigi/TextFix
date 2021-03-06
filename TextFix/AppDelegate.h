//
//  AppDelegate.h
//  TextFix
//
//  Created by Riccardo Gargano on 25/11/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFConManager.h"
#import "TFLocManager.h"
#import "TFConObject.h"
#import "TFMessage.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TFConManager *connection;
@property (strong, nonatomic) TFLocManager *locationManager;
@property (strong, nonatomic, readonly) NSMutableDictionary *messages;
@property (strong, nonatomic) Reachability *reachability;

@end

