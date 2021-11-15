//
//  STRunloopViewController.m
//  STInterViewProject
//
//  Created by song on 2021/11/16.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STRunloopViewController.h"
#import "STRunloopTableViewCell.h"

@interface STRunloopViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation STRunloopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerClass:[STRunloopTableViewCell class] forCellReuseIdentifier:@"STRunloopTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    STRunloopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"STRunloopTableViewCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[STRunloopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"STRunloopTableViewCell"];
    }
    cell.titleLabel.text = [NSString stringWithFormat:@"cell row = %d", indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:@"bigImage"];
    return cell;
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
