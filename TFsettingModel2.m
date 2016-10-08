//
//  TFsettingModel2.m
//  TextFix
//
//  Created by Riccardo Gargano on 23/12/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import "TFsettingModel2.h"

@implementation TFsettingModel2

+(void) setObj:(id)obj forKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj forKey:key];
    [defaults synchronize];
    
}

+(id) objForKey:(NSString *)key{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


@end
