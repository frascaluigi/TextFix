//
//  TFMessage.m
//  TextFix
//
//  Created by Luigi Frasca on 26/11/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import "TFMessage.h"


@interface TFMessage()


@end

@implementation TFMessage


@synthesize latitude;
@synthesize longitude;

-(instancetype)initWithJSON:(NSDictionary *)jsonObject{
    
    self = [super init];
    
    if(self)
    {
        self.autore = jsonObject[@"autore"];
        self.imageUrl = [NSURL URLWithString:jsonObject[@"imageUrl"]];
        self.messaggio = jsonObject[@"messaggio"];
        self.time = jsonObject[@"time"];
        self.latitude = [ jsonObject[@"latitudine"] doubleValue];
        self.longitude = [ jsonObject[@"longitudine"] doubleValue];
    }
    
    return self;
    
}

@end


