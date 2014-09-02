//
//  TMQuiltView
//
//  Created by Bruno Virlet on 7/20/12.
//
//  Copyright (c) 2012 1000memories

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
//  and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR 
//  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
//  DEALINGS IN THE SOFTWARE.
//


#import "TMPhotoQuiltViewCell.h"

const CGFloat kTMPhotoQuiltViewMargin = 5;

@interface TMPhotoQuiltViewCell ()
@property(nonatomic,strong)UIImageView* commentIcon;
@property(nonatomic,strong)UIView* separatorLine;
@end

@implementation TMPhotoQuiltViewCell

@synthesize photoView = _photoView;
@synthesize titleLabel = _titleLabel;
@synthesize commentCountLabel = _commentCountLabel;

- (void)dealloc {
    [_photoView release], _photoView = nil;
    [_titleLabel release], _titleLabel = nil;
    
    [super dealloc];
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UIImageView *)photoView {
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        //_photoView.contentMode = UIViewContentModeScaleAspectFill;
        _photoView.contentMode=UIViewContentModeScaleAspectFill;
        _photoView.clipsToBounds = YES;
        [self addSubview:_photoView];
    }
    return _photoView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines=2;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)commentCountLabel {
    if (!_commentCountLabel) {
        _commentCountLabel = [[UILabel alloc] init];
        _commentCountLabel.textColor=RGBCOLOR(186, 186, 186);
        [self addSubview:_commentCountLabel];
    }
    return _commentCountLabel;
}

-(UIImageView *)commentIcon{
    if (!_commentIcon) {
        UIImage* image=[UIImage imageNamed:@"项目-首页_18a.png"];
        CGRect frame=CGRectMake(0, 0, image.size.width*.5, image.size.height*.5);
        _commentIcon=[[UIImageView alloc]initWithFrame:frame];
        _commentIcon.image=image;
        [self addSubview:_commentIcon];
    }
    return _commentIcon;
}

-(UIView *)separatorLine{
    if (!_separatorLine) {
        _separatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width-20, 1)];
        _separatorLine.backgroundColor=RGBCOLOR(206, 206, 206);
        [self addSubview:_separatorLine];
    }
    return _separatorLine;
}

- (void)layoutSubviews {
    //self.photoView.frame = CGRectInset(self.bounds, 0*kTMPhotoQuiltViewMargin, 0*kTMPhotoQuiltViewMargin);
    /*
    self.titleLabel.frame = CGRectMake(0*kTMPhotoQuiltViewMargin, self.bounds.size.height - 20 - 0*kTMPhotoQuiltViewMargin,
                                       self.bounds.size.width - 2 * 0*kTMPhotoQuiltViewMargin, 20);
     */
    self.photoView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-100);

    self.titleLabel.frame = CGRectMake(10, self.bounds.size.height - 100,
                                       self.bounds.size.width-20, 60);
    
    self.commentCountLabel.frame =  CGRectMake(40, self.bounds.size.height - 40 ,self.bounds.size.width, 40);
    
    self.commentIcon.center=CGPointMake(20, self.bounds.size.height-20);
    
    self.separatorLine.center=CGPointMake(self.bounds.size.width*.5, self.bounds.size.height-40);
    
//    cell.contentView.backgroundColor=[UIColor whiteColor];
//    cell.contentView.layer.cornerRadius=7;
    
    
    self.layer.shadowColor=[[UIColor grayColor]CGColor];
    self.layer.shadowOffset=CGSizeMake(0, .1);//使阴影均匀
    self.layer.shadowOpacity=.5;//阴影的alpha

}

@end