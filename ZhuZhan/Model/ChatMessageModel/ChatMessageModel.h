//
//  ChatMessageModel.h
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/10.
//
//

#import <Foundation/Foundation.h>
#import "ChatModel.h"

typedef enum {
    chatTypeOther = 0, // 别人发得
    chatTypeMe = 1 //自己发的
} ChatType;

@interface ChatMessageModel : NSObject
@property(nonatomic)ChatType a_type;
@property(nonatomic,strong)NSString *a_id;
@property(nonatomic,strong)NSString *a_localId;
@property(nonatomic,strong)NSString *a_name;
@property(nonatomic,strong)NSString *a_avatarUrl;
@property(nonatomic,strong)NSString *a_message;
@property(nonatomic,strong)NSString *a_time;
@property(nonatomic,strong)NSString *a_userId;
@property(nonatomic,strong)NSString *a_groupId;
@property(nonatomic,strong)NSString *a_groupName;
@property(nonatomic,strong)NSString *a_msgType;
@property(nonatomic,strong)UIImage  *a_localImage;
//@property(nonatomic,strong)NSString  *a_localBigImageUrl;
@property(nonatomic,strong)NSString *a_bigImageUrl;
@property(nonatomic,strong)NSString *a_fileId;
@property(nonatomic)BOOL a_isLocal;
@property(nonatomic)CGFloat a_imageWidth;
@property(nonatomic)CGFloat a_imageHeight;
@property (nonatomic)ChatMessageStatus messageStatus;
@property(nonatomic,strong)NSDictionary *dict;
+(CGSize)getImageWidth:(NSString *)width height:(NSString *)height;
@end
