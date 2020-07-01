//
//  GTNewsViewController.m
//  SampleApp
//
//  Created by mengtuosun on 2020/6/11.
//  Copyright © 2020 mengtuosun. All rights reserved.
//

#import "GTNewsViewController.h"
#import "GTNormalTableViewCell.h"
#import "GTDetailViewController.h"
#import "GTDeleteCellView.h"
#import "GTListLoader.h"
#import "GTListItem.h"

@interface GTNewsViewController () <UITableViewDataSource, UITableViewDelegate, GTNormalTableViewCellDelegate>

@property(nonatomic, strong) UIView* testView;

@property(nonatomic, strong) UITableView* tableView;

@property(nonatomic, strong) NSArray* dataArray;

@property(nonatomic, strong) GTListLoader* listLoader;

@end

@implementation GTNewsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"新闻";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/page@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/page_selected@2x.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.tableView];
    
    self.listLoader = [[GTListLoader alloc]init];
    
    __weak __typeof(self) weakSelf = self;
    [self.listLoader loadDataWithFinishBlock:^(BOOL success, NSArray<GTListItem *> * _Nonnull itemArray) {
        __strong __typeof(self) strongSelf = weakSelf;
        if (success) {
            strongSelf.dataArray = [itemArray copy];
            [strongSelf.tableView reloadData];
        }
    }];

    UIGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.testView addGestureRecognizer:tapGesture];
#if APPCLIP
    NSLog(@"============APPCLIP============");
#endif
}

- (UIView *)testView
{
    if (!_testView) {
        _testView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
        _testView.backgroundColor = [UIColor greenColor];
    }
    return _testView;
}

#pragma mark - action

- (void)tap
{
    UIViewController* viewController = [[UIViewController alloc]init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.navigationItem.title = @"内容";
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"右侧标题" style:UIBarButtonItemStylePlain target:self action:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GTNormalTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[GTNormalTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        cell.delegate = self;
    }
    GTListItem* item = [self.dataArray objectAtIndex:indexPath.row];
    [cell layoutTableViewCellWithItem:item];
    return cell;
}

#pragma mark - delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GTListItem* item = [self.dataArray objectAtIndex:indexPath.row];
    GTDetailViewController* controller = [[GTDetailViewController alloc]initWithUrlString:item.articleUrl];
    controller.navigationItem.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    controller.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)tableViewCell:(UITableViewCell*)tableViewCell clickDeleteButton:(UIButton*)deleteButton
{
    CGRect frame = [tableViewCell convertRect:deleteButton.frame toView:nil];
    GTDeleteCellView* deleteView = [[GTDeleteCellView alloc] initWithFrame:self.view.bounds];
    
    __weak __typeof(self) weakSelf = self;
    [deleteView showDeleteViewFromPoint:frame.origin clickBlock:^{
        __strong __typeof(self) strongSelf = weakSelf;
//        [strongSelf.dataArray removeLastObject];
        [strongSelf.tableView deleteRowsAtIndexPaths:@[[strongSelf.tableView indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

#pragma mark - Getters and Setters

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //    tableView.tableHeaderView = self.tableHeaderView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end
