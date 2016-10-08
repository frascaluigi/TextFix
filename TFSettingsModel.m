//
//  TFSettingsModel.m
//  TextFix
//
//  Created by Riccardo Gargano on 25/11/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import "TFSettingsModel.h"

@interface TFSettingsModel ()


@end


@implementation TFSettingsModel


NSString static * key1 = @"DISTANZA";
NSString static * key2 = @"NOME";
NSString static * key3 = @"PATH";

@synthesize defaults;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}


- (void)writeDistance:(float)dst
{
    NSNumber *distance = [NSNumber numberWithFloat:dst];
    [defaults setObject:distance forKey:key1];
    [defaults synchronize];
}

- (NSNumber *)readDistance
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key1];
}

- (void)writeName:(NSString*)str
{
    [defaults setObject:str forKey:key2];
    [defaults synchronize];
}

- (NSString *)readName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key2];
}

- (void)writePath:(NSString*)str
{
    [defaults setObject:str forKey:key3];
    [defaults synchronize];
}

- (NSString *)readPath
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key3];
}




@end

