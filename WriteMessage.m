//
//  WriteMessage.m
//  TextFix
//
//  Created by Riccardo Gargano on 14/09/16.
//  Copyright © 2016 Riccardo Gargano. All rights reserved.
//

#import "WriteMessage.h"
#import "AppDelegate.h"
#import "TFSettingsModel.h"
#import "TFConObject.h"

@interface WriteMessage (){
    AppDelegate* delegate;
}

@property (strong, readwrite) TFSettingsModel *model;
@end


@implementation WriteMessage

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.model = [[TFSettingsModel alloc] init];
    
    CLLocationCoordinate2D message_location;
    MKCoordinateRegion message_region;
    MKPointAnnotation *message_point = [[MKPointAnnotation alloc] init];
    
    delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    message_location = delegate.locationManager.currentLocation.coordinate;
    
    message_region.center = message_location;
    message_region.span.latitudeDelta = .001;
    message_region.span.longitudeDelta = .001;
    
    message_point.coordinate = message_location;
    
    
    [self.miniMap setRegion:message_region animated:YES];
    self.miniMap.scrollEnabled = false;
    self.miniMap.zoomEnabled = false;
    self.miniMap.pitchEnabled = false;
    self.miniMap.rotateEnabled = false;
    self.miniMap.mapType = MKMapTypeSatellite;
    
    [self.miniMap addAnnotation:message_point];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    NSString* name = [self.model readName];
    if (name && name.length) {
        [self.label setFont:[self.label.font fontWithSize: 17.0]];
        self.label.text = [NSString stringWithFormat: @"Autore:  %@", name];
    }else{
        [self.label setFont:[self.label.font fontWithSize: 12.0]];
        self.label.text = @"inserisci il nome in Impostazioni > profilo";
    }

}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


- (IBAction)submit:(id)sender {
    
    [self.view endEditing:YES];
     
    NSString* name = [self.model readName];
    if (name && name.length)  {
        
        NSString* msgTxt = self.msgText.text;
        msgTxt = [ msgTxt stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if (msgTxt && msgTxt.length) {
            // INVIA MSG
            
            ONCompleteBlock block = ^(NSData *data){ NSLog([[NSString alloc] initWithData:data encoding: NSASCIIStringEncoding]);};
            NSURL *toUrl = [NSURL URLWithString:@"prova.php" relativeToURL:delegate.connection.baseURL];
            NSDictionary *datiPost = [[NSDictionary alloc] initWithObjectsAndKeys: name, @"NOME", msgTxt, @"MESSAGGIO", nil];
            
            TFConObject *connObj = [[TFConObject alloc] initWhithData:datiPost Url:toUrl andCallBack:block];
            [delegate.connection getDataWith:connObj];
            
            // TORNA INDIETRO
            [self performSegueWithIdentifier:@"unwindGoWriteMessage" sender:self];
            
        }else{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"INVIO FALLITO"
                                                                           message:@"inserisci il messaggio"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:nil];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        } // END-IF  EXIST MSG
    }else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"INVIO FALLITO"
                                                                       message:@"Devi prima inserire il nome! vai in impostazioni->profilo"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:nil];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}



#pragma text

-(void)animateTextView:(UITextView*)textView up:(BOOL)up withOffset:(CGFloat)offset
{
    float dst = (self.view.frame.size.height - ( self.submitButton.frame.origin.y + self.submitButton.frame.size.height + 5 ));
    
    offset = offset - dst;
    
    const int movementDistance = -offset;
    const float movementDuration = 0.4f;
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}



#pragma Notification

-(void)keyboardWillShow:(NSNotification*)notification
{
    
    NSDictionary* userInfo = [notification userInfo];
    CGRect keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    [self animateTextView:self.msgText up:YES withOffset:keyboardSize.size.height];
}

-(void)keyboardWillHide:(NSNotification*)notification
{
    
    NSDictionary* userInfo = [notification userInfo];
    CGRect keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    [self animateTextView:self.msgText up:NO withOffset:keyboardSize.size.height];
    
}


@end




