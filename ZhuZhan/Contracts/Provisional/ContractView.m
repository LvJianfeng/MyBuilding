//
//  ContractView.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import "ContractView.h"
#import "EndEditingGesture.h"
@implementation ContractView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.cutLine];
        [self addSubview:self.titleLabel];
        [self addSubview:self.imageView];
        [self addSubview:self.textView];
        [EndEditingGesture addGestureToView:self];
    }
    return self;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 16, 180, 16)];
        _titleLabel.textColor = BlueColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"请填写合同主要条款";
    }
    return _titleLabel;
}

-(UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 18, 6, 6)];
        _imageView.image = [GetImagePath getImagePath:@"star"];
    }
    return _imageView;
}

-(UIImageView *)cutLine{
    if(!_cutLine){
        _cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        _cutLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _cutLine;
}

-(MessageTextView *)textView{
    if(!_textView){
        _textView = [[MessageTextView alloc] initWithFrame:CGRectMake(26, 42, 280, 200)];
        _textView.placeHolder = @"请输入条款内容";
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor clearColor];
    }
    return _textView;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if([self.delegate respondsToSelector:@selector(beginTextView)]){
        [self.delegate beginTextView];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if([self.delegate respondsToSelector:@selector(endTextView:)]){
        [self.delegate endTextView:textView.text];
    }
}
@end
