//
//  ViewController.m
//  TextFix
//
//  Created by Riccardo Gargano on 25/11/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import "AppDelegate.h"
#import "MapViewController.h"
#import "TFAnnotation.h"
#import "TFMessage.h"
#import "ShowMessageViewController.h"

@interface MapViewController ()
{
    AppDelegate *delegate;
    MKCoordinateRegion user_region;
}

@property (strong, nonatomic) CLLocation *currentLocation;

@end



@implementation MapViewController

@synthesize map;
//@synthesize currentLocation;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    delegate = [[UIApplication sharedApplication] delegate];
    
    self.map.delegate = self;
    self.map.zoomEnabled = YES;
    
    
    MKUserTrackingBarButtonItem *buttonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.map];
    [self.navigationItem setRightBarButtonItem: buttonItem];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(DownloadedMessage:)
     name:@"messagesDownloadedNotify"
     object:nil
     ];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(UpdateLocation:)
     name:@"locationUpdateNotify"
     object:nil
     ];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"___MapViewController___");
    NSLog(@"_viewWillAppear_");
    self.map.showsUserLocation = YES;
    
}


- (void)viewWillDisappear:(BOOL)animated{

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - MKMapViewDelegate


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if([annotation isKindOfClass:[TFAnnotation class] ])
    {
        TFAnnotation *myAnnotation = (TFAnnotation *) annotation;
        
        MKAnnotationView *annotationView;
        
        annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:myAnnotation.defaultID];
        
        if (annotationView == nil) {
            annotationView = myAnnotation.annotationView;
        }
        return annotationView;
    }
    return nil;
    
}


- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    NSLog(@"mapViewDidFailLoadingMap er: %@", error.description);
}


-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    //NSLog(@"mapViewDidFinishLoadingMap:: CARICATA");
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if (![view.annotation isKindOfClass:[TFAnnotation class]])
        return;
    
    [self performSegueWithIdentifier:@"goInformation" sender:view];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    TFMessage *message = nil;
    
    if ([segue.identifier isEqualToString:@"goInformation"]) {
        if ([segue.destinationViewController isKindOfClass:[ShowMessageViewController class]]) {
            ShowMessageViewController *info = (ShowMessageViewController *)segue.destinationViewController;
            
            if ([sender isKindOfClass:[MKAnnotationView class]]){
                MKAnnotationView *annotationView = (MKAnnotationView *) sender;
                
                if ([annotationView.annotation isKindOfClass:[TFAnnotation class]]){
                    
                    TFAnnotation *tfAnnotation = (TFAnnotation *) annotationView.annotation;
                    
                    message = tfAnnotation.message;
                    
                    info.message = message;
                }
           }
            
            
        } // endIF segue.destinationViewController
    } // endIF segue.identifier
    
    
}



#pragma mark - Notification

-(void)DownloadedMessage:(NSNotification *)notification{
    
    for (TFMessage *TFmsg in delegate.messages.allValues )
    {
        [ self.map addAnnotation:[[TFAnnotation alloc] initWithMessage:TFmsg] ];  // SHOW ON MAP
    }
    
    NSLog(@"MapViewController -> DownloadedMessage ");
    
}


-(void)UpdateLocation:(NSNotification *)notification{
    
    self.currentLocation = [[ notification userInfo] objectForKey:@"location"];
    
    user_region.center = self.currentLocation.coordinate;
    user_region.span.latitudeDelta = .02;
    user_region.span.longitudeDelta = .02;
    
    [self.map setRegion:user_region animated:YES];

    NSLog(@"MapViewController->locationUpdateNotification %f %f", self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude);
    
    
}



@end
