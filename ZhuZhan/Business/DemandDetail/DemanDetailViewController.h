//
//  DemanDetailViewController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/18.
//
//

#import "ChatBaseViewController.h"
#import "RKDemandDetailController.h"
#import "RKDemandChatController.h"
#import "AskPriceModel.h"
#import "AskPriceApi.h"
#import "QuotesModel.h"
@interface DemanDetailViewController : ChatBaseViewController<RKDemandDetailControllerDelegate,UIActionSheetDelegate>{
@protected
    RKDemandDetailController* _detailController;
    RKDemandChatController* _chatController;
}
@property(nonatomic,strong)AskPriceModel *askPriceModel;
@property(nonatomic,strong)QuotesModel *quotesModel;

@property(nonatomic,strong)RKDemandDetailController* detailController;
@property(nonatomic,strong)RKDemandChatController* chatController;

@property(nonatomic)BOOL isFinish;

-(void)initNavi;
@end
