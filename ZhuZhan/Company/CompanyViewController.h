//
//  CompanyViewController.h
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyModel.h"

@interface CompanyViewController : UIViewController
@property(nonatomic,strong)CompanyModel *model;
@property(nonatomic)BOOL needNoticeView;
@end