//
//  MessageView.m
//  TextFix
//
//  Created by Riccardo Gargano on 15/09/16.
//  Copyright © 2016 Riccardo Gargano. All rights reserved.
//

#import "MessageViewController.h"
#import "AppDelegate.h"
#import "TFMessage.h"
#import "TFCell.h"
#import "ShowMessageViewController.h"

@implementation MessageViewController
{
    AppDelegate *delegate;
    NSArray<TFMessage *> *messages;
}

- (void)viewDidLoad
{
    NSLog(@"viewdidload ____MessageView");
    [super viewDidLoad];
    
    delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    messages = delegate.messages.allValues;
    
    UIBarButtonItem *btnR = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(press)];
    
    [self.navigationItem setRightBarButtonItem:btnR];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(DownloadedMessage:)
     name:@"messagesDownloadedNotify"
     object:nil
     ];
}


-(void)viewWillAppear:(BOOL)animated{
     NSLog(@"viewWillAppear ____MessageView");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (void)press{
    [self performSegueWithIdentifier:@"goWriteMessage" sender:self];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"goInformation"]) {
        if ([segue.destinationViewController isKindOfClass:[ShowMessageViewController class]]) {
            ShowMessageViewController *info = (ShowMessageViewController *)segue.destinationViewController;
            
            if ([sender isKindOfClass:[NSIndexPath class]]){
                NSIndexPath *indexPath = (NSIndexPath *) sender;
                
                TFMessage *message = messages[indexPath.row];
                    
                info.message = message;
            }
        } // endIF segue.destinationViewController
    } // endIF segue.identifier
    
}

- (IBAction)unwindSegue:(UIStoryboardSegue *)segue {
    
    
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return delegate.messages.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
     //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TFcell" forIndexPath:indexPath];
 
     TFCell *cell = (TFCell *) [tableView dequeueReusableCellWithIdentifier:@"TFcell" forIndexPath:indexPath];
     
     if (cell == nil) {
         cell = [[TFCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TFcell"];
     }
     
     
     TFMessage *msg = messages[indexPath.row];
     NSData *data = [NSData dataWithContentsOfURL: msg.imageUrl];
     
     CLLocation * locMsg = [[CLLocation alloc] initWithLatitude:msg.latitude longitude:msg.longitude];
     double dist = [delegate.locationManager.currentLocation distanceFromLocation:locMsg];
     
     cell.autore.text = msg.autore;
     cell.avatar.image = [UIImage imageWithData:data];
     cell.messaggio.text = msg.messaggio;
     cell.distLabel.text = [ NSString stringWithFormat:@"dist: %.1fm", dist];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     
     return cell;
 }


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"goInformation" sender:indexPath];
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */




 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }

#pragma mark - Notification 


-(void)DownloadedMessage:(NSNotification *)notification{
    
    messages = delegate.messages.allValues;
    [self.tableView reloadData];
    
    NSLog(@"MessageViewController -> DownloadedMessage ");
    
}


@end
