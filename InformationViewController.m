//
//  SettingsTableViewController.m
//  TextFix
//
//  Created by Riccardo Gargano on 25/11/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()
@property (strong, nonatomic) IBOutlet UILabel *statoConnessione;

@end

@implementation InformationViewController

//@synthesize settingsTable;
@synthesize distanceSlider, statoConnessione;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settingsTable.delegate = self;
    self.model = [[TFSettingsModel alloc] init];
    self.distanceSlider.value = [[self.model readDistance]floatValue];
    
    [self handleNetworkChange:NULL];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleNetworkChange:)
     name:kReachabilityChangedNotification
     object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear ");
    //todo
}


-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"viewWillDisappear ");
    //todo
}

- (IBAction)changeDistance:(id)sender {
   
    NSLog(@"dist %f ", distanceSlider.value);
    
    [self.model writeDistance:distanceSlider.value];
}


- (void) handleNetworkChange:(NSNotification *)notice
{
    NSLog(@"handle conn init");
    
    
    NetworkStatus remoteHostStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    
    UIColor *redColor = [[UIColor alloc] initWithRed:1 green:0 blue:0 alpha:1];
    UIColor *greenColor = [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:1];
    
    //[statoConnessione setFont:[UIFont fontWithName:@"System" size:10]];
    
    switch (remoteHostStatus) {
        case NotReachable:
            statoConnessione.text = @"disconnesso";
            [statoConnessione setTextColor: redColor];
            break;
            
        case ReachableViaWiFi:
        case ReachableViaWWAN:
            statoConnessione.text = @"connesso";
            [statoConnessione setTextColor: greenColor];
            break;
        default:
            break;
    }
    
    NSLog(@"handle conn end");
    
}


//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
