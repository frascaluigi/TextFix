//
//  TFManager.h
//  TextFix
//
//  Created by Luigi Frasca on 27/11/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>



@interface TFLocManager : NSObject<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) CLLocationManager *manager;

-(instancetype)init;
-(void)startUpdate;

@end
