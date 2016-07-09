//
//  JKYYPaySuccessController.m
//  BoBoBuy
//
//  Created by JiKer on 16/1/18.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "JKYYPaySuccessController.h"
#import "OneLookLuckNumberView.h"
#import "AFAppDotNetAPIClient.h"
#import "JKProgressHuD.h"
#import "GlobalObject.h"
#import "AppDelegate.h"
#import "define.h"

@interface JKYYPaySuccessController ()<UITableViewDataSource,UITableViewDelegate,OneLookLuckNumberViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *YYData;
@property (nonatomic, strong) NSDictionary *YYDict;
@property (nonatomic, strong) OneLookLuckNumberView *luckNumberView;
@end

@implementation JKYYPaySuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [GlobalObject colorWithHexString:@"#F7F7F7"];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    [self setMyNavigationBar];
    [self getYYDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Private Methods
-(void)setMyNavigationBar{
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
    self.title = @"支付结果";
    
    UIButton *leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"nav_bar_left_new.png"] forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake( 0,0, 24, 20)];
    [leftBtn addTarget:self action:@selector(backToUp) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)getYYDetails{
    //PayOrderCode=120150925163025878751
    //PayOrderCode=120150925163415600468
    [[JKProgressHuD shareJKProgressHuD] showProgreessHuD:@"加载中" andView:self.view];
    NSDictionary *dict = @{@"type":@"yyg",@"PayOrderCode":self.PayOrderCode};
    NSString *url = [NSString stringWithFormat:@"%@%@",COMMON_HEAD,getorderinfo];
    [[AFAppDotNetAPIClient sharedClient] POST:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[JKProgressHuD shareJKProgressHuD] dismiss];
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        if (code == 200) {
            self.YYData = [NSArray arrayWithArray:[responseObject objectForKey:@"yygprolist"]];
            if ([[responseObject objectForKey:@"yygorder"] isKindOfClass:[NSArray class]]) {
                self.YYDict = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"yygorder"]];
            }
            
            [self addTableView];
        }
        else{
            [GlobalObject showProgresshudInView:self.view withText:@"数据加载失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[JKProgressHuD shareJKProgressHuD] dismiss];
        [GlobalObject showProgresshudInView:self.view withText:@"网络异常,请稍候再试"];
    }];
}

-(void)addTableView{
    
    CGFloat height = kScreenSize.height-64-55;
    CGFloat heightCount = 0;
    for (int i = 0 ; i < self.YYData.count ; i++) {
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.YYData[i]];
        NSString *str = [NSString stringWithFormat:@"(第%@期) %@",[dict objectForKey:@"Termid"],[dict objectForKey:@"ProductName"]];
        CGSize nameSize = [self sizeWithString:str font:[UIFont systemFontOfSize:12*kFloatSize]];
        int wid = nameSize.width;
        NSInteger payPrice = [[dict objectForKey:@"PayPrice"] integerValue];
        NSInteger realPrice = [[dict objectForKey:@"RealPrice"] integerValue];
        NSInteger failPrice = payPrice - realPrice;
        int nameWidth;
        int a ;
        if (realPrice > 0 && failPrice > 0) {
            nameWidth = 230*kFloatSize;
            a = (wid+nameWidth-1)/nameWidth+1;
        }
        else{
            nameWidth = 200*kFloatSize;
            a = (wid+nameWidth-1)/nameWidth;
        }
        
        heightCount = heightCount + 20*kFloatSize*a;
    }
    
    CGFloat trueHeight = MIN(height, heightCount);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, trueHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [GlobalObject colorWithHexString:@"#FFFFFF"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    CGFloat orderMoney = [[self.YYDict objectForKey:@"OrderMoney"] floatValue];
    CGFloat realMoney = [[self.YYDict objectForKey:@"RealMoney"] floatValue];
    CGFloat resultMoney = orderMoney - realMoney;
    if ( resultMoney > 0 ) {
        UILabel *promptlbl = [[UILabel alloc]init];
        promptlbl.frame = CGRectMake(0, 0, 320*kFloatSize, 40*kFloatSize);
        promptlbl.backgroundColor = [UIColor clearColor];
        promptlbl.font = [UIFont systemFontOfSize:14*kFloatSize];
        promptlbl.text = @"支付失败商品,购买现金已返还到您的余额";
        promptlbl.textAlignment = NSTextAlignmentCenter;
        promptlbl.textColor = [GlobalObject  colorWithHexString:@"#FF6168"];
        promptlbl.layer.borderColor = [[GlobalObject colorWithHexString:@"#EDEDED"]CGColor];
        promptlbl.layer.borderWidth = 1*kFloatSize;
        self.tableView.tableFooterView = promptlbl;
    }
    else{
        UILabel *promptlbl = [[UILabel alloc]init];
        promptlbl.backgroundColor = [GlobalObject colorWithHexString:@"#F7F7F7"];
        self.tableView.tableFooterView = promptlbl;
    }
    
    UIView *sepView = [[UIView alloc]initWithFrame:CGRectMake(0, trueHeight, kScreenSize.width, 1)];
    sepView.backgroundColor = [GlobalObject colorWithHexString:@"#E0E0E0"];
    [self.view addSubview:sepView];
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(15, trueHeight+10, kScreenSize.width-30, 34);
    bottomBtn.backgroundColor = [GlobalObject colorWithHexString:@"#F6467C"];
    bottomBtn.layer.masksToBounds = YES;
    bottomBtn.layer.cornerRadius = 17;
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [bottomBtn setTitle:@"立即进入创客中心" forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(enterChuangkePerson) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    
}

-(void)backToUp{
    NSArray *controllersArray = [NSArray arrayWithArray:self.navigationController.childViewControllers];
    if ([controllersArray[0] isKindOfClass:NSClassFromString(@"shopCarViewController")]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        for (UIViewController *VC in controllersArray) {
            if ([VC isKindOfClass:NSClassFromString(@"shopCarViewController")]) {
                NSInteger index = [controllersArray indexOfObject:VC];
                [self.navigationController popToViewController:controllersArray[index-1] animated:YES];
            }
        }
    }
}

-(void)enterChuangkePerson{
    [self dismissViewControllerAnimated:NO completion:nil];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.mainTab = nil;
    [appDelegate setupTabViewController];
    appDelegate.mainTab.selectedIndex = 3;
}

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 20*kFloatSize)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传入的字体字典
                                       context:nil];
    
    return rect.size;
}

#pragma mark -一元抢购夺宝号详情
-(void)detailsAction:(UIButton *)btn{
    UIView *superView = btn.superview;
    while (![superView isKindOfClass:[UITableViewCell class]]) {
        superView = superView.superview;
    }
    UITableViewCell *cell = (UITableViewCell *)superView;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.YYData[indexPath.row]];
    [self requestBuyinfoWithInfo:dict];
    
}
-(void)requestBuyinfoWithInfo:(NSDictionary *)dict{
    //yyid=5&weid=ndhu8bog
    NSString *weid = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Weid"]];
    NSString *yyid = [NSString stringWithFormat:@"%@",[dict objectForKey:@"YYGId"]];
    [[JKProgressHuD shareJKProgressHuD] showProgreessHuD:@"加载中" andView:self.view];
    NSString *url = [NSString stringWithFormat:@"%@%@",COMMON_HEAD,get_buyinfo];
    NSDictionary *dict1 = @{@"yyid":yyid,@"weid":weid};
    [[AFAppDotNetAPIClient sharedClient] POST:url parameters:dict1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[JKProgressHuD shareJKProgressHuD] dismiss];
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        if (code == 200) {
            NSArray *array = [NSArray arrayWithArray:[responseObject  objectForKey:@"buylist"]];
            [self showDetailWithArray:array withDict:dict];
        }
        else{
            [GlobalObject showProgresshudInView:self.view withText:@"获取数据失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[JKProgressHuD shareJKProgressHuD] dismiss];
        [GlobalObject showProgresshudInView:self.view withText:@"网络异常,请稍候再试"];
    }];
}

-(void)showDetailWithArray:(NSArray *)array withDict:(NSDictionary *)dict{
    _luckNumberView=[[OneLookLuckNumberView alloc]initWithFrame:[UIScreen mainScreen].bounds andInfo:array andinfoDic:dict];
    _luckNumberView.delegate=self;
    [self.navigationController.view addSubview:_luckNumberView];
}

#pragma mark -OneLookLuckNumberViewDelegate
-(void)quitLookview:(OneLookLuckNumberView *)lookview{
    if (_luckNumberView) {
        [_luckNumberView removeFromSuperview];
        _luckNumberView = nil;
    }
}

#pragma mark -UITableViewDelegate And UITableViewDatasource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.YYData[indexPath.row]];
    NSString *str = [NSString stringWithFormat:@"(第%@期) %@",[dict objectForKey:@"Termid"],[dict objectForKey:@"ProductName"]];
    CGSize nameSize = [self sizeWithString:str font:[UIFont systemFontOfSize:12*kFloatSize]];
    int wid = nameSize.width;
    NSInteger payPrice = [[dict objectForKey:@"PayPrice"] integerValue];
    NSInteger realPrice = [[dict objectForKey:@"RealPrice"] integerValue];
    NSInteger failPrice = payPrice - realPrice;
    int nameWidth;
    int a ;
    if (realPrice > 0 && failPrice > 0) {
        nameWidth = 230*kFloatSize;
        a = (wid+nameWidth-1)/nameWidth+1;
    }
    else{
        nameWidth = 200*kFloatSize;
        a = (wid+nameWidth-1)/nameWidth;
    }
    
    return 20*kFloatSize*a;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.YYData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *identifierImg = [[UIImageView alloc]init];
        identifierImg.frame = CGRectMake(6*kFloatSize, 3*kFloatSize, 14*kFloatSize, 14*kFloatSize);
        identifierImg.tag = 1001;
        [cell.contentView addSubview:identifierImg];
        
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.frame = CGRectMake(25*kFloatSize, 0, 200*kFloatSize, 20*kFloatSize);
        nameLabel.tag = 1002;
        nameLabel.numberOfLines = 0;
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont systemFontOfSize:12*kFloatSize];
        nameLabel.textColor = [GlobalObject colorWithHexString:@"#8B8B8B"];
        [cell.contentView addSubview:nameLabel];
        
        UILabel *rightLabel = [[UILabel alloc]init];
        rightLabel.frame = CGRectMake(275*kFloatSize, 0*kFloatSize, 40*kFloatSize, 20*kFloatSize);
        rightLabel.tag = 1003;
        rightLabel.backgroundColor = [UIColor clearColor];
        rightLabel.font = [UIFont systemFontOfSize:12*kFloatSize];
        rightLabel.textColor = [GlobalObject colorWithHexString:@"#8B8B8B"];
        rightLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:rightLabel];
        
        UIButton *promptBtn = [[UIButton alloc]init];
        promptBtn.frame = CGRectMake(225*kFloatSize, 0, 45*kFloatSize, 20*kFloatSize);
        promptBtn.tag = 1004;
        [promptBtn addTarget:self action:@selector(detailsAction:) forControlEvents:UIControlEventTouchUpInside];
        promptBtn.backgroundColor = [UIColor clearColor];
        promptBtn.titleLabel.font = [UIFont systemFontOfSize:9*kFloatSize];
        [cell.contentView addSubview:promptBtn];
    }
    
    UIImageView *identifierImg = [cell.contentView viewWithTag:1001];
    UILabel *nameLabel = [cell.contentView viewWithTag:1002];
    UILabel *rightLabel = [cell.contentView viewWithTag:1003];
    UIButton *promptBtn = [cell.contentView viewWithTag:1004];
    
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.YYData[indexPath.row]];
    NSString *imgStr;
    NSString *name = [NSString stringWithFormat:@"(第%@期) %@",[dict objectForKey:@"Termid"],[dict objectForKey:@"ProductName"]];
    CGSize nameSize = [self sizeWithString:name font:[UIFont systemFontOfSize:12*kFloatSize]];
    int wid = nameSize.width;
    
    NSInteger payPrice = [[dict objectForKey:@"PayPrice"] integerValue];
    NSInteger realPrice = [[dict objectForKey:@"RealPrice"] integerValue];
    NSString *prompt;
    int a;
    if (realPrice == 0) {
        a = (wid+(int)(200*kFloatSize)-1)/(int)(200*kFloatSize);
        nameLabel.frame = CGRectMake(25*kFloatSize, 0, 200*kFloatSize, a*20*kFloatSize);
        imgStr = @"pay_fail.png";
        prompt = @"支付失败";
        promptBtn.frame = CGRectMake(225*kFloatSize, 0, 45*kFloatSize, a*20*kFloatSize);
        [promptBtn setTitle:prompt forState:UIControlStateNormal];
        [promptBtn setTitleColor:[GlobalObject colorWithHexString:@"#FF6168"] forState:UIControlStateNormal];
    }
    else{
        NSInteger failPrice = payPrice - realPrice;
        if (failPrice > 0) {
            a = (wid+(int)(230*kFloatSize)-1)/(int)(230*kFloatSize);
            nameLabel.frame = CGRectMake(25*kFloatSize, 0, 230*kFloatSize, a*20*kFloatSize);
            imgStr = @"pay_half.png";
            
            prompt = [NSString stringWithFormat:@"提示:%ld人次购买成功(查看夺宝号)%ld人次购买失败",(long)realPrice,(long)failPrice];
            promptBtn.frame = CGRectMake(25*kFloatSize, a*20*kFloatSize, [self sizeWithString:prompt font:[UIFont systemFontOfSize:9*kFloatSize]].width, 20*kFloatSize);
            NSMutableAttributedString *promptAttStr = [[NSMutableAttributedString alloc]initWithString:prompt];
            [promptAttStr addAttribute:NSForegroundColorAttributeName value:[GlobalObject colorWithHexString:@"#FF6168"] range:NSMakeRange(0, 3)];
            NSRange range = [prompt rangeOfString:@")"];
            [promptAttStr addAttribute:NSForegroundColorAttributeName value:[GlobalObject colorWithHexString:@"#A0C6F9"] range:NSMakeRange(3, range.location-1)];
            [promptAttStr addAttribute:NSForegroundColorAttributeName value:[GlobalObject colorWithHexString:@"#FF6168"] range:NSMakeRange(range.location+1, prompt.length-range.location-1)];
            [promptBtn setAttributedTitle:promptAttStr forState:UIControlStateNormal];
        }
        else{
            a = (wid+(int)(200*kFloatSize)-1)/(int)(200*kFloatSize);
            nameLabel.frame = CGRectMake(25*kFloatSize, 0, 200*kFloatSize, a*20*kFloatSize);
            imgStr = @"pay_all.png";
            promptBtn.frame = CGRectMake(225*kFloatSize, 0, 45*kFloatSize, a*20*kFloatSize);
            prompt = [NSString stringWithFormat:@"查看夺宝号"];
            [promptBtn setTitle:prompt forState:UIControlStateNormal];
            [promptBtn setTitleColor:[GlobalObject colorWithHexString:@"#A0C6F9"] forState:UIControlStateNormal];
        }
    }
    
    identifierImg.image = [UIImage imageNamed:imgStr];
    
    nameLabel.text = name;
    
    NSString *rightStr = [NSString stringWithFormat:@"%ld人次",(long)payPrice];
    NSMutableAttributedString *rightAttStr = [[NSMutableAttributedString alloc]initWithString:rightStr];
    [rightAttStr addAttribute:NSForegroundColorAttributeName value:[GlobalObject colorWithHexString:@"#FF6168"] range:NSMakeRange(0, rightStr.length-2)];
    rightLabel.attributedText = rightAttStr;
    
    if (nameLabel.frame.size.height > 20*kFloatSize) {
        identifierImg.frame = CGRectMake(6*kFloatSize, 6*kFloatSize, 14*kFloatSize, 14*kFloatSize);
        rightLabel.frame = CGRectMake(275*kFloatSize, 0, 40*kFloatSize, a*20*kFloatSize);
    }
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
