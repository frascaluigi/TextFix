//
//  TFAnnotation.m
//  TextFix
//
//  Created by Riccardo Gargano on 25/11/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import "TFAnnotation.h"
#import "TFMessage.h"

@implementation TFAnnotation 

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize message;
@synthesize imageUrl;

NSString *myID = @"myAnnotation";

-(id)initWithMessage:(TFMessage*)msg
{
    self = [super init];
    
    if (self)
    {
        message = msg;
        title = msg.autore;
        coordinate.longitude = msg.longitude;
        coordinate.latitude = msg.latitude;
        imageUrl = msg.imageUrl;
        myID = @"annotationPublic";
    }
    return self;
}


-(MKAnnotationView*)annotationView
{
//    MKAnnotationView * annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:myID];
//    
//    annotationView.enabled = YES;
//    annotationView.canShowCallout = YES;
//    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    
//
    
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:self reuseIdentifier:myID];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    NSData *data = [NSData dataWithContentsOfURL:imageUrl];
    UIImage *profileImg = [UIImage imageWithData:data];
    
    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imageButton.frame = CGRectMake(4, 4, 28, 28);
    [imageButton setEnabled:YES];
    [imageButton setUserInteractionEnabled:YES];
    [imageButton setBackgroundImage:profileImg forState:UIControlStateNormal];
    
    annotationView.leftCalloutAccessoryView = imageButton;
    
    return annotationView;
}

-(NSString *)defaultID
{
    return myID;
}



@end
