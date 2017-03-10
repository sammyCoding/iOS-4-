//
//  ZWAItemCell.h
//  Homepwner
//
//  Created by Zeon Waa on 3/10/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWAItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@property (nonatomic, copy) void (^actionBlock)(void);

@end
