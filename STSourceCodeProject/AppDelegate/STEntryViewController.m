//
//  STEntryViewController.m
//  STSourceCodeProject
//
//  Created by song on 2020/8/20.
//  Copyright © 2020 Knowin. All rights reserved.
//

#import "STEntryViewController.h"
#import "STEntryData.h"
#import "STBaseViewController.h"

@interface STEntryViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) STEntryData *entry;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end

@implementation STEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self setDataSources];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.entry.sections.count;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    STEntrySection *sectionData = self.entry.sections[section];
    return sectionData.cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    STEntrySection *sectionData = self.entry.sections[indexPath.section];
    STEntryCell *cellData = sectionData.cells[indexPath.row];
    cell.textLabel.text = cellData.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    STEntrySection *sectionData = self.entry.sections[indexPath.section];
    STEntryCell *cellData = sectionData.cells[indexPath.row];
    
    STBaseViewController *controller = [[NSClassFromString(cellData.controllerClassName) alloc] init];
    controller.title = cellData.title;
    [self.navigationController pushViewController:controller animated:YES];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    STEntrySection *sectionData = self.entry.sections[section];
    return sectionData.title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)setDataSources {
    self.entry = [STEntryData constructDefaultEntryData];
}

@end
