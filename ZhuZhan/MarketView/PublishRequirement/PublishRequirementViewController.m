//
//  PublishRequirementViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/4.
//
//

#import "PublishRequirementViewController.h"
#import "CategoryView.h"
#import "PublishRequirementContactsInfoView.h"
#import "PublishRequirementProjectView.h"
#import "PublishRequirementMaterialView.h"
#import "PublishRequirementRelationView.h"
#import "PublishRequirementCooperationView.h"
#import "PublishRequirementOtherView.h"
#import "RKShadowView.h"
#import "LoginSqlite.h"
#import "MarketApi.h"
#import "TwoStageLocateView.h"
#import "ChooseProductBigStage.h"
#import "ChooseProductCellModel.h"
#import "ChooseProductSmallStage.h"
@interface PublishRequirementViewController ()<CategoryViewDelegate,PublishRequirementProjectViewDelegate,PublishRequirementMaterialViewDelegate,PublishRequirementRelationViewDelegate,PublishRequirementCooperationViewDelegate,UIActionSheetDelegate,ChooseProductBigStageDelegate,ChooseProductSmallStageDelegate,UIAlertViewDelegate>
@property (nonatomic, strong)CategoryView* requirementCategoryView;
@property (nonatomic, strong)PublishRequirementContactsInfoView* contactsInfoView;
@property (nonatomic, strong)UIView* requirementInfoView;

@property (nonatomic, strong)NSArray* viewArr;
@property (nonatomic)NSInteger nowIndex;

@property (nonatomic, strong)PublishRequirementProjectView* projectView;
@property (nonatomic, strong)PublishRequirementMaterialView* materialView;
@property (nonatomic, strong)PublishRequirementRelationView* relationView;
@property (nonatomic, strong)PublishRequirementCooperationView* cooperationView;
@property (nonatomic, strong)PublishRequirementOtherView* otherView;

@property (nonatomic, strong)TwoStageLocateView *locateView;
@property (nonatomic, strong)NSString* bigCategoryId;
@property (nonatomic, strong)NSString* smallCategoryId;
@end

@implementation PublishRequirementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initTableView];
    self.tableView.backgroundColor = AllBackDeepGrayColor;
    [self.requirementCategoryView singleCategoryViewClickedWithIndex:0];
    [self addKeybordNotification];
}

- (void)rightBtnClicked{
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    [dic setObject:self.contactsInfoView.realName forKey:@"realName"];
    [dic setObject:self.contactsInfoView.phoneNumber forKey:@"tel"];
    [dic setObject:self.contactsInfoView.allUserSee?@"00":@"01" forKey:@"isOpen"];
    [dic setObject:@[@"01",@"02",@"03",@"04",@"05"][self.nowIndex] forKey:@"requireType"];
    
    if ([dic[@"tel"] isEqualToString:@""]) {
        [self showAlertWithContent:@"请输入联系电话"];
        return;
    }
    
    switch (self.nowIndex) {
        case 0:{
            NSArray* array = [self.projectView.area componentsSeparatedByString:@" "];
            [dic setObject:array[0] forKey:@"province"];
            [dic setObject:array[1] forKey:@"city"];
#warning 之后好了需要来这里比较下最小金额和最大金额的大小关系
            [dic setObject:self.projectView.maxMoney forKey:@"moneyMax"];
            [dic setObject:self.projectView.minMoney forKey:@"moneyMin"];
            [dic setObject:self.projectView.requirementDescribe forKey:@"desc"];
            if ([dic[@"province"] isEqualToString:@""] || [dic[@"city"] isEqualToString:@""]) {
                [self showAlertWithContent:@"请选择需求信息中的需求所在地"];
                return;
            }
        }
            break;
        case 1:{
            [dic setObject:self.bigCategoryId forKey:@"bigType"];
            [dic setObject:self.smallCategoryId forKey:@"smallType"];
            [dic setObject:self.materialView.requirementDescribe forKey:@"desc"];
            if ([dic[@"bigType"] isEqualToString:@""]) {
                [self showAlertWithContent:@"请选择需求信息中的大类"];
                return;
            }
            if ([dic[@"smallType"] isEqualToString:@""]) {
                [self showAlertWithContent:@"请选择需求信息中的分类"];
                return;
            }
        }
            break;
        case 2:{
            NSArray* array = [self.relationView.area componentsSeparatedByString:@" "];
            [dic setObject:array[0] forKey:@"province"];
            [dic setObject:array[1] forKey:@"city"];
            [dic setObject:self.relationView.requirementDescribe forKey:@"desc"];
            if ([dic[@"province"] isEqualToString:@""] || [dic[@"city"] isEqualToString:@""]) {
                [self showAlertWithContent:@"请选择需求信息中的需求所在地"];
                return;
            }
        }
            break;
        case 3:{
            NSArray* array = [self.cooperationView.area componentsSeparatedByString:@" "];
            [dic setObject:array[0] forKey:@"province"];
            [dic setObject:array[1] forKey:@"city"];
            [dic setObject:self.cooperationView.requirementDescribe forKey:@"desc"];
            if ([dic[@"province"] isEqualToString:@""] || [dic[@"city"] isEqualToString:@""]) {
                [self showAlertWithContent:@"请选择需求信息中的需求所在地"];
                return;
            }
        }
            break;
        case 4:{
            [dic setObject:self.otherView.requirementDescribe forKey:@"desc"];
            if ([dic[@"desc"] isEqualToString:@""]) {
                [self showAlertWithContent:@"请输入需求信息中的需求描述信息"];
                return;
            }
        }
            break;
    }

    [MarketApi AddRequireWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [[[UIAlertView alloc] initWithTitle:@"提醒" message:@"发布成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
        }
    } dic:dic noNetWork:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self leftBtnClicked];
}

- (void)showAlertWithContent:(NSString*)content{
    [[[UIAlertView alloc] initWithTitle:@"提醒" message:content delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
}

- (void)initNavi{
    self.title = @"发布需求";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithText:@"发布"];
}

- (void)categoryViewClickedWithCategory:(NSString *)category index:(NSInteger)index{
    self.nowIndex = index;
    self.contactsInfoView = nil;
    self.viewArr = nil;
    [self.tableView reloadData];
}

- (void)projectViewAreaBtnClicked{
    NSLog(@"projectViewAreaBtnClicked");
    self.locateView = [[TwoStageLocateView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:nil delegate:self];
    self.locateView.tag = 0;
    [self.locateView showInView:self.view];
}

- (void)materialViewBigCategoryBtnClicked{
    NSLog(@"materialViewBigCategoryBtnClicked");
    ChooseProductBigStage *categoryView = [[ChooseProductBigStage alloc] init];
    categoryView.delegate = self;
    [self.navigationController pushViewController:categoryView animated:YES];
}

- (void)materialViewSmallCategoryBtnClicked{
    NSLog(@"materialViewSmallCategoryBtnClicked");
    ChooseProductSmallStage *classificationView = [[ChooseProductSmallStage alloc] init];
    classificationView.delegate = self;
    classificationView.categoryId = self.bigCategoryId;
    [self.navigationController pushViewController:classificationView animated:YES];
}

- (void)relationViewAreaBtnClicked{
    NSLog(@"relationViewAreaBtnClicked");
    self.locateView = [[TwoStageLocateView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:nil delegate:self];
    self.locateView.tag = 2;
    [self.locateView showInView:self.view];
}

- (void)cooperationViewAreaBtnClicked{
    NSLog(@"cooperationViewAreaBtnClicked");
    self.locateView = [[TwoStageLocateView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:nil delegate:self];
    self.locateView.tag = 3;
    [self.locateView showInView:self.view];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView* view = self.viewArr[indexPath.row];
    return CGRectGetHeight(view.frame);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView* view = self.viewArr[indexPath.row];
    [cell addSubview:view];
    return cell;
}

- (UIView *)requirementCategoryView{
    if (!_requirementCategoryView) {
        _requirementCategoryView = [CategoryView categoryViewWithCategoryArr:@[@"找项目",@"找材料",@"找关系",@"找合作",@"其他"]];
        _requirementCategoryView.bottomView = [RKShadowView seperatorLineWithHeight:10 top:0];
        _requirementCategoryView.delegate = self;
    }
    return _requirementCategoryView;
}

- (PublishRequirementContactsInfoView *)contactsInfoView{
    if (!_contactsInfoView) {
        _contactsInfoView = [PublishRequirementContactsInfoView infoView];
        
        _contactsInfoView.publishUserName = [LoginSqlite getdata:@"userName"];
        
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        view.backgroundColor = AllBackDeepGrayColor;
        CGRect frame = view.frame;
        frame.origin.y = CGRectGetHeight(_contactsInfoView.frame);
        view.frame = frame;
        
        [_contactsInfoView addSubview:view];
        frame = _contactsInfoView.frame;
        frame.size.height += CGRectGetHeight(view.frame);
        _contactsInfoView.frame = frame;
    }
    return _contactsInfoView;
}

- (NSArray *)viewArr{
    if (!_viewArr) {
        NSArray* views = @[self.projectView,self.materialView,self.relationView,self.cooperationView,self
                           .otherView];
        _viewArr = @[self.requirementCategoryView,self.contactsInfoView,views[self.nowIndex]];
    }
    return _viewArr;
}

- (PublishRequirementProjectView *)projectView{
    if (!_projectView) {
        _projectView = [PublishRequirementProjectView projectView];
        _projectView.delegate = self;
    }
    return _projectView;
}

- (PublishRequirementMaterialView *)materialView{
    if (!_materialView) {
        _materialView = [PublishRequirementMaterialView materialView];
        _materialView.delegate = self;
    }
    return _materialView;
}

- (PublishRequirementRelationView *)relationView{
    if (!_relationView) {
        _relationView = [PublishRequirementRelationView relationView];
        _relationView.delegate = self;
    }
    return _relationView;
}

- (PublishRequirementCooperationView *)cooperationView{
    if (!_cooperationView) {
        _cooperationView = [PublishRequirementCooperationView cooperationView];
        _cooperationView.delegate = self;
    }
    return _cooperationView;
}

- (PublishRequirementOtherView *)otherView{
    if (!_otherView) {
        _otherView = [PublishRequirementOtherView otherView];
    }
    return _otherView;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet.tag == 0){
        
        self.locateView = (TwoStageLocateView *)actionSheet;
        if(buttonIndex == 0) {
            NSLog(@"Cancel");
        }else {
            self.projectView.area = [NSString stringWithFormat:@"%@ %@",self.locateView.proviceDictionary[@"provice"],self.locateView.proviceDictionary[@"city"]];
        }
        
    }else if(actionSheet.tag == 2){
        
        self.locateView = (TwoStageLocateView *)actionSheet;
        if(buttonIndex == 0) {
            NSLog(@"Cancel");
        }else {
            self.relationView.area = [NSString stringWithFormat:@"%@ %@",self.locateView.proviceDictionary[@"provice"],self.locateView.proviceDictionary[@"city"]];
        }
        
    }else if(actionSheet.tag == 3){
        
        self.locateView = (TwoStageLocateView *)actionSheet;
        if(buttonIndex == 0) {
            NSLog(@"Cancel");
        }else {
            self.cooperationView.area = [NSString stringWithFormat:@"%@ %@",self.locateView.proviceDictionary[@"provice"],self.locateView.proviceDictionary[@"city"]];
        }
        
    }
}

-(void)chooseProductBigStage:(NSString *)str catroyId:(NSString *)catroyId allClassificationArr:(NSMutableArray *)allClassification{
    self.materialView.bigCategory = str;
    self.bigCategoryId = catroyId;
}

-(void)chooseProductSmallStage:(NSArray *)arr{
    NSMutableString *str = [[NSMutableString alloc] init];
    NSMutableString *idStr = [[NSMutableString alloc] init];
    [arr enumerateObjectsUsingBlock:^(ChooseProductCellModel *cellModel, NSUInteger idx, BOOL *stop) {
        [str appendString:[NSString stringWithFormat:idx==arr.count-1?@"%@":@"%@、",cellModel.content]];
        [idStr appendString:[NSString stringWithFormat:idx==arr.count-1?@"%@":@"%@,",cellModel.aid]];
    }];
    self.materialView.smallCategory = str;
    self.smallCategoryId = idStr;
}
@end
