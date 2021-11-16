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
{
    CGFloat  ImageWidth;
    CGFloat  ImageHeight;
}

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation STRunloopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.tableView registerNib:[UINib nibWithNibName:@"STRunloopTableViewCell" bundle:nil] forCellReuseIdentifier:@"STRunloopTableViewCell"];
//    [self.tableView registerNib:[UINib nibWithNibName:@"STRunloopTableViewCell" bundle:nil] forCellReuseIdentifier:@"STRunloopTableViewCell"];
    ImageWidth = ImageHeight = [UIScreen mainScreen].bounds.size.width / 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ImageHeight + 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    STRunloopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"STRunloopTableViewCell" forIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[STRunloopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
//    }
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"STRunloopTableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"STRunloopTableViewCell"];
    }
    [self addImage1ToCell:cell];
    [self addImage2ToCell:cell];
    [self addImage3ToCell:cell];
    return cell;
}

- (void)addImage1ToCell:(UITableViewCell*)cell{
    UIImageView* cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, ImageWidth, ImageHeight)];
    cellImageView.image = [UIImage imageNamed:@"Image-1"];
    [cell.contentView addSubview:cellImageView];
}

- (void)addImage2ToCell:(UITableViewCell*)cell{
    UIImageView* cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(1*(ImageWidth+5), 5, ImageWidth, ImageHeight)];
    cellImageView.image = [UIImage imageNamed:@"Image-2"];
    [cell.contentView addSubview:cellImageView];
}


- (void)addImage3ToCell:(UITableViewCell*)cell{
    UIImageView* cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2*(ImageWidth+5), 5, ImageWidth, ImageHeight)];
    cellImageView.image = [UIImage imageNamed:@"Image-3"];
    [cell.contentView addSubview:cellImageView];
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
