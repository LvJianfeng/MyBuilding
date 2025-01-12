//
//  DemandAskPriceChatController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/24.
//
//

#import "DemandAskPriceChatController.h"
#import "AskPriceApi.h"
#import "DemandChatViewCell.h"
#import "AskPriceComment.h"
#import "MJRefresh.h"
#import "MyTableView.h"
@interface DemandAskPriceChatController ()
@property(nonatomic)int startIndex;
@end

@implementation DemandAskPriceChatController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.startIndex = 0;
    [self setupRefresh];
    [self loadList];
}


-(void)loadList{
    self.startIndex = 0;
    [AskPriceApi GetCommentListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.chatModels = posts;
            if(self.chatModels.count == 0){
                [MyTableView reloadDataWithTableView:self.tableView];
                [MyTableView hasData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
    } tradeId:self.askPriceModel.a_id tradeUserAndCommentUser:[NSString stringWithFormat:@"%@:%@",self.askPriceModel.a_createdBy,self.quotesModel.a_loginId] startIndex:0 noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemandChatViewCellModel *model = [[DemandChatViewCellModel alloc] init];
    AskPriceComment *commentModel = self.chatModels[indexPath.row];
    model.userName = commentModel.a_name;
    model.userDescribe = commentModel.a_isVerified;
    model.time = commentModel.a_createdTime;
    model.content = commentModel.a_contents;
    model.isSelf = commentModel.a_isSelf;
    return [DemandChatViewCell carculateTotalHeightWithModel:model];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemandChatViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"chatCell"];
    if (!cell) {
        cell=[[DemandChatViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"chatCell"];
    }
    DemandChatViewCellModel *model = [[DemandChatViewCellModel alloc] init];
    AskPriceComment *commentModel = self.chatModels[indexPath.row];
    model.userName = commentModel.a_name;
    model.userDescribe = commentModel.a_isVerified;
    model.time = commentModel.a_createdTime;
    model.content = commentModel.a_contents;
    model.isSelf = commentModel.a_isSelf;
    model.isHonesty = commentModel.a_isHonesty;
    cell.model=model;
    return cell;
}
/**
 *tradeId	string	询价ID	必填	不可为空
 *tradeCode	string	询价code	必填	不可为空
 *tradeUserAndCommentUser	string	询价人ID:报价人ID	必填	不可为空
 *contents
 */
-(void)sendWithContent:(NSString*)content{
    if (!content.length) return;
    NSString* tradeUserAndCommentUser=[NSString stringWithFormat:@"%@:%@",self.askPriceModel.a_createdBy,self.quotesModel.a_loginId];
    NSMutableDictionary* dic=[@{@"tradeId":self.askPriceModel.a_id,
                                @"tradeCode":self.askPriceModel.a_tradeCode,
                                @"tradeUserAndCommentUser":tradeUserAndCommentUser,
                                @"contents":content} mutableCopy];
    [AskPriceApi AddCommentWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.chatModels removeAllObjects];
            [self loadList];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    } dic:dic noNetWork:^{
        [ErrorCode alert];
    }];
}

-(void)chatToolSendBtnClickedWithContent:(NSString *)content{
    [self sendWithContent:content];
}

-(NSMutableArray *)chatModels{
    if (!_chatModels) {
        _chatModels=[NSMutableArray array];
    }
    return _chatModels;
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //[_tableView headerBeginRefreshing];
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.startIndex = 0;
    [AskPriceApi GetCommentListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.chatModels removeAllObjects];
            self.chatModels = posts;
            if(self.chatModels.count == 0){
                [MyTableView reloadDataWithTableView:self.tableView];
                [MyTableView hasData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
        [self.tableView headerEndRefreshing];
    } tradeId:self.askPriceModel.a_id tradeUserAndCommentUser:[NSString stringWithFormat:@"%@:%@",self.askPriceModel.a_createdBy,self.quotesModel.a_loginId] startIndex:0 noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

- (void)footerRereshing
{
    [AskPriceApi GetCommentListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex++;
            [self.chatModels addObjectsFromArray:posts];
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
        [self.tableView footerEndRefreshing];
    } tradeId:self.askPriceModel.a_id tradeUserAndCommentUser:[NSString stringWithFormat:@"%@:%@",self.askPriceModel.a_createdBy,self.quotesModel.a_loginId] startIndex:self.startIndex+1 noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}
@end
