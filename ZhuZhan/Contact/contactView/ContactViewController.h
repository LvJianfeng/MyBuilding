//
//  ContactViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHPathCover.h"
#import "ACTimeScroller.h"
#import "ShowViewController.h"
#import "CommentView.h"
#import "HeadImageDelegate.h"
#import "AddCommentViewController.h"
#import "ErrorView.h"
#import "ContactTableViewCell.h"
#import "ProductDetailViewController.h"
#import "LoginViewController.h"
#import "CompanyModel.h"
#import "LoadingView.h"
#import "MyTableView.h"
#import "ContactProductView.h"

@protocol ContactViewDelegate <NSObject>
-(void)backGotoMarketView;
@end

@interface ContactViewController : UITableViewController<ACTimeScrollerDelegate,XHPathCoverDelegate,showControllerDelegate,HeadImageDelegate,AddCommentDelegate,ErrorViewDelegate,ProductDetailDelegate,LoginViewDelegate>{
    NSMutableArray *_datasource;
    ACTimeScroller *_timeScroller;
     NSMutableArray *chooseArray ;
    NSMutableArray *showArr;
    NSMutableArray *viewArr;
    CommentView *commentView;
    ContactProductView *productView;
    int startIndex;
    AddCommentViewController *addCommentView;
    NSIndexPath *indexpath;
    ShowViewController *showVC;
    LoadingView *loadingView;
    NSString* lasetCompanyID;
}
@property (nonatomic, strong) XHPathCover *pathCover;
@property (nonatomic,strong) UIView *transparent;
@property(nonatomic,weak)id<ContactViewDelegate>delegate;
- (void)_refreshing ;
@end