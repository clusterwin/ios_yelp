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
@property (nonatomic, strong) NSNumber *offeringADeal;

- (void)initCategories;

@end

@implementation FiltersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if(self) {
		self.selectedCategories = [NSMutableSet set];
		[self initCategories];
	}
	self.offeringADeal = [NSNumber numberWithBool:NO];
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];
	self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(onApplyButton)];
	self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
	
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	
	[self.tableView registerNib:[UINib nibWithNibName:@"SwitchCell" bundle:nil] forCellReuseIdentifier:@"SwitchCell"];
	
	self.navigationController.navigationBar.barTintColor = [UIColor redColor];
	self.navigationController.navigationBar.translucent = NO;
	
	self.offeringADeal = [NSNumber numberWithBool:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 3)
	{
		return [self.categories count];
	}
	else{
		return 1;
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if(section == 1){
		return @"Distance";
	} else if(section == 2){
		return @"Sort By";
	} else if(section == 3){
		return @"Category";
	} else {
		return nil;
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
	SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
	if(indexPath.section == 3){
		cell.titleLabel.text = self.categories[indexPath.row][@"name"];
		cell.on = [self.selectedCategories containsObject:self.categories[indexPath.row]];
	} else if (indexPath.section == 0) {
		cell.titleLabel.text = @"Offering a Deal";
		cell.on = self.offeringADeal > @TRUE ? TRUE : FALSE;
	}
	cell.delegate = self;
	return cell;
}

- (void)switchCell:(SwitchCell *)cell didUpdateValue:(BOOL)value {
	NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
	if (indexPath.section == 0){
		if (value){
			self.offeringADeal = @YES;
		} else {
			self.offeringADeal = @NO;
		}
	} else if (indexPath.section == 3) {
		if (value){
			[self.selectedCategories addObject:self.categories[indexPath.row]];
		} else {
			[self.selectedCategories removeObject:self.categories[indexPath.row]];
		}
	
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
	
	NSString *offeringADeal = self.offeringADeal == @YES ? @"YES" : @"NO";
	[filters setObject:offeringADeal forKey:@"offering_a_deal"];
	
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
