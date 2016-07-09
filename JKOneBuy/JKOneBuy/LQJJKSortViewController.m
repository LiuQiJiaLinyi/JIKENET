//
//  JKSortViewController.m
//  JKOneBuy
//
//  Created by teaplant on 16/6/23.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "LQJJKSortViewController.h"
#import "JKCategoryCell.h"
#import "JKSortModel.h"
#import "GlobalObject.h"
#import <FMDB.h>
#import <AFNetworking.h>
#import "OneYiyuanModel.h"
#define kFloatHeightScale [UIScreen mainScreen].bounds.size.height/608.f
#define kWidthScale [UIScreen mainScreen].bounds.size.width/320.f

@interface LQJJKSortViewController()
{
    UIView * headView;
    NSMutableArray * data_Array;
    NSInteger num_cells;
    UILabel * sum_label;
    JKCategoryCell *cell;
    UIView * shoppingCarView;//可以拖动的按钮
}
@property (nonatomic ,copy)FMDatabase * db;
@end

@implementation LQJJKSortViewController
-(void)viewDidLoad{
    num_cells = 0;
    
    data_Array = [[NSMutableArray alloc] init];
    [self addHeadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.sortTableView];
    [self recivedData];
    self.title=@"电器Ω≈Ω≈Ω";
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticReciever:) name:@"JKCategoryCell" object:nil];
    [super viewDidLoad];
}

- (void)addHeadView
{
    shoppingCarView = [[UIView alloc] initWithFrame:CGRectMake(0, 556*kWidthScale,38 *kWidthScale , 38 *kWidthScale)];
    shoppingCarView.backgroundColor = [UIColor redColor];
    shoppingCarView.userInteractionEnabled =YES;
    
    UIPanGestureRecognizer * panPress = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(shoppingCartView:)];
    panPress.maximumNumberOfTouches = 1;
    panPress.minimumNumberOfTouches = 1;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shoppingCartView:)];
    [shoppingCarView addGestureRecognizer:tap];
    [shoppingCarView addGestureRecognizer:panPress];
    
    
    
    headView = [[UIView alloc] initWithFrame:CGRectMake(0,40*kFloatHeightScale, [UIScreen mainScreen].bounds.size.width, 70)];
    [headView setBackgroundColor:[UIColor whiteColor]];
    headView.userInteractionEnabled = YES;
    
    sum_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headView.bounds.size.width/2, headView.bounds.size.height)];
    sum_label.text = @"共0件商品";
    
    UIButton * bottomBut = [[UIButton alloc] initWithFrame:CGRectMake(headView.frame.size.width- (88 *kWidthScale),10, 76*kWidthScale,  headView.bounds.size.height-20)];
    bottomBut.backgroundColor = [UIColor redColor];
    bottomBut.layer.cornerRadius = 5;
    [bottomBut setTitle:@"全部加入购物车" forState:UIControlStateNormal];
    bottomBut.font = [UIFont systemFontOfSize:15];
    [bottomBut addTarget:self action:@selector(sumButCliked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [headView addSubview:sum_label];
    [headView addSubview:bottomBut];
    [self.view addSubview:headView];
    [self.view addSubview:shoppingCarView];
    
    
    
}

#pragma mark --添加tableview
-(UITableView *)sortTableView{
    
    if (_sortTableView==nil) {
        
        int tableheight = headView.frame.origin.y + (headView.frame.size.height);
        
        _sortTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, tableheight, self.view.frame.size.width, self.view.frame.size.height -tableheight) style:UITableViewStylePlain];
        
        _sortTableView.delegate= self;
        _sortTableView.dataSource = self;
        
    }
    
    
    return _sortTableView;
}
#pragma mark-
#pragma mark--tableView代理函数
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return 90 * kFloatHeightScale;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return num_cells;
}

static NSString *jksortcellID=@"sortCell";

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    cell=[tableView dequeueReusableCellWithIdentifier:jksortcellID];
    
    if (cell==nil)
    {
        cell= [[JKCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jksortcellID];
    }
    cell.name_str = data_Array[indexPath.row][@"ProductName"];
    cell.sum_str = data_Array[indexPath.row][@"ProCount"];
    NSString *tempsum =data_Array[indexPath.row][@"ProCount"];
    NSString * tempsaler = data_Array[indexPath.row][@"SalerCount"];
    int leftIt = [tempsum intValue] -[tempsaler intValue];
    NSString * strLeft = [NSString stringWithFormat:@"%d",leftIt];
    cell.left_str = strLeft;
    cell.image_str = data_Array[indexPath.row][@"productImage"];
    cell.weak_tableview = _sortTableView;
    
    return cell;
}


#pragma mark-
#pragma mark --数据库操作,存储值为遍历数组cartList；
- (BOOL)writeToFile:(NSDictionary *)userDict
{
     NSMutableDictionary* addDic=[[NSMutableDictionary alloc] initWithDictionary:userDict];
    [addDic setObject:@"1" forKey:@"addSelect"];
    OneYiyuanModel * model=[OneYiyuanModel mj_objectWithKeyValues:addDic];
    
    //储存在Document目录下
    NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cacheDir stringByAppendingPathComponent:@"LQJshopCar.sqlite"];
    NSLog(@"%sççççç%@",__FUNCTION__,filePath);
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    BOOL flag = [_db open];
    if (flag) {
        NSLog(@"数据库打开成功");
    }else{
        NSLog(@"数据库打开失败");
    }
    
    /*
     YiYuanModel* model=[[YiYuanModel alloc]init];
    model.id=[resultSet1 stringForColumn:@"goodId"];
    model.goodCount=[resultSet1 stringForColumn:@"goodCount"];
    model.ProductPrice=[resultSet1 stringForColumn:@"goodPrice"];
    model.ProductName=[resultSet1 stringForColumn:@"titleName"];
    model.productImage=[resultSet1 stringForColumn:@"imageUrl"];
    model.ProCount=[resultSet1 stringForColumn:@"allNum"];
    model.SalerCount=[resultSet1 stringForColumn:@"saleNum"];
    model.remainCount=[resultSet1 stringForColumn:@"remainNum"];
    model.isSelect=YES;
     */
    
    BOOL createSuccess =  [_db executeUpdate:@"create table if not exists shopCar(goodId text,goodCount text, goodPrice text,titleName,productName text,productImage text,allNum text,saleNum text,leftCount text,isSelect text)"];
    if (createSuccess)
    {
       int leftcount= ([userDict[@"ProCount"] intValue]-[userDict[@"SalerCount"] intValue]);
        NSString * leftCount = [NSString stringWithFormat:@"%d",leftcount];
        
        BOOL insert = [_db executeUpdate:@"insert into shopCar (goodId,goodCount,goodPrice,titleName,productImage,allNum,saleNum,leftCount,isSelect) values(?,?,?,?,?,?,?,?,?)",userDict[@"ProductId"],userDict[@"1"],userDict[@"ProductPrice"],userDict[@"ProductName"],userDict[@"productImage"],userDict[@"ProCount"],userDict[@"SalerCount"],leftCount,@"1"];
        
        if (insert)
        {
            NSLog(@"插入数据成功");
        }
        else
        {
            NSLog(@"插入数据失败");
        }
    };
    
    return createSuccess;
}
#pragma mark-
#pragma mark --接收数据
- (void)recivedData
{
    NSString * urlstr = @"http://c.app.zckj.159.net/API/Api.ashx?action=mall_yyg_class&cid=1&weid=nBcWr11319";
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    manger.responseSerializer = [AFCompoundResponseSerializer serializer];
    
    [manger POST:urlstr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData * data = (NSData * )responseObject;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
       // NSDictionary * dict = (NSDictionary * )responseObject;
        [data_Array removeAllObjects];
        
        sum_label.text = [NSString stringWithFormat:@"共%@件商品",dict[@"total"]];
        
        
        [data_Array addObjectsFromArray:dict[@"yiyuan"]];
        num_cells = [data_Array count];
        
        [_sortTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
}

#pragma mark --读取数据
-(void)readFromFile
{
    NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cacheDir stringByAppendingPathComponent:@"LQJshopCar.sqlite"];
    
    _db=[FMDatabase databaseWithPath:filePath];
    
    if (![_db open])
    {
        NSLog(@"数据库打开失败");
        return;
    }
    else
    {
        FMResultSet *resultSet=[_db executeQuery:@"select* from shopCar"];
        while ([resultSet next])
        {
          
        }
    }
  
    
}

-(void)sumButCliked:(UIButton*)button
{
[self performSelectorInBackground:@selector(saveAllAum) withObject:nil];
}

-(void)saveAllAum
{
     for (NSDictionary * ddict in data_Array)
     {
        [self writeToFile:ddict];
         NSLog(@"%s,%@",__FUNCTION__,ddict);
     }
}


- (void)noticReciever:(NSNotification * )notic
{
    //[notic object];
    NSDictionary * userInformationDict = (NSDictionary *) [notic object];
    
    NSString * tagStr = userInformationDict[@"buttontag"];
    NSString * rowStr = userInformationDict[@"cellRow"];
    int i = [tagStr intValue];
    int cellRow = [rowStr intValue];
    
    switch (i){
        case 172700:
        {
            //购物车
         NSDictionary * tempRow = data_Array[cellRow];
         [self writeToFile:tempRow];
        }
            break;
        case 172701:
        {
            //一元购
            
        }
            break;
            
        default:
            break;
    }
    
}

-(void)shoppingCartView:(UIGestureRecognizer *)gesture
{

    if (gesture.state != UIGestureRecognizerStateEnded && gesture.state != UIGestureRecognizerStateFailed){
        //通过使用 locationInView 这个方法,来获取到手势的坐标不使用gesture.view
       CGPoint locationXY= [(UIPanGestureRecognizer*)gesture translationInView:shoppingCarView];
        
       // CGPoint location = [gesture locationInView:gesture.view.superview];
        shoppingCarView.center = locationXY;
    }
}


//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%@",[[touches anyObject] locationInView:self.view]);
//}
@end

