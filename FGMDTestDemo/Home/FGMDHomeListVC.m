//
//  FGMDHomeListVC.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/5.
//

#import "FGMDHomeListVC.h"
#import "FGMDHomeListTableViewCell.h"
#import "FGMDTableIMP.h"
#import "FGMDTargetActionViewController.h"

@interface FGMDHomeListVC ()
@property (nonatomic, strong) UITableView *homeTable;
@property (nonatomic, strong) FGMDTableIMP *tableIMP;
@end

@implementation FGMDHomeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"可视化埋点测试";
}

- (void)initSubviews {
    [super initSubviews];
    [self.view addSubview:self.homeTable];
    [self configHomeTableCellConfigs];
    
    
    _tableIMP.didSelectRowAtIndexPath = ^(NSIndexPath * _Nonnull indexPath) {
        if (indexPath.row == 0) {
            FGMDTargetActionViewController *targetVC = [FGMDTargetActionViewController new];
            [self.navigationController pushViewController:targetVC animated:YES];
        }
    };
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.homeTable.frame = self.view.bounds;
}

- (void)configHomeTableCellConfigs {
    NSArray *titleArray = @[@"testView"];
    [titleArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FGMDHomeListTableCellConfig *config = [FGMDHomeListTableCellConfig new];
        config.cellTitle = titleArray[idx];
        config.cellClass = FGMDHomeListTableViewCell.class;
        [self.homeTable.ybht_rowArray addObject:config];
    }];
    [self.homeTable reloadData];
}

- (UITableView *)homeTable {
    if (!_homeTable) {
        _homeTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _homeTable.tableFooterView = [UIView new];
        _tableIMP = [FGMDTableIMP new];
        _homeTable.ybht_tableIMP = _tableIMP;
    }
    return _homeTable;
}

@end
