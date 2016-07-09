//
//  JKSortCell.m
//  JKOneBuy
//
//  Created by teaplant on 16/6/23.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "JKSortCell.h"
#import "UIImageView+WebCache.h"

@implementation JKSortCell


-(void)setSortInfo:(JKSortModel *)model{
    
    
    [self.sortImg sd_setImageWithURL:[NSURL URLWithString:model.pro_icon] placeholderImage:nil];
    self.sortName.text=model.pro_name;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}






@end
