//
//  ZWAItemCell.m
//  Homepwner
//
//  Created by Zeon Waa on 3/10/17.
//  Copyright © 2017 Zeon Waa. All rights reserved.
//

#import "ZWAItemCell.h"

@interface ZWAItemCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;



@end

@implementation ZWAItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(updateInterfaceForDynamicTypeSize) name:UIContentSizeCategoryDidChangeNotification object:nil];
    
    NSLayoutConstraint *thumbnailViewConstraint = [NSLayoutConstraint constraintWithItem:self.thumbnailView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.thumbnailView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    [self.thumbnailView addConstraint:thumbnailViewConstraint];
    
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

- (void)updateInterfaceForDynamicTypeSize {
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.nameLabel.font = font;
    self.serialNumberLabel.font = font;
    self.valueLabel.font  = font;

    static NSDictionary *imageSizeDictionary;
    if (!imageSizeDictionary) {
        imageSizeDictionary = @{
                                 UIContentSizeCategoryExtraSmall : @40,
                                 UIContentSizeCategorySmall : @40,
                                 UIContentSizeCategoryMedium : @40,
                                 UIContentSizeCategoryLarge : @40,
                                 UIContentSizeCategoryExtraLarge : @45,
                                 UIContentSizeCategoryExtraExtraLarge : @55,
                                 UIContentSizeCategoryExtraExtraExtraLarge : @65
                                 
                                 };
        }
        NSString *userSize = [[UIApplication sharedApplication] preferredContentSizeCategory];
        NSNumber *imageSize = imageSizeDictionary[userSize];
        self.imageHeightConstraint.constant = imageSize.floatValue;
        
    
}

- (void)dealloc {
    NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];

}

@end
