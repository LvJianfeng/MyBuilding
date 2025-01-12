//
//  RecommendProjectViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14/12/18.
//
//

#import "RecommendProjectViewController.h"
#import "RecommendContactViewController.h"
#import "ProjectApi.h"
#import "projectModel.h"
#import "MJRefresh.h"
#import "IsFocusedApi.h"

@interface RecommendProjectViewController ()<UITableViewDelegate,UITableViewDataSource,ProjectTableViewCellDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *showArr;
@end

@implementation RecommendProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.showArr = [[NSMutableArray alloc] init];
    //返还按钮
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,25,22)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.title = @"推荐项目";
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 50, 30)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton setTitle:@"继续" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    [self addTopView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+77, 320, kScreenHeight-64-77)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = AllBackLightGratColor;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    startIndex = 0;
    [self loadList];
    //集成刷新控件
    //[self setupRefresh];
}

-(void)addTopView{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 77)];
    topView.backgroundColor = RGBCOLOR(235, 235, 235);
    [self.view addSubview:topView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(59, 18, 61, 50)];
    imageView.image = [GetImagePath getImagePath:@"推荐页面03a"];
    [topView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(130, 20, 130, 23)];
    label.text = @"关注你感兴趣的项目，";
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    label.textColor = RGBCOLOR(163, 163, 163);
    [topView addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(130, 40, 130, 23)];
    label2.text = @"来随时了解项目进程！";
    label2.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    label2.textColor = RGBCOLOR(163, 163, 163);
    [topView addSubview:label2];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 73, 320, 5)];
    lineImage.image = [GetImagePath getImagePath:@"推荐页面06a"];
    [topView addSubview:lineImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)rightBtnClick{
    RecommendContactViewController *recContactView = [[RecommendContactViewController alloc] init];
    [self.navigationController pushViewController:recContactView animated:YES];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //[_tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize defaultSize = DEFAULT_CELL_SIZE;
    CGSize cellSize = [ProjectTableViewCell sizeForCellWithDefaultSize:defaultSize setupCellBlock:^id(id<CellHeightDelegate> cellToSetup) {
        projectModel *model = self.showArr[indexPath.row];
        [((ProjectTableViewCell *)cellToSetup) setModel:model];
        return cellToSetup;
    }];
    return cellSize.height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"ProjectTableViewCell"];
    ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    projectModel *model = self.showArr[indexPath.row];
    
    if(!cell){
        cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.model = model;
    cell.delegate = self;
    cell.selectionStyle = NO;
    cell.indexPath = indexPath;
    cell.isHiddenFocusBtn = NO;
    cell.isHiddenApproveImageView = YES;
    return cell;
}

-(void)loadList{
    startIndex = 0;
    [ProjectApi GetRecommenddProjectsWithBlock:^(NSMutableArray *posts,int count ,NSError *error) {
        if(!error){
            self.showArr = posts;
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
        [self.tableView headerEndRefreshing];
    } startIndex:0 noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    startIndex = 0;
    [self.showArr removeAllObjects];
    [self loadList];
}

- (void)footerRereshing
{
    [ProjectApi GetRecommenddProjectsWithBlock:^(NSMutableArray *posts,int count ,NSError *error) {
        if(!error){
            startIndex++;
            [self.showArr addObjectsFromArray:posts];
            [self.tableView reloadData];
        }
        [self.tableView footerEndRefreshing];
    }startIndex:startIndex+1 noNetWork:nil];
}

-(void)addFocused:(NSIndexPath *)indexPath{
    projectModel *model = self.showArr[indexPath.row];
    if([model.isFocused isEqualToString:@"0"]){
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:model.a_id forKey:@"targetId"];
        [dic setObject:@"03" forKey:@"targetCategory"];
        [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                model.isFocused = @"1";
                [self.showArr replaceObjectAtIndex:indexPath.row withObject:model];
                [self.tableView reloadData];
            }else{
                if([ErrorCode errorCode:error] == 403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorCode alert];
                }
            }
        } dic:dic noNetWork:nil];
    }else{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:model.a_id forKey:@"targetId"];
        [dic setObject:@"03" forKey:@"targetCategory"];
        [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"取消关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                model.isFocused = @"0";
                [self.showArr replaceObjectAtIndex:indexPath.row withObject:model];
                [self.tableView reloadData];
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
}
@end
