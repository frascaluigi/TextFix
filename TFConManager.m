//
//  TFConnection.m
//  TextFix
//
//  Created by Luigi Frasca on 27/11/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import "TFConManager.h"
#define TF_BASEURL "http://textfix.altervista.org/"

@interface TFConManager()


@end

@implementation TFConManager

@synthesize baseURL;


+(void)controlConnection{
    
    NSLog(@"controlConnection init");
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    [reachability startNotifier];
    
    NSLog(@"controlConnection end");

}


-(instancetype)initWhithOptions:(NSDictionary *)opt{
    
    self = [super init];
    if (self) {
        
        baseURL = [ NSURL URLWithString:@TF_BASEURL];
        if (opt && opt[@"baseURL"] ) {
            baseURL = opt[@"baseURL"];
        }
        
        //     imagesUrl = [NSURL URLWithString:@"images/" relativeToURL:baseURL];
        
    }
    
    return self;
}

-(instancetype)init
{
    return [self initWhithOptions:nil];
}


-(void) getDataWith:(TFConObject*) tfObj
{
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask *tasc =
    [
      session dataTaskWithRequest:tfObj.request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                 {
                                      
                     NSLog(@"response %@", response.description);
                     NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                     switch (httpResponse.statusCode) {
                        case 200:
                             tfObj.onCompleteBlock(data);
                        break;
                        case 404:
                             NSLog(@"page not found 404!");
                        break;
                        default:
                        break;
                     }
                     
                     [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                     NSLog(@"getDataFrom ->completionHandler end!");
                     
                 }
    ];
    
    [tasc resume];          // start the task
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}


@end


