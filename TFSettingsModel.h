//
//  TFSettingsModel.h
//  TextFix
//
//  Created by Riccardo Gargano on 25/11/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFSettingsModel : NSObject

@property(strong, readwrite) NSUserDefaults *defaults;

-(instancetype)init;

-(void)writeDistance:(float)dst;
-(NSNumber *)readDistance;

- (void)writeName:(NSString*)str;
- (NSString *)readName;

- (void)writePath:(NSString*)str;
- (NSString *)readPath;

@end
