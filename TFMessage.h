//
//  TFMessage.h
//  TextFix
//
//  Created by Luigi Frasca on 26/11/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFMessage : NSObject


@property(strong, nonatomic) NSString * autore;
@property(strong, nonatomic) NSURL * imageUrl;
@property(strong, nonatomic) NSString * messaggio;
@property(strong, nonatomic) NSString * time;
@property(nonatomic, readwrite) double latitude;
@property(nonatomic, readwrite) double longitude;

-(instancetype)initWithJSON:(NSDictionary *) jsonObject;

@end
