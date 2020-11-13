//
//  FGMDInfoListViewController.m
//  FGMDTestDemo
//
//  Created by Meikeo on 2020/11/11.
//

#import "FGMDInfoListViewController.h"
#import "FGMDInfoListTableViewCell.h"

@interface FGMDInfoListViewController ()
@property (nonatomic, strong) UITableView *listTable;

@end

@implementation FGMDInfoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"埋点记录";
}

- (void)initSubviews {
    [super initSubviews];
    [self.view addSubview:self.listTable];
    [self configListTableCellConfigs];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.listTable.frame = self.view.bounds;
}

- (void)configListTableCellConfigs {
    NSArray *mdArray = [[FGMDConfig defaultConfig] readAllMdList];
    
    [mdArray enumerateObjectsUsingBlock:^(FGMDInfoModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FGMDInfoListTableCellConfig *cellConfig = [FGMDInfoListTableCellConfig new];
        cellConfig.cellClass = FGMDInfoListTableViewCell.self;
        cellConfig.event = obj.eventId;
        cellConfig.content = obj.content;
        cellConfig.time = obj.time;
        
        //倒序 最新的在前面
        [self.listTable.ybht_rowArray insertObject:cellConfig atIndex:0];
    }];
    [self.listTable reloadData];
}

- (UITableView *)listTable {
    if (!_listTable) {
        _listTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listTable.tableFooterView = [UIView new];
    }
    return _listTable;
}

@end
