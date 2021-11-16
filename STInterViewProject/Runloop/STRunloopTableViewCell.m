//
//  STRunloopTableViewCell.m
//  STInterViewProject
//
//  Created by song on 2021/11/16.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STRunloopTableViewCell.h"

@interface STRunloopTableViewCell ()

@end

@implementation STRunloopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_titleLabel release];
    [_iconImageView release];
    [super dealloc];
}

@end
