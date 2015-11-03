//
//  LabelCell.h
//  Yelp
//
//  Created by Alex Lester on 11/3/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LabelCell;

@protocol LabelCellDelegate <NSObject>

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

@end

@interface LabelCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (nonatomic, weak) id<LabelCellDelegate> delegate;



@end
