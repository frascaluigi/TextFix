//
//  TFAnnotation.h
//  TextFix
//
//  Created by Riccardo Gargano on 25/11/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "TFMessage.h"

@interface TFAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic, readonly, copy) NSURL *imageUrl;

@property (nonatomic, readwrite) TFMessage *message;

-(id)initWithMessage:(TFMessage*)msg;

-(MKAnnotationView *) annotationView;
-(NSString *) defaultID;


@end
