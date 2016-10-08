//
//  SettingsTableViewController.h
//  TextFix
//
//  Created by Riccardo Gargano on 25/11/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFSettingsModel.h"
#import "Reachability.h"

@interface InformationViewController : UITableViewController <UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *settingsTable;

@property (strong, nonatomic) IBOutlet UISlider *distanceSlider;

@property (strong, readwrite) TFSettingsModel *model;

@end
