//
//  FiltersViewController.h
//  Yelp
//
//  Created by Alex Lester on 11/2/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FiltersViewController;

@protocol FiltersViewControllerDelegate <NSObject>

- (void)filtersViewController:(FiltersViewController *)
filtersViewController didChangeFilters:(NSDictionary *)filters;

@end

@interface FiltersViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) id<FiltersViewControllerDelegate> delegate;

@end
