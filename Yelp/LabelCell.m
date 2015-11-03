//
//  LabelCell.m
//  Yelp
//
//  Created by Alex Lester on 11/3/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "LabelCell.h"

@implementation LabelCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
	if (selected){
		self.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		self.accessoryType = UITableViewCellAccessoryNone;
	}
}

@end
