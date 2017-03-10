//
//  ZWAItemCell.m
//  Homepwner
//
//  Created by Zeon Waa on 3/10/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import "ZWAItemCell.h"

@implementation ZWAItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showImage:(id)sender {
    if (self.actionBlock) {
        self.actionBlock();
    }

}

@end
