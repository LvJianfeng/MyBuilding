//
//  AccountCell.m
//  ZhuZhan
//
//  Created by Jack on 14-9-4.
//
//

#import "AccountCell.h"

@implementation AccountCell

@synthesize userName,password,realName,sex,location,birthday,constellation,bloodType,email,cellPhone,company,position,delegate;

static int textFieldTag =0;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithModel:(ContactModel *)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //*********账户信息**********************************************************************************
        UIView *back1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        back1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grayColor"]];
        [self addSubview:back1];
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(134, 13, 52, 34)];
        imageView1.image = [UIImage imageNamed:@"人脉－账号设置_10a"];
        [self addSubview:imageView1];
        
        //用户名
        UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 80, 30)];
        userNameLabel.text = @"用  户  名";
        userNameLabel.textAlignment = NSTextAlignmentLeft;
        userNameLabel.font=[UIFont systemFontOfSize:15];
        [self addSubview:userNameLabel];
        userName = [[UITextField alloc] initWithFrame:CGRectMake(110, 70, 150, 30)];
        userName.textAlignment = NSTextAlignmentLeft;
        userName.text =model.userName;
        userName.delegate =self;
        userName.font=[UIFont systemFontOfSize:15];
        userName.textColor=GrayColor;
        userName.tag = 2014091201;
        [self addSubview:userName];
        UIImageView *horizontalLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 109, 280, 1)];
        horizontalLine1.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine1.alpha = 0.5;
        [self addSubview:horizontalLine1];
        
        //密码
        UILabel *passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 80, 30)];
        passwordLabel.text = @"密        码";
        passwordLabel.font=[UIFont systemFontOfSize:15];
        passwordLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:passwordLabel];
        password = [[UITextField alloc] initWithFrame:CGRectMake(110, 120, 150, 30)];
        password.textAlignment = NSTextAlignmentLeft;
        password.font=[UIFont systemFontOfSize:15];
        password.delegate =self;
        password.secureTextEntry =YES;
        password.text = model.password;
        password.tag = 2014091202;
        [self addSubview:password];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(250, 120, 50, 30);
        [button setTitle:@"修改" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(begintoModifyPassword) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        UIImageView *horizontalLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 159, 280, 1)];
        horizontalLine2.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine2.alpha = 0.5;
        [self addSubview:horizontalLine2];
        
          //真实姓名
        UILabel *realNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 80, 30)];
        realNameLabel.text = @"真实姓名";
        realNameLabel.font=[UIFont systemFontOfSize:15];

        realNameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:realNameLabel];
        realName = [[UITextField alloc] initWithFrame:CGRectMake(110, 170, 150, 30)];
        realName.textAlignment = NSTextAlignmentLeft;
        realName.delegate =self;
        realName.text = model.realName;
        realName.font=[UIFont systemFontOfSize:15];
        realName.textColor=GrayColor;
        realName.tag = 2014091203;
        [self addSubview:realName];
        UIImageView *horizontalLine3 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 209, 280, 1)];
        horizontalLine3.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine3.alpha = 0.5;
        [self addSubview:horizontalLine3];
        
        //性别
        UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 80, 30)];
        sexLabel.text = @"性        别";
        sexLabel.font=[UIFont systemFontOfSize:15];

        sexLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:sexLabel];
        sex = [[UITextField alloc] initWithFrame:CGRectMake(110, 220, 150, 30)];
        sex.textAlignment = NSTextAlignmentLeft;
        sex.delegate =self;
        sex.text = model.sex;
        sex.font=[UIFont systemFontOfSize:15];
        sex.textColor=GrayColor;
        sex.tag = 2014091204;
        [self addSubview:sex];
        UIImageView *horizontalLine4 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 259, 280, 1)];
        horizontalLine4.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine4.alpha = 0.5;
        [self addSubview:horizontalLine4];
        
        //所在地
        UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 270, 80, 30)];
        locationLabel.text = @"所   在  地";
        locationLabel.font=[UIFont systemFontOfSize:15];
        locationLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:locationLabel];
        location = [[UITextField alloc] initWithFrame:CGRectMake(110, 270, 150, 30)];
        location.textAlignment = NSTextAlignmentLeft;
        location.delegate =self;
        location.placeholder = @"所在的城市";
        location.text = model.locationCity;
        location.font=[UIFont systemFontOfSize:15];
        location.textColor=GrayColor;
        location.tag = 2014091205;
        [self addSubview:location];
        UIImageView *horizontalLine5 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 309, 280, 1)];
        horizontalLine5.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine5.alpha = 0.5;
        [self addSubview:horizontalLine5];
        
        //生日
        UILabel *birthdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 320, 80, 30)];
        birthdayLabel.text = @"生        日";
        birthdayLabel.font=[UIFont systemFontOfSize:15];
        birthdayLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:birthdayLabel];
        birthday= [[UILabel alloc] initWithFrame:CGRectMake(110, 320, 150, 30)];
        birthday.textAlignment = NSTextAlignmentLeft;
//        birthday.delegate =self;

//        birthday.placeholder = @"yyyy-mm-dd";
        birthday.text = [model.birthday substringWithRange:NSMakeRange(0,10)];
        birthday.font=[UIFont systemFontOfSize:15];
        birthday.textColor=GrayColor;
        birthday.tag = 2014091206;
        [self addSubview:birthday];
        
        UIButton *birthdayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        birthdayBtn.frame = CGRectMake(110, 320, 150, 30);
        [birthdayBtn addTarget:self action:@selector(brithdayBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:birthdayBtn];
        
        UIImageView *horizontalLine6 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 359, 280, 1)];
        horizontalLine6.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine6.alpha = 0.5;
        [self addSubview:horizontalLine6];
        
        //星座
        UILabel *constellationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 370, 80, 30)];
        constellationLabel.text = @"星       座";
        constellationLabel.font=[UIFont systemFontOfSize:15];
        constellationLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:constellationLabel];
        constellation= [[UILabel alloc] initWithFrame:CGRectMake(110, 370, 150, 30)];
        constellation.textAlignment = NSTextAlignmentLeft;
        constellation.text = model.constellation;
        constellation.font=[UIFont systemFontOfSize:15];
        constellation.textColor=GrayColor;
//        constellation.delegate =self;
        constellation.tag = 2014091207;
        [self addSubview:constellation];
        UIImageView *horizontalLine7 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 409, 280, 1)];
        horizontalLine7.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine7.alpha = 0.5;
        [self addSubview:horizontalLine7];
        
        //血型
        UILabel *bloodTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 420, 80, 30)];
        bloodTypeLabel.text = @"血       型";
        bloodTypeLabel.font=[UIFont systemFontOfSize:15];
        bloodTypeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:bloodTypeLabel];
        bloodType= [[UITextField alloc] initWithFrame:CGRectMake(110, 420, 150, 30)];
        bloodType.textAlignment = NSTextAlignmentLeft;
        bloodType.delegate =self;
        bloodType.text = model.bloodType;
        bloodType.font=[UIFont systemFontOfSize:15];
        bloodType.textColor=GrayColor;
        bloodType.tag = 2014091208;
        [self addSubview:bloodType];

        

        
        //*******联系方式**********************************************************************************
        
        UIView *back12 = [[UIView alloc] initWithFrame:CGRectMake(0, 460, 320, 60)];
        back12.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grayColor"]];
        [self addSubview:back12];
        UIImageView *imageView12 = [[UIImageView alloc] initWithFrame:CGRectMake(134, 473, 52, 34)];
        imageView12.image = [UIImage imageNamed:@"人脉－账号设置_14a"];
        [self addSubview:imageView12];
        
        //email
        UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 530, 80, 30)];
        emailLabel.text = @"邮箱地址";
        emailLabel.font=[UIFont systemFontOfSize:15];
        emailLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:emailLabel];
        email = [[UITextField alloc] initWithFrame:CGRectMake(110, 530, 150, 30)];
        email.textAlignment = NSTextAlignmentLeft;
        email.delegate =self;
        email.text = model.email;
        email.font=[UIFont systemFontOfSize:15];
        email.textColor=GrayColor;
        email.tag = 2014091209;
        [self addSubview:email];
        UIImageView *horizontalLine9 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 569, 280, 1)];
        horizontalLine9.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine9.alpha = 0.5;
        [self addSubview:horizontalLine9];
        
        //cellPhone
        UILabel *cellPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 580, 80, 30)];
        cellPhoneLabel.text = @"电       话";
        cellPhoneLabel.font=[UIFont systemFontOfSize:15];
        cellPhoneLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:cellPhoneLabel];
        cellPhone = [[UILabel alloc] initWithFrame:CGRectMake(110, 580, 150, 30)];
        cellPhone.textAlignment = NSTextAlignmentLeft;
        cellPhone.text = model.cellPhone;
        cellPhone.font=[UIFont systemFontOfSize:15];
        cellPhone.textColor=GrayColor;

        [self addSubview:cellPhone];

        

        
        //*********公司信息*********************************************************************************
        
        UIView *back13 = [[UIView alloc] initWithFrame:CGRectMake(0, 620, 320, 60)];
        back13.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grayColor"]];
        [self addSubview:back13];
        UIImageView *imageView13 = [[UIImageView alloc] initWithFrame:CGRectMake(134, 633, 52, 34)];
        imageView13.image = [UIImage imageNamed:@"人脉－账号设置_18a"];
        [self addSubview:imageView13];
        
        //在职公司
        UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 690, 80, 30)];
        companyLabel.text = @"在职公司";
        companyLabel.font=[UIFont systemFontOfSize:15];
        companyLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:companyLabel];
        company = [[UITextField alloc] initWithFrame:CGRectMake(110, 690, 200, 30)];
        company.textAlignment = NSTextAlignmentLeft;
        company.delegate =self;
        company.text = model.companyName;
        company.font=[UIFont systemFontOfSize:15];
        company.textColor=GrayColor;
        company.tag = 2014091210;
        [self addSubview:company];
        UIImageView *horizontalLine10 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 729, 280, 1)];
        horizontalLine10.image = [UIImage imageNamed:@"人脉－引荐信_08a"];
        horizontalLine10.alpha = 0.5;
        [self addSubview:horizontalLine10];
        
        //职位
        UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 740, 80, 30)];
        positionLabel.text = @"职        位";
        positionLabel.font=[UIFont systemFontOfSize:15];
        positionLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:positionLabel];
        position = [[UITextField alloc] initWithFrame:CGRectMake(110, 740, 150, 30)];
        position.textAlignment = NSTextAlignmentLeft;
        position.delegate =self;
        position.text = model.position;
        position.font=[UIFont systemFontOfSize:15];
        position.textColor=GrayColor;
        position.tag = 2014091211;
        [self addSubview:position];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

-(void)begintoModifyPassword
{
    [delegate ModifyPassword:password.text];
}

#pragma mark textFieldDelelgate----------
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    int flag =0;
    if ([textField isEqual:userName]) {
        flag =0;
    }
    if ([textField isEqual:realName]) {
        flag =1;
    }
    if ([textField isEqual:sex]) {
        flag =2;
    }
    if ([textField isEqual:location]) {
        flag =3;
    }
    if ([textField isEqual:birthday]) {
        flag =4;
    }
    if ([textField isEqual:constellation]) {
        flag =5;
    }
    if ([textField isEqual:bloodType]) {
        flag =6;
    }
    if ([textField isEqual:email]) {
        flag =7;
    }
    if ([textField isEqual:company]) {
        flag =8;
    }
    if ([textField isEqual:position]) {
        flag =9;
    }
    [delegate AddDataToModel:flag WithTextField:textField];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    float y = textField.frame.size.height+textField.frame.origin.y;
    [delegate getTextFieldFrame_yPlusHeight:y];
    textFieldTag =textField.tag;
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITextField *textField = (UITextField *)[self viewWithTag:textFieldTag];
    [textField resignFirstResponder];
}


-(void)brithdayBtnClicked
{
    UILabel*label =(UILabel *)[self viewWithTag:2014091206];
    [delegate AddBirthdayPicker:label];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
