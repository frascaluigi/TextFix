//
//  InformationViewController.m
//  TextFix
//
//  Created by Luigi Frasca on 26/11/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import "ShowMessageViewController.h"

@interface ShowMessageViewController ()
{

    
}

@end

@implementation ShowMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"data : %@", self.message);
    
    CLGeocoder* geocoder = [[CLGeocoder alloc ] init];
    CLLocation* message_location = [[CLLocation alloc] initWithLatitude:self.message.latitude longitude:self.message.longitude];
    
    MKCoordinateRegion message_region;
    MKPointAnnotation *message_point = [[MKPointAnnotation alloc] init];
    
    message_region.center = message_location.coordinate;
    message_region.span.latitudeDelta = .001;
    message_region.span.longitudeDelta = .001;
    
    message_point.coordinate = message_location.coordinate;
    
    
    [self.miniMap setRegion:message_region animated:YES];
    self.miniMap.scrollEnabled = false;
    self.miniMap.zoomEnabled = false;
    self.miniMap.pitchEnabled = false;
    self.miniMap.rotateEnabled = false;
    self.miniMap.mapType = MKMapTypeSatellite;
    
    [self.miniMap addAnnotation:message_point];
    
    NSData *data = [NSData dataWithContentsOfURL:self.message.imageUrl];
    
    self.autore.text = self.message.autore;
    self.image.image = [UIImage imageWithData:data];
    self.data.text = self.message.time;
    self.testoMsg.text = self.message.messaggio;
    
    
    
    
    [geocoder reverseGeocodeLocation: message_location
              completionHandler:^(NSArray *placemarks, NSError *error) {
                  if (error == nil && [placemarks count] > 0) {
            
                      CLPlacemark *placemark = [placemarks lastObject];
            
                      self.indirizzo.text =
                      [NSString stringWithFormat:@"%@, %@  (%@)",
                       placemark.thoroughfare,
                       placemark.subThoroughfare,
                       placemark.locality
                      ];
            
                  }else{
                      NSLog(@"%@",error.debugDescription);
                  }
              }
     ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
