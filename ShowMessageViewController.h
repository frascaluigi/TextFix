//
//  InformationViewController.h
//  TextFix
//
//  Created by Luigi Frasca on 26/11/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TFMessage.h"

@interface ShowMessageViewController : UIViewController


@property (nonatomic, readwrite) TFMessage *message;
@property (weak, nonatomic) IBOutlet MKMapView *miniMap;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *testoMsg;
@property (weak, nonatomic) IBOutlet UILabel *autore;
@property (weak, nonatomic) IBOutlet UILabel *data;
@property (weak, nonatomic) IBOutlet UILabel *indirizzo;


@end
