//
//  WriteMessage.h
//  TextFix
//
//  Created by Riccardo Gargano on 14/09/16.
//  Copyright © 2016 Riccardo Gargano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface WriteMessage : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *miniMap;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *msgText;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end
