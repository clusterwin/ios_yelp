//
//  FiltersViewController.m
//  Yelp
//
//  Created by Alex Lester on 11/2/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "FiltersViewController.h"
#import "SwitchCell.h"

@interface FiltersViewController () <UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate>

@property (nonatomic, readonly) NSDictionary *filters;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSMutableSet *selectedCategories;

- (void)initCategories;

@end

@implementation FiltersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if(self) {
		self.selectedCategories = [NSMutableSet set];
		[self initCategories];
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(onApplyButton)];
	
	
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	
	[self.tableView registerNib:[UINib nibWithNibName:@"SwitchCell" bundle:nil] forCellReuseIdentifier:@"SwitchCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
	SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
	cell.titleLabel.text = self.categories[indexPath.row][@"name"];
	cell.on = [self.selectedCategories containsObject:self.categories[indexPath.row]];
	cell.delegate = self;
	return cell;
}

- (void)switchCell:(SwitchCell *)cell didUpdateValue:(BOOL)value {
	NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
	
	if (value){
		[self.selectedCategories addObject:self.categories[indexPath.row]];
	} else {
		[self.selectedCategories removeObject:self.categories[indexPath.row]];
	}
}

- (NSDictionary *)filters{
	NSMutableDictionary *filters = [NSMutableDictionary dictionary];
	
	if(self.selectedCategories.count > 0){
		NSMutableArray *names = [NSMutableArray array];
		for (NSDictionary *category in self.selectedCategories) {
			[names addObject:category[@"code"]];
		}
		NSString *categoryFilter = [names componentsJoinedByString:@","];
			 [filters setObject:categoryFilter forKey:@"category_filter"];
			 
	}
	return filters;
}

- (void) onCancelButton{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onApplyButton{
	[self.delegate filtersViewController:self didChangeFilters:self.filters];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initCategories{
	self.categories =
  @[
  @{@"name" : @"Afghan", @"code":@"afghani" },
  @{@"name" : @"African", @"code":@"african" },
  @{@"name" : @"American, New", @"code":@"newamerican" },
  @{@"name" : @"Australian", @"code":@"australian" }
  ];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
