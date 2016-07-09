//
//  ShoppingCartViewController.m
//  NewOnePay
//
//  Created by apple on 16/6/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import <SVProgressHUD.h>
#import "JKProgressHuD.h"
#import "AFAppDotNetAPIClient.h"
#import "define.h"
#import <MJExtension/MJExtension.h>
#import "GlobalObject.h"
#import "shopCarCell.h"

#define BBGSIGNKEY @"native159netnative159netnative159net"
@implementation ShoppingCartViewController
//加载导航栏
-(void)loadNavigationBar{
//    UIButton* btn_back= [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_back setBackgroundImage:[UIImage imageNamed:@"nav_bar_left_new.png"] forState:UIControlStateNormal];
//    [btn_back setFrame:CGRectMake( 0, 0, 12*kFloatSize, 17*kFloatSize)];
//    [btn_back addTarget:self action:@selector(backToUp) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem * listItem = [[UIBarButtonItem alloc] initWithCustomView:btn_back];
//    self.navigationItem.leftBarButtonItem = listItem;
    
    
    btn_edit= [UIButton buttonWithType:UIButtonTypeCustom];
    //    [btn_edit setBackgroundImage:[UIImage imageNamed:@"edit_icon.png"] forState:UIControlStateNormal];
    //    [btn_edit setBackgroundImage:[UIImage imageNamed:@"finish_icon.png"] forState:UIControlStateSelected];
    [btn_edit setTitle:@"删除" forState:UIControlStateNormal];
    [btn_edit setFrame:CGRectMake( 0, 0, 63*kFloatSize, 30*kFloatSize)];
    btn_edit.titleLabel.font=[UIFont systemFontOfSize:15*kFloatSize];
    [btn_edit addTarget:self action:@selector(Click_edit:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * editItem = [[UIBarButtonItem alloc] initWithCustomView:btn_edit];
    self.navigationItem.rightBarButtonItem = editItem;
    

    
    self.navigationItem.title = @"购物车";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    self.navigationController.navigationBar.barTintColor=[GlobalObject colorWithHexString:@"#ED4D80"];
}
-(void)backToUp
{
    if ([self.navigationController.childViewControllers objectAtIndex:0]==self) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self documentFolderPathdb];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    
    
    dataArray=[[NSMutableArray alloc]init];
    [self loadNavigationBar];
    [self loadMainView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self keyBoardDismiss];
    if (dataArray) {
        [dataArray removeAllObjects];
    }
    
    NSString *str_weid=[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:@"weid"]];
    
    
    if ([str_weid isEqualToString:@"0"]||str_weid==nil||[str_weid isEqualToString:@"(null)"]||str_weid.length==0) {
        [self documentFolderPathdb];
    }else{
        [self getShopCarData];
    }
    
    
}

-(void)Click_edit_network{
    //hq7nuv7i
    [[JKProgressHuD shareJKProgressHuD] showProgreessHuD:@"加载中" andView:self.view];
    
    NSString* strId=@"";
    
    [db_shop_car open];
    NSMutableArray* nextArray=[[NSMutableArray alloc]init];
    for (OneYiyuanModel* model in dataArray) {
        if (model.isSelect) {
            
                       
            if (strId.length) {
                strId=[NSString stringWithFormat:@"%@,%@",strId,model.id];
                
            }else
            {
                strId=[NSString stringWithFormat:@"%@",model.id];
               
            }
            [nextArray addObject:model];
            [db_shop_car executeUpdate:@"DELETE  FROM shopcar WHERE goodId = ?",model.id];
        }
    }
    [db_shop_car close];
    
    [dataArray removeObjectsInArray:nextArray];
  
    
    float allPrice=0.0;
    int goodCount=0;
    for (OneYiyuanModel* model in dataArray) {
        
        if (model.isSelect) {
            goodCount++;
            allPrice+=[model.goodCount integerValue];
        }
        
    }

    
    
   
    NSDictionary *dict = @{@"ids":strId};
    
    
   
    [[AFAppDotNetAPIClient sharedClient] POST:BBG_Deleat_CART parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[JKProgressHuD shareJKProgressHuD] dismiss];
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([[responseObject objectForKey:@"code"] integerValue]==200) {
                [GlobalObject showProgresshudInView:self.view withText:@"删除成功"];
                totalLab.text=[NSString stringWithFormat:@"共参与%d件商品，总计%.2f元",goodCount,allPrice];
                [mainTableView reloadData];
            }else
            {
                [GlobalObject showProgresshudInView:self.view withText:@"数据异常，请稍后再试"];
            }
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[JKProgressHuD shareJKProgressHuD] dismiss];
        [GlobalObject showProgresshudInView:self.view withText:@"网络异常,请稍候再试"];
    }];
    NSLog(@"删除订单");

}
//删除

-(void)Click_edit:(UIButton*)btn
{
    
    
    NSString *str_weid=[NSString stringWithFormat:@"%@",[UserDefaults objectForKey:@"weid"]];
    
    
    if ([str_weid isEqualToString:@"0"]||str_weid==nil||[str_weid isEqualToString:@"(null)"]||str_weid.length==0) {
        [self getLocal_data];
    }else{
         [self Click_edit_network];
    }

    
    
   
}
//本地删除
-(void)getLocal_data{
    [db_shop_car open];
    NSMutableArray* nextArray=[[NSMutableArray alloc]init];
    for (OneYiyuanModel* model in dataArray) {
        if (model.isSelect) {
            [nextArray addObject:model];
            [db_shop_car executeUpdate:@"DELETE  FROM shopcar WHERE goodId = ?",model.id];
        }
    }
    [db_shop_car close];
    
    [dataArray removeObjectsInArray:nextArray];
    //btn.selected=!btn.selected;
    [mainTableView reloadData];
    
    float allPrice=0.0;
    int goodCount=0;
    for (OneYiyuanModel* model in dataArray) {
        
        if (model.isSelect) {
            goodCount++;
            allPrice+=[model.goodCount integerValue];
        }
        
    }
    totalLab.text=[NSString stringWithFormat:@"共参与%d件商品，总计%.2f元",goodCount,allPrice];
    
}

-(void)documentFolderPathdb{
    //获取应用程序的路径
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(
                                                               NSDocumentDirectory,
                                                               NSUserDomainMask,
                                                               YES);
    NSString *documentFolderPath = [searchPaths objectAtIndex:0];
    NSLog(@"docoumentFolderPath=%@",documentFolderPath);
    
    //往应用程序路径中添加数据库文件名称，把它们拼接起来
    NSString* dbFilePath = [documentFolderPath stringByAppendingPathComponent:@"LQJshopCar.sqlite"];
    NSLog(@"dbFilePath = %@",dbFilePath);
    db_shop_car = [FMDatabase databaseWithPath:dbFilePath];
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    [db_shop_car open];
    
     FMResultSet *resultSet1 = [db_shop_car executeQuery:@"SELECT * FROM shopcar"];
    
    //2.遍历结果
    while ([resultSet1 next]) {
        // (goodId, goodCount, titleName, imageUrl, allNum, saleNum, remainNum)
        
        OneYiyuanModel* model=[[OneYiyuanModel alloc]init];
        model.id=[resultSet1 stringForColumn:@"goodId"];
        model.goodCount=[resultSet1 stringForColumn:@"goodCount"];
        model.ProductPrice=[resultSet1 stringForColumn:@"goodPrice"];
        model.ProductName=[resultSet1 stringForColumn:@"titleName"];
        model.productImage=[resultSet1 stringForColumn:@"imageUrl"];
        model.ProCount=[resultSet1 stringForColumn:@"allNum"];
        model.SalerCount=[resultSet1 stringForColumn:@"saleNum"];
        model.remainCount=[resultSet1 stringForColumn:@"remainNum"];
        model.isSelect=YES;
        [dataArray addObject:model];
    }
    
    [db_shop_car close];
    
    [mainTableView reloadData];

    
}
-(void)loadMainView
{
    mainTableView=[[UITableView alloc]init];
    mainTableView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50);
    mainTableView.delegate=self;
    mainTableView.dataSource=self;
    mainTableView.backgroundColor=[GlobalObject colorWithHexString:@"#F4F4F4"];
    [self.view addSubview:mainTableView];
    
    UIView* footVIew=[[UIView alloc]init];
    footVIew.backgroundColor=[UIColor whiteColor];
    mainTableView.tableFooterView=footVIew;
    
    bottomView=[[UIView alloc]init];
    bottomView.frame=CGRectMake(0, self.view.frame.size.height-50-45, self.view.frame.size.width, 50);
    bottomView.backgroundColor=[GlobalObject colorWithHexString:@"#F0F0F0"];
    [bottomView.layer setBorderWidth:1.0*kFloatSize];
    
    [bottomView.layer setBorderColor:[GlobalObject colorWithHexString:@"#E6E6E6"].CGColor];
    [self.view addSubview:bottomView];
    
    allSelectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    allSelectBtn.frame=CGRectMake(10, (bottomView.frame.size.height-25)/2, 25, 25);
    [allSelectBtn setImage:[UIImage imageNamed:@"shopcar_noselect.png"] forState:UIControlStateNormal];
    [allSelectBtn setImage:[UIImage imageNamed:@"shopcar_select.png"] forState:UIControlStateSelected];
    allSelectBtn.selected=YES;
    [allSelectBtn addTarget:self action:@selector(Click_allSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:allSelectBtn];
    
    UILabel* allSelectLab=[[UILabel alloc]init];
    allSelectLab.frame=CGRectMake(allSelectBtn.frame.origin.x+allSelectBtn.frame.size.width+2, 0, 30, bottomView.frame.size.height);
    allSelectLab.text=@"全选";
    allSelectLab.font=[UIFont systemFontOfSize:14*kFloatSize];
    allSelectLab.textColor=[GlobalObject colorWithHexString:@"#7E7E7E"];
    [bottomView addSubview:allSelectLab];
    
    totalLab=[[UILabel alloc]init];
    totalLab.frame=CGRectMake(allSelectLab.frame.origin.x+allSelectLab.frame.size.width+10*kFloatSize, 0, self.view.frame.size.width/4*1.8, bottomView.frame.size.height);
    totalLab.font=[UIFont systemFontOfSize:12*kFloatSize];
    totalLab.numberOfLines=0;
    totalLab.textAlignment=NSTextAlignmentCenter;
    totalLab.textColor=[GlobalObject colorWithHexString:@"#7E7E7E"];

    [bottomView addSubview:totalLab];
    
    float allPrice=0.0;
    for (OneYiyuanModel* model in dataArray) {
        allPrice+=[model.goodCount integerValue];
    }
    totalLab.text=[NSString stringWithFormat:@"共参与%ld件商品，总计%.2f元",dataArray.count,allPrice];
    
    setBtn=[[UIButton alloc]init];
    setBtn.frame=CGRectMake(totalLab.frame.origin.x+totalLab.frame.size.width+7, (bottomView.frame.size.height-30)/2, 80, 30);
    setBtn.backgroundColor=[UIColor colorWithRed:229.0/255.0 green:67.0/255.0 blue:128.0/255.0 alpha:1.0];
   
    [setBtn.layer setCornerRadius:7*kFloatSize];
    [setBtn.layer setMasksToBounds:YES];
    [setBtn setTitle:@"结算" forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(Click_setOrder:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:setBtn];
    
    //数据为空的时候
    
    empty_bac_view=[[UIView alloc]initWithFrame:CGRectMake(0, 40*kFloatSize, self.view.frame.size.width, self.view.frame.size.height-75*kFloatSize)];
    empty_bac_view.backgroundColor=[GlobalObject colorWithHexString:@"#F4F4F4"];
    UIImageView *shop_car_image=[[UIImageView alloc]initWithFrame:CGRectMake(100*kFloatSize, 76*kFloatSize, 120*kFloatSize, 137*kFloatSize)];
    [shop_car_image setImage:[UIImage imageNamed:@"shop_car_empty"]];
    
    [empty_bac_view addSubview:shop_car_image];
    UIButton *btn_empty=[[UIButton alloc]initWithFrame:CGRectMake(100*kFloatSize, 240*kFloatSize, 120*kFloatSize, 25*kFloatSize)];
    [btn_empty setTitle:@"去逛逛" forState:UIControlStateNormal];
    btn_empty.titleLabel.font=[UIFont systemFontOfSize:14*kFloatSize];
    btn_empty.backgroundColor=[GlobalObject colorWithHexString:@"#EB4C7B"];
    [btn_empty addTarget:self action:@selector(Click_btn_empty:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn_empty.layer setCornerRadius:3*kFloatSize];
    [btn_empty.layer setMasksToBounds:YES];
    
    [btn_empty.layer setBorderColor:[GlobalObject colorWithHexString:@"#EB4C7B"].CGColor];
    
    [empty_bac_view addSubview:btn_empty];
    
}
//去购物
-(void)Click_btn_empty:(UIButton *)btn{
   NSArray *array = self.navigationController.childViewControllers;
    [self.navigationController popToViewController:array[0] animated:YES];
}
//提交订单
-(void)Click_setOrder:(UIButton*)btn
{
    NSString *weid =[UserDefaults objectForKey:@"weid"];
    //@"hq7nuv7i"; [UserDefaults objectForKey:@"weid"];
    if (weid.length==0 ||[weid isEqualToString:@"(null)"] ||[weid isEqualToString:@"nil"] ||[weid isEqualToString:@"0"]) {
        //登陆
        JKLoginViewController *login_view=[[JKLoginViewController alloc]init];
        [self.navigationController pushViewController:login_view animated:YES];
        
        return;
    }

    
    [[JKProgressHuD shareJKProgressHuD] showProgreessHuD:@"加载中" andView:self.view];
    
    NSString* strId=@"";
    NSString* strCount=@"";
    [db_shop_car open];
    NSMutableArray* nextArray=[[NSMutableArray alloc]init];
    for (OneYiyuanModel* model in dataArray) {
        if (model.isSelect) {
            if (strId.length) {
                strId=[NSString stringWithFormat:@"%@,%@",strId,model.YYGId];
                strCount=[NSString stringWithFormat:@"%@,%@",strCount,model.goodCount];
            }else
            {
                strId=[NSString stringWithFormat:@"%@",model.YYGId];
                strCount=[NSString stringWithFormat:@"%@",model.goodCount];
            }
            [nextArray addObject:model];
            [db_shop_car executeUpdate:@"DELETE  FROM shopcar WHERE goodId = ?",model.id];
        }
    }
    [db_shop_car close];
    
    NSString *ip = [GlobalObject localIPAddress];
    NSString *sign = [NSString stringWithFormat:@"action=addcartorder&weid=%@&ip=%@&yygids=%@&amount=%@",weid,ip,strId,strCount];
    sign = [self getSignwithsign:sign];
    //action=addcartorder
    NSDictionary *dict = @{@"weid":weid,@"ip":ip,@"yygids":strId,@"amount":strCount,@"sign":sign};

//    NSString *url = [NSString stringWithFormat:@"%@%@",COMMON_HEAD,addcartorder];
   
    [[AFAppDotNetAPIClient sharedClient] POST:BBG_AddCartOrder parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[JKProgressHuD shareJKProgressHuD] dismiss];
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([[responseObject objectForKey:@"code"] integerValue]==200) {
                NSString *sign1 = [NSString stringWithFormat:@"state=%@&totalfee=%@&tradenum=%@",[responseObject objectForKey:@"state"],[responseObject objectForKey:@"totalfee"],[responseObject objectForKey:@"tradenum"]];
                NSInteger state = [[responseObject objectForKey:@"state"] integerValue];
                switch (state) {
                    case 0:
                    {
                        sign1 = [self getSignwithsign:sign1];
                        if ([[responseObject objectForKey:@"sign"] isEqualToString:sign1]) {
                            _payDict = responseObject;
                            [self payWith:nextArray];
                            //                            [self pushToPaySuccessVC];
                        }
                    }
                        break;
                    case 1:
                    {
                        [GlobalObject showProgresshudInView:self.view withText:@"亲，订单重复提交"];
                    }
                        break;
                    case 2:
                    {
                        [GlobalObject showProgresshudInView:self.view withText:@"亲，该商品已被抢光"];
                    }
                        break;
                        
                    default:
                        [GlobalObject showProgresshudInView:self.view withText:@"数据异常，请稍后再试"];
                        break;
                }
            }else if([[responseObject objectForKey:@"code"] integerValue]==201)
            {
                [GlobalObject showProgresshudInView:self.view withText:@"警告：今日参与一元抢购已超过10000元，请明天再来玩！一元抢购仅供本平台会员间娱乐，切勿沉迷；抢红包仅供娱乐，不用于盈利目的！平台并不分成或收费！"];
            }
            else if([[responseObject objectForKey:@"code"] integerValue]==202)
            {
                [GlobalObject showProgresshudInView:self.view withText:@"您还不是创客，只能参与10次一元购！立即获取创客身份，任性一元购！"];
                [self go99Page];
            }
            else if([[responseObject objectForKey:@"code"] integerValue]==203)
            {
                [self goAddAddressPage];
                [GlobalObject showProgresshudInView:self.view withText:@"您还没有默认收货地址，不能参与一元抢购。请先设置一个默认收货地址!"];
            }else
            {
                [GlobalObject showProgresshudInView:self.view withText:@"数据异常，请稍后再试"];
            }
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[JKProgressHuD shareJKProgressHuD] dismiss];
        [GlobalObject showProgresshudInView:self.view withText:@"网络异常,请稍候再试"];
    }];
    NSLog(@"提交订单");
}
//点击全选
-(void)Click_allSelectBtn:(UIButton*)btn
{
    btn.selected=!btn.selected;
    if (btn.selected) {
        float allPrice=0.0;
        for (OneYiyuanModel* model in dataArray) {
            model.isSelect=YES;
            allPrice+=[model.goodCount integerValue];
        }
        totalLab.text=[NSString stringWithFormat:@"共参与%ld件商品，总计%.2f元",dataArray.count,allPrice];
    }else
    {
        
        for (OneYiyuanModel* model in dataArray) {
            model.isSelect=NO;
        }
        totalLab.text=[NSString stringWithFormat:@"共参与0件商品，总计0.00元"];
    }
    [mainTableView reloadData];
}
-(void)Click_selectBtn:(UIButton*)btn
{
    btn.selected=!btn.selected;
    OneYiyuanModel* mode=[dataArray objectAtIndex:btn.tag];
    mode.isSelect=btn.selected;
    if (btn.selected) {
        BOOL allSelect=YES;
        for (OneYiyuanModel* model in dataArray) {
            if (!model.isSelect) {
                allSelect=NO;
                break;
            }
        }
        allSelectBtn.selected=allSelect;
    }else
    {
        allSelectBtn.selected= NO;
    }
    
    float allPrice=0.0;
    int count=0;
    for (OneYiyuanModel* model in dataArray) {
        
        if (model.isSelect) {
            count++;
            allPrice+=[model.goodCount integerValue];
        }
        
    }
    totalLab.text=[NSString stringWithFormat:@"共参与%d件商品，总计%.2f元",count,allPrice];
    
}
-(void)Click_addBtn:(UIButton*)btn
{
    OneYiyuanModel* model=[dataArray objectAtIndex:btn.tag];
    NSIndexPath *indexp=[NSIndexPath indexPathForRow:btn.tag inSection:0];
    shopCarCell* cell=(shopCarCell*)[mainTableView cellForRowAtIndexPath:indexp];
    
    NSInteger count=[cell.numTF.text integerValue];
    if (count>=[model.remainCount integerValue]||count==0) {
        return;
    }
    count++;
    
    model.goodCount=[NSString stringWithFormat:@"%ld",count];
    cell.numTF.text=model.goodCount;
    [db_shop_car open];
    //     FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM shopcar WHERE goodId = ?",model.id];
    //
    //     //存在该数据  更改
    //     if ([resultSet next]) {
    //         int ID = [resultSet intForColumn:@"goodId"];
    //         // NSString *goodCount = [resultSet stringForColumn:@"goodCount"];
    [db_shop_car executeUpdate:@"UPDATE shopcar SET goodCount = ? WHERE goodId = ?",model.goodCount,model.id];
    //     }
    
    [db_shop_car close];
    
    float allPrice=0.0;
    int goodCount=0;
    for (OneYiyuanModel* model in dataArray) {
        
        if (model.isSelect) {
            goodCount++;
            allPrice+=[model.goodCount integerValue];
        }
        
    }
    totalLab.text=[NSString stringWithFormat:@"共参与%d件商品，总计%.2f元",goodCount,allPrice];
    
    
}
-(void)Click_reduceBtn:(UIButton*)btn
{
    OneYiyuanModel* model=[dataArray objectAtIndex:btn.tag];
    NSIndexPath *indexp=[NSIndexPath indexPathForRow:btn.tag inSection:0];
    shopCarCell* cell=(shopCarCell*)[mainTableView cellForRowAtIndexPath:indexp];
    NSInteger count=[cell.numTF.text integerValue];
    if (count<=1) {
        return;
    }
    count--;
    
    model.goodCount=[NSString stringWithFormat:@"%ld",count];
    cell.numTF.text=model.goodCount;
    [db_shop_car open];
    //     FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM shopcar WHERE goodId = ?",model.id];
    //
    //     //存在该数据  更改
    //     if ([resultSet next]) {
    //         int ID = [resultSet intForColumn:@"goodId"];
    //         // NSString *goodCount = [resultSet stringForColumn:@"goodCount"];
    [db_shop_car executeUpdate:@"UPDATE shopcar SET goodCount = ? WHERE goodId = ?",model.goodCount,model.id];
    //     }
    
    [db_shop_car close];
    
    float allPrice=0.0;
    int goodCount=0;
    for (OneYiyuanModel* model in dataArray) {
        
        if (model.isSelect) {
            goodCount++;
            allPrice+=[model.goodCount integerValue];
        }
        
    }
    totalLab.text=[NSString stringWithFormat:@"共参与%d件商品，总计%.2f元",goodCount,allPrice];
}
-(NSString *)getSignwithsign:(NSString *)sign{
    sign = [NSString stringWithFormat:@"%@&key=%@",sign,BBGSIGNKEY];
    sign = [GlobalObject md5HexDigest:sign];
    sign = [sign uppercaseString];
    return sign;
}

//前往购买99页面
-(void)go99Page{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *weid=[NSString stringWithFormat:@"%@",[user objectForKey:@"weid"]];
    weid=[JKEncrypt returnJiamiStringWithString:[JKEncrypt base64StringFromText:weid]];
//    JKWebViewController *webVC=[[JKWebViewController alloc]init];
//    webVC.baseUrl=[NSString stringWithFormat:@"%@/p/2.aspx?weid=%@",COMMON_HEAD,weid];
//    webVC.identifier = @"gooddetail";
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:webVC];
//    [self presentViewController:nav animated:YES completion:nil];
}

//前往添加收获地址页面
-(void)goAddAddressPage{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *weid=[NSString stringWithFormat:@"%@",[user objectForKey:@"weid"]];
    weid=[JKEncrypt returnJiamiStringWithString:[JKEncrypt base64StringFromText:weid]];
    JKCommonWebView *webVC=[[JKCommonWebView alloc]init];
//    webVC.str_to_url=[NSString stringWithFormat:@"%@/editaddress/0?weid=%@",COMMON_HEAD,weid];
    //http://c.app.zckj.159.net/address?weid=nBcWr11319
    webVC.str_to_url=@"http://c.app.zckj.159.net/address?weid=hq7nuv7i";
    
//    webVC.identifier = @"gooddetail";
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:webVC];
    [self presentViewController:nav animated:YES completion:nil];
}
//显示键盘
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    // [self doneButtonshow];
    tableViewPoint=mainTableView.contentOffset;
    NSIndexPath *indexp=[NSIndexPath indexPathForRow:textField.tag inSection:0];
    //shopCarGoodCell* cell=(shopCarGoodCell*)[mainTableView cellForRowAtIndexPath:indexp];
    
    //NSLog(@"yyy=%.2f",cell.frame.origin.y);
    mainTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, mainTableView.frame.size.width, 210)];
    
    [UIView animateWithDuration:0.4 animations:^{
        [mainTableView scrollToRowAtIndexPath:indexp atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }completion:^(BOOL finished) {
        
        
    } ];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    OneYiyuanModel* model=[dataArray objectAtIndex:textField.tag];
    NSIndexPath *indexp=[NSIndexPath indexPathForRow:textField.tag inSection:0];
    shopCarCell* cell=(shopCarCell*)[mainTableView cellForRowAtIndexPath:indexp];
    
    NSInteger count=[cell.numTF.text integerValue];
    if (count>=[model.remainCount integerValue]) {
        count=[model.remainCount integerValue];
    }
    if (count==0) {
        count=1;
    }
    //count++;
    
    model.goodCount=[NSString stringWithFormat:@"%ld",count];
    cell.numTF.text=model.goodCount;
    [db_shop_car open];
    //     FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM shopcar WHERE goodId = ?",model.id];
    //
    //     //存在该数据  更改
    //     if ([resultSet next]) {
    //         int ID = [resultSet intForColumn:@"goodId"];
    //         // NSString *goodCount = [resultSet stringForColumn:@"goodCount"];
    [db_shop_car executeUpdate:@"UPDATE shopcar SET goodCount = ? WHERE goodId = ?",model.goodCount,model.id];
    //     }
    
    [db_shop_car close];
    
    float allPrice=0.0;
    int goodCount=0;
    for (OneYiyuanModel* model in dataArray) {
        
        if (model.isSelect) {
            goodCount++;
            allPrice+=[model.goodCount integerValue];
        }
        
    }
    totalLab.text=[NSString stringWithFormat:@"共参与%d件商品，总计%.2f元",goodCount,allPrice];
    
    
    //    NSString* url=[NSString stringWithFormat:SHOPCART_CHANGE,COMMON_HEAD];
    //    NSMutableDictionary* postDic=[[NSMutableDictionary alloc]init];
    //    [postDic setObject:[ud objectForKey:@"key"] forKey:@"key"];
    //    [postDic setObject:textField.text forKey:@"quantity"];
    //    [postDic setObject:[[[[dataArray objectAtIndex:textField.tag/1000] objectForKey:@"store_list"] objectAtIndex:textField.tag%1000] objectForKey:@"cart_id"] forKey:@"cart_id"];
    //    changeCountDic=[[[dataArray objectAtIndex:textField.tag/1000] objectForKey:@"store_list"] objectAtIndex:textField.tag%1000];
    //    [self changeGetDataWithUrl:url WithParameters:postDic];
    
}
-(void)keyboardWillAppear:(NSNotification *)notification
{
    CGRect keyboardEndingUncorrectedFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGRect keyboardEndingFrame = [self.view convertRect:keyboardEndingUncorrectedFrame fromView:nil];
    [self doneButtonshow:keyboardEndingFrame.origin.y];
}
-(void)doneButtonshow:(CGFloat)hei{
    if (doneView==nil) {
        doneView=[[UIView alloc]init];
        doneView.frame=CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 40);
        doneView.backgroundColor=[UIColor lightGrayColor];
        
        UIButton* doneButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        doneButton.frame = CGRectMake(doneView.frame.size.width-120, 0, 80, 40);
        [doneButton setTitle:@"完成" forState: UIControlStateNormal];
        [doneButton addTarget: self action:@selector(keyBoardDismiss) forControlEvents: UIControlEventTouchUpInside];
        
        [doneView addSubview:doneButton];
    }
    doneView.frame=CGRectMake(0, hei-40, self.view.frame.size.width, 40);
    
    [self.view addSubview:doneView];
    
}

//收回键盘
-(void)keyBoardDismiss
{
//    [doneView removeFromSuperview];
//    mainTableView.tableFooterView=nil;
//    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
//    
//    [UIView animateWithDuration:0.4 animations:^{
//        mainTableView.contentOffset=tableViewPoint;
//        
//    }completion:^(BOOL finished) {
//        
//        
//    } ];
    
}
#pragma mark - 支付相关
-(void)payWith:(NSArray *)yiYuansArray{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealWithPayResult:) name:@"PAY_STATE" object:nil];
    
    /*
     //商品或支付单简要描述
     NSString *body = @"玫瑰养肤精华液";
     //附加数据，在查询API和支付通知中原样返回，该字段主要用于商户携带订单的自定义数据
     NSString *attach = @"postc.bbg.159.net";
     //商户系统内部的订单号,32个字符内、可包含字母,
     NSString *out_trade_no = @"UHIdsaduosdausdao02";
     //接收微信支付异步通知回调地址，通知url必须为直接可访问的url，不能携带参数。
     NSString *notify_url = @"http://ceshi.159.net/netpay/wechat/payNotifyUrl6.aspx";
     //交易金额默认为人民币交易，接口中参数支付金额单位为【分】，参数值不能带小数。对账单中的交易金额单位为【元】。
     NSString *total_fee = @"1";
     */
    OneYiyuanModel *model = yiYuansArray[0];
    NSString *body = [NSString stringWithFormat:@"%@",model.ProductName];
    NSString *out_trade_no = [NSString stringWithFormat:@"%@",[_payDict objectForKey:@"tradenum"]];
    NSString *notify_url = [NSString stringWithFormat:NOTIFY_URL_YY,COMMON_ZZCKJ];
    NSString *totalfee = [NSString stringWithFormat:@"%.0f",[[_payDict objectForKey:@"totalfee"] floatValue]*100];
    
    
    NSDictionary *dict = @{@"body":body,
                           @"out_trade_no":out_trade_no,
                           @"notify_url":notify_url,
                           @"total_fee":totalfee
                           };
    [[JKWXPay shareInstance] payWithInfo:dict];

}
-(void)dealWithPayResult:(NSNotification *)notification{
    [[NSNotificationCenter defaultCenter] removeObserver:@"PAY_STATE"];
    NSString *state = notification.object;
    NSString *resultString;
    if ([state isEqualToString:@"1"]) {
        resultString = @"支付成功";
        [self pushToPaySuccessVC];
        return;
    }else if ([state isEqualToString:@"2"]){
        resultString = @"支付取消";
    }
    else if ([state isEqualToString:@"3"]){
        resultString = @"支付失败";
    }
    else if ([state isEqualToString:@"4"]){
        resultString = @"支付信息异常";
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [GlobalObject showProgresshudInView:window withText:resultString];
    [self backToUp];
}

-(void)pushToPaySuccessVC{
    JKYYPaySuccessController *paySuccessVC = [[JKYYPaySuccessController alloc]init];
    paySuccessVC.PayOrderCode = [NSString stringWithFormat:@"%@",[_payDict objectForKey:@"tradenum"]];;
    [self.navigationController pushViewController:paySuccessVC animated:YES];
}

#pragma mark uitableview 代理函数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dataArray.count>0) {
        btn_edit.hidden=NO;
        if (empty_bac_view) {
            [empty_bac_view removeFromSuperview];
        }
    }else{
        btn_edit.hidden=YES;
        [self.view addSubview:empty_bac_view];
    }
    return dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    shopCarCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell) {
        cell=[[shopCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.selectBtn.tag=indexPath.row;
    [cell.selectBtn addTarget:self action:@selector(Click_selectBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.addBtn.tag=indexPath.row;
    [cell.addBtn addTarget:self action:@selector(Click_addBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.reduceBtn.tag=indexPath.row;
    [cell.reduceBtn addTarget:self action:@selector(Click_reduceBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    cell.deleteBtn.tag=indexPath.row;
    //    [cell.deleteBtn addTarget:self action:@selector(Click_deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.numTF.delegate=self;
    cell.numTF.tag=indexPath.row;
    [cell setDataWithModel:[dataArray objectAtIndex:indexPath.row] WithIsEdit:btn_edit.selected];
    return cell;
}

#pragma mark ---用户登录状态下---
-(void)getShopCarData{
    
    //&yyid=%@&weid=%@
    [[JKProgressHuD shareJKProgressHuD] showProgreessHuD:@"加载中" andView:self.view];
//    NSDictionary *params = @{@"weid":@"nBcWr11319"};
    [[AFAppDotNetAPIClient sharedClient] POST:BBG_shopCarList parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            [[JKProgressHuD shareJKProgressHuD] dismiss];
            NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
            NSString *str_message=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
            NSLog(@"OneDetails:%@",str_message);
            if (code == 200) {
//                dataArray=[NSMutableArray arrayWithArray:[responseObject objectForKey:@"cartList"]];
                [self vvvv:[responseObject objectForKey:@"cartList"]];
            }else{
                [[JKProgressHuD shareJKProgressHuD] showProgreessText:@"该商品未找到" andView:self.view];
                
            }
//            [mainTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[JKProgressHuD shareJKProgressHuD] dismiss];
        
        [[JKProgressHuD shareJKProgressHuD] showProgreessText:@"网络异常,请稍后再试" andView:self.view];
    }];

    
}
-(void)vvvv:(NSArray *)array{
    //2.遍历结果
    float allPrice=0.0;
    for (NSDictionary *dict in array) {
        OneYiyuanModel* model=[[OneYiyuanModel alloc]init];
        model.id=[dict objectForKey:@"id"];
        model.goodCount=[dict objectForKey:@"Buycount"];
        model.ProductPrice=@"2.00";
        model.ProductName=[dict objectForKey:@"ProductName"];
        model.productImage=[dict objectForKey:@"productImage"];
        model.ProCount=[dict objectForKey:@"ProCount"];
        model.SalerCount=[dict objectForKey:@"SalerCount"];
        model.remainCount=[dict objectForKey:@"Leftcount"];
        model.isSelect=YES;
        model.YYGId=[dict objectForKey:@"YYGId"];
        [dataArray addObject:model];
        
        allPrice+=[model.goodCount integerValue];
        
    }
    
    
    totalLab.text=[NSString stringWithFormat:@"共参与%ld件商品，总计%.2f元",dataArray.count,allPrice];
    
    [mainTableView reloadData];
}
@end
