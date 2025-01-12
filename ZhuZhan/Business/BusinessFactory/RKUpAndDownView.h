//
//  RKUpAndDownView.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/20.
//
//

#import <UIKit/UIKit.h>

@interface RKUpAndDownView : UIView
+(RKUpAndDownView*)upAndDownViewWithUpContent:(NSString*)upContent downContent:(NSString*)downContent topDistance:(CGFloat)topDistance bottomDistance:(CGFloat)bottomDistance maxWidth:(CGFloat)maxWidth;
+(RKUpAndDownView*)upAndDownTextViewWithUpContent:(NSString*)upContent topDistance:(CGFloat)topDistance bottomDistance:(CGFloat)bottomDistance maxWidth:(CGFloat)maxWidth ;
-(NSString*)textViewText;
@end
