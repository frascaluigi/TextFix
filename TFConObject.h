//
//  TFConObject.h
//  TextFix
//
//  Created by Riccardo Gargano on 23/12/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ONCompleteBlock)(NSData *data);

@interface TFConObject : NSObject

@property (nonatomic,readonly) NSDictionary *dataToSent;
@property (nonatomic,readonly) NSURL *requestURL;
@property (copy) ONCompleteBlock onCompleteBlock;


-(instancetype)initWhithData:(NSDictionary *)diz
                         Url:(NSURL *)to
                 andCallBack:(ONCompleteBlock)comp;

- (NSURLRequest *)request;

@end
