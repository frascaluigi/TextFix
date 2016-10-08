//
//  TFManager.m
//  TextFix
//
//  Created by Luigi Frasca on 27/11/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import "TFLocManager.h"

@implementation TFLocManager


@synthesize manager, currentLocation;


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [[CLLocationManager alloc] init];
        self.manager.desiredAccuracy = kCLLocationAccuracyBest;
        self.manager.delegate = self;
        [self.manager requestAlwaysAuthorization];
        
    }
    return self;
}

- (void)startUpdate{
    
    /***
     
     Viene controllato nell'AppDelegate che ci sia la connessione
     prima di far lanciare l'update delle notifiche
     
     ***/
    
    NSLog(@"___TFLocManager___");
    NSLog(@"_startUpdate_");
    [self.manager startUpdatingLocation];
}

#pragma mark CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"___TFLocManager___");
    NSLog(@"_didUpdateToLocation_ %f \t%f",
          newLocation.coordinate.latitude,
          newLocation.coordinate.longitude);
    
    self.currentLocation = newLocation;
    
    if (self.currentLocation != nil && self.currentLocation != oldLocation) {

        [self.manager stopUpdatingLocation];
        
        //Inutile stoppare la connessione
        
        NSDictionary *loc = [[NSDictionary alloc] initWithObjectsAndKeys:newLocation, @"location", nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"locationUpdateNotify" object:self userInfo:loc];
        
        NSLog(@"_notifica_inviata_");
        
    }
    
    
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    
     NSLog(@"__locationManager__  didChangeAuthorizationStatus");
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
        [self.manager requestAlwaysAuthorization];
         NSLog(@"__lManager__  didChangeAaStatus  dentro");
    }
    
    
    
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    
    NSLog(@"__locationManager__  didFailWithError");
    
    NSLog(@"__locationManager__  %@", error.description);
    
    NSLog(@"__lManager__  %d", [CLLocationManager authorizationStatus]);
    
    
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusAuthorized:
            NSLog(@"kCLAuthorizationStatusAuthorized");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"kCLAuthorizationStatusAuthorizedWhenInUse");
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"kCLAuthorizationStatusDenied");
            break;
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"kCLAuthorizationStatusNotDetermined");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"kCLAuthorizationStatusRestricted");
            break;
            
        default:
            break;
    }
    
  //  NSLog(@" %@", self.manager.authorizationStatus == kCLAuthorizationStatusNotDetermined);
    /***
     Casi in cui possiamo entrare qui dentro ?? 
     Gestire !!
     ***/
    
}




@end
