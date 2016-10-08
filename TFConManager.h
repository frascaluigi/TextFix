//
//  TFConManager.h
//  TextFix
//
//  Created by Luigi Frasca on 27/11/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "TFConObject.h"
#import "Reachability.h"

@interface TFConManager : NSObject<NSURLConnectionDelegate>

@property(strong, readonly) NSURL *baseURL;

-(instancetype)init;
-(instancetype)initWhithOptions:(NSDictionary *)opt;

-(void)getDataWith:(TFConObject *) tfObj;

@end
