//
//  XRTOrderTrackingViewController.m
//  Etion
//
//  Created by wyy on 2017/6/5.
//  Copyright © 2017年 GuangZhouXuanWu. All rights reserved.
//

#import "XRTOrderTrackingViewController.h"
#import "XRTOrderTrackingCell.h"
#import "XRTOrderTrackingLayout.h"

static  NSString *CellID = @"XRTOrderTrackingCell";
@interface XRTOrderTrackingViewController () <UITableViewDelegate, UITableViewDataSource, XRTOrderTrackingCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <XRTOrderTrackingLayout *>* dataArrays;
@property (nonatomic, strong) NSArray *contentArrays;
@end

@implementation XRTOrderTrackingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArrays = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
           [self.view addSubview:self.tableView];
            [self display];
        });
    });
}

- (void)display {
    if (self.dataArrays.count >= self.contentArrays.count) return;
    XRTOrderTrackingModel *model = [XRTOrderTrackingModel new];
    model.failedReason = self.contentArrays[self.dataArrays.count];
    [self.dataArrays addObject:[[XRTOrderTrackingLayout alloc] initWithModel:model]];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:(self.dataArrays.count - 1) inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.dataArrays.count - 1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(AnimationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self display];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%@",self.tableView.visibleCells);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XRTOrderTrackingCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.tag = indexPath.row;
    cell.layout = self.dataArrays[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XRTOrderTrackingLayout *layout = self.dataArrays[indexPath.row];
    return layout.totalHeight;
}

#pragma mark - XRTOrderTrackingCellDelegate
- (void)orderTrackingCellDidFnishedLoad:(XRTOrderTrackingCell *)cell {

//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    if (indexPath == nil) return;
    NSLog(@"indexPath == %ld",cell.tag);
    XRTOrderTrackingLayout *layout = self.dataArrays[cell.tag];
    layout.model.isAlreadyLoadLine = YES;
}

#pragma mark - Get
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.showsHorizontalScrollIndicator = YES;
        [_tableView registerClass:[XRTOrderTrackingCell class] forCellReuseIdentifier:CellID];
        //设置分割线的风格
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

- (NSArray *)contentArrays {
    if (_contentArrays == nil) {
        _contentArrays = [NSArray arrayWithObjects:@"1:上班打卡", @"2:今天天气不错呢", @"3:开始要工作了呢，今天要做好多事请，先列个计划吧，嗯，开始工作。为了加长这个字符串，继续写以下废话，废话很多，用来占位置的，方便测试，嘻嘻哈哈，(*^__^*) 嘻嘻……", @"4:开一会儿小差吧，吃个点心啥的", @"5:哦，还有好多工作啊，别吃了", @"6:嗯，休息时间到了，今天是睡觉呢还是玩儿游戏呢，这是个问题", @"7:继续工作", @"8:继续工作", @"9:想妹子",@"10:继续工作",@"11:继续工作",@"12:继续工作", @"13:好吧，今天还是很满意的",@"14:洗个澡，看个电影，一条狗的使命，等老夫结束南飘生涯，我也要养条金毛", nil];
    }
    return _contentArrays;
}
@end
