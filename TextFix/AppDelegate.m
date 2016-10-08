//
//  AppDelegate.m
//  TextFix
//
//  Created by Riccardo Gargano on 25/11/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import "AppDelegate.h"
#import "TFSettingsModel.h"

@interface AppDelegate (){
    TFSettingsModel* model;
}

@end

@implementation AppDelegate
@synthesize connection, locationManager, reachability, messages = _messages;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"___AppDelegate___");
    NSLog(@"_didFinishLaunchingWithOptions_");
    
    locationManager = [[TFLocManager alloc] init];
    connection      = [[TFConManager alloc] init];
    _messages       = [[NSMutableDictionary alloc] init];
    self.reachability = [Reachability reachabilityForInternetConnection];
    
    model = [[TFSettingsModel alloc] init];
    if (![model readDistance])
        [model writeDistance:50.0];
    
    
    [ self.reachability startNotifier ];
    
    [ self handleNetworkChange:NULL]; //controllo stato connessione
    
    // registriamo le notifiche
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(DownloadedMessage:)
     name:@"messagesDownloadedNotify"
     object:nil
     ];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(UpdateLocation:)
     name:@"locationUpdateNotify"
     object:nil
     ];

    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleNetworkChange:)
     name:kReachabilityChangedNotification
     object:nil];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    NSLog(@"applicationWillEnterForeground :::");
    
    [self handleNetworkChange:NULL];
    
    //[locationManager.manager startUpdatingLocation];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
   // NSLog(@"chiamata applicationDidBecomeActive");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma Notification

-(void)DownloadedMessage:(NSNotification *)notification
{
    
    NSLog(@"___AppDelegate_________DownloadedMessage___");
    
    NSArray *jsonMessages = [[ notification userInfo] objectForKey:@"messages"];
    
    for (id msg in jsonMessages)
    {
        NSDictionary *jsonObject = (NSDictionary *)msg;
        TFMessage *TFmsg = [[TFMessage alloc] initWithJSON:jsonObject];   // CREATE TFMessage FROM JSON
        [ _messages setObject:TFmsg forKey:jsonObject[@"messageID"]];      // ADD TFMessage ON MESSAGES
    }
}

-(void)UpdateLocation:(NSNotification *)notification
{
    NSLog(@"___AppDelegate_________UpdateLocation__");
    
    ONCompleteBlock block = ^(NSData *data){
        NSDictionary *jsonMessages = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"messagesDownloadedNotify" object:self userInfo:jsonMessages];
    };
    NSURL *toUrl = [NSURL URLWithString:@"prova.php" relativeToURL:connection.baseURL];
    
    NSNumber *latitude = [[NSNumber alloc] initWithDouble:self.locationManager.currentLocation.coordinate.latitude];
    NSNumber *longitude = [[NSNumber alloc] initWithDouble:self.locationManager.currentLocation.coordinate.longitude];
    NSNumber *distance = [model readDistance];
    
    NSDictionary *datiPost = [[NSDictionary alloc] initWithObjectsAndKeys: latitude, @"lat", longitude, @"lon", distance, @"distance", nil];
    
    TFConObject *connObj = [[TFConObject alloc] initWhithData:datiPost Url:toUrl andCallBack:block];
    [connection getDataWith:connObj];
    
}

- (void) handleNetworkChange:(NSNotification *)notice
{
    NSLog(@"handleNetworkChange init");
    
    NetworkStatus remoteHostStatus = [self.reachability currentReachabilityStatus];
    
    switch (remoteHostStatus) {
        case NotReachable:
            NSLog(@"NotReachable");
            break;

        case ReachableViaWiFi:
            
        case ReachableViaWWAN:
            [self.locationManager startUpdate];
            break;
        default:
            break;
    }
}


@end





