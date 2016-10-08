//
//  TFConObject.m
//  TextFix
//
//  Created by Riccardo Gargano on 23/12/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import "TFConObject.h"

@implementation TFConObject


@synthesize requestURL, dataToSent;


-(instancetype)initWhithData:(NSDictionary *)dizionario
                         Url:(NSURL *)to
                 andCallBack:(ONCompleteBlock)comp;
{
    self = [super init];
    if (self) {
        
        dataToSent = dizionario;
        requestURL = to;
        _onCompleteBlock = comp;
    }
    
    return self;
}

- (NSURLRequest *)request
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: requestURL];
    
    if ([dataToSent count] > 0)
    {
        NSString *dataString = [self toQueryString:self.dataToSent];
        NSData *postData = [dataString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        [request setHTTPMethod:@"POST"];
        //[request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
        [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[dataString length]] forHTTPHeaderField:@"Content-length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        [request setHTTPBody: postData];
        
    }
    return request;
}




-(NSString*) toQueryString:(NSDictionary *)dictionary
{
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in dictionary) {
        id value = [dictionary objectForKey: key];
        NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
        [parts addObject: part];
    }
    return [parts componentsJoinedByString: @"&"];
}

static NSString *urlEncode(id object) {
    
    
    NSString *string = [NSString stringWithFormat: @"%@", object];
    return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

@end
