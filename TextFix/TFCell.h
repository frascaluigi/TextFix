//
//  TFCell.h
//  TextFix
//
//  Created by Riccardo Gargano on 15/12/15.
//  Copyright (c) 2015 Riccardo Gargano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *autore;
@property (weak, nonatomic) IBOutlet UILabel *messaggio;
@property (weak, nonatomic) IBOutlet UILabel *distLabel;

@end
