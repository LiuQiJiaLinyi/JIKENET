//
//  LQJJKSortViewController.m
//  JKOneBuy
//
//  Created by teaplant on 16/6/23.
//  Copyright © 2016年 teaplant. All rights reserved.
//


#import "GlobalObject.h"
#import <FMDB.h>
#import <AFNetworking.h>

#import "OneYiyuanModel.h"
#import "OneDetailsViewController.h"
#import "LQJJKSortViewController.h"
#import "JKCategoryCell.h"
#import "JKSortModel.h"
#import "ShoppingCartViewController.h"

#define kFloatHeightScale [UIScreen mainScreen].bounds.size.height/608.f
#define kWidthScale [UIScreen mainScreen].bounds.size.width/320.f

@interface LQJJKSortViewController()
{
    UIView * headView;
    NSMutableArray * data_Array;
    NSInteger num_cells;
    UILabel * sum_label;
    JKCategoryCell *cell;
    UIView * shoppingCarView;
    
    int fontsize;
}
@property (nonatomic ,copy)FMDatabase * db;
@end

@implementation LQJJKSortViewController
-(void)viewDidLoad{
    num_cells = 0;
    fontsize = [UIScreen mainScreen].bounds.size.width*(15.f/400.f);
    
     self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]};
     self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:233.0/255.0 green:46.0/255.0 blue:106.0/255.0 alpha:1.0];
     
     UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
     
     [leftbtn addTarget:self action:@selector(backToMessageVC) forControlEvents:UIControlEventTouchUpInside];
     [leftbtn setBackgroundImage:[UIImage imageNamed:@"nav_bar_left_new.png"] forState:UIControlStateNormal];
     [leftbtn setFrame:CGRectMake( 0, 0, 12*kFloatSize, 17*kFloatSize)];
     UIBarButtonItem *leftItem  =[[UIBarButtonItem alloc] initWithCustomView:leftbtn];
     self.navigationItem.leftBarButtonItem = leftItem;


    
    data_Array = [[NSMutableArray alloc] init];
    [self addHeadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.sortTableView];
    [self recivedData];
    [self addShoppingCartView];
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticReciever:) name:@"JKCategoryCell" object:nil];
    [super viewDidLoad];
}

-(void)backToMessageVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addHeadView
{
    headView = [[UIView alloc] initWithFrame:CGRectMake(0,70*kFloatHeightScale, [UIScreen mainScreen].bounds.size.width, 50)];
    [headView setBackgroundColor:[UIColor whiteColor]];
    headView.userInteractionEnabled = YES;
    
    sum_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headView.bounds.size.width/2, headView.bounds.size.height)];
    [sum_label setTextColor:[UIColor colorWithRed:0.557 green:0.557 blue:0.557 alpha:1.00]];
    sum_label.text = @"共0件商品";
    
    UIButton * bottomBut = [[UIButton alloc] initWithFrame:CGRectMake(headView.frame.size.width- (105 *kWidthScale),10, 100*kWidthScale,  headView.bounds.size.height-20)];
    bottomBut.backgroundColor = [UIColor colorWithRed:0.906 green:0.278 blue:0.494 alpha:1.00];
    bottomBut.layer.cornerRadius = 5;
    [bottomBut setTitle:@"全部加入购物车" forState:UIControlStateNormal];
    [bottomBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bottomBut.font = [UIFont systemFontOfSize:fontsize];
   
    [bottomBut addTarget:self action:@selector(sumButCliked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [headView addSubview:sum_label];
    [headView addSubview:bottomBut];
    [self.view addSubview:headView];
}
-(void)addShoppingCartView
{
    shoppingCarView = [[UIView alloc] initWithFrame:CGRectMake(0, 515*kWidthScale,38 *kWidthScale , 38 *kWidthScale)];
    shoppingCarView.backgroundColor = [UIColor redColor];
    shoppingCarView.userInteractionEnabled =YES;
    shoppingCarView.layer.cornerRadius = (38 * kWidthScale)/2;
    UIImage * iamge = [UIImage imageNamed:@"shoppingCart"];
    
    CGFloat scale = [[UIScreen mainScreen]scale];
    
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(shoppingCarView.frame.size, NO, scale);
    [iamge drawInRect:CGRectMake(0,0,shoppingCarView.frame.size.width,shoppingCarView.frame.size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    shoppingCarView.backgroundColor = [UIColor colorWithPatternImage:newImage];
    
    UIPanGestureRecognizer * panPress = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(shoppingCartView:)];
    panPress.maximumNumberOfTouches = 1;
    panPress.minimumNumberOfTouches = 1;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shoppingCartView:)];
    [shoppingCarView addGestureRecognizer:tap];
    [shoppingCarView addGestureRecognizer:panPress];
    [self.view insertSubview:shoppingCarView aboveSubview:_sortTableView];
}


#pragma mark-
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
    
    NSString * selected = [NSString stringWithFormat:@"%@",data_Array[indexPath.row][@"State"]];
    
    if ([self readFromFile:data_Array[indexPath.row][@"ProductName"]]) {
        [cell resetButtonStates:YES];
    }
    
    if ([selected isEqualToString:@"0"])
    {
        [cell resetButtonStates:NO];
    }
    return cell;
}


#pragma mark-
#pragma mark --数据库操作,存储值为遍历数组cartList；
- (BOOL)writeToFile:(NSDictionary *)userDict
{
     NSMutableDictionary* addDic=[[NSMutableDictionary alloc] initWithDictionary:userDict];
    [addDic setObject:@"1" forKey:@"addSelect"];
    OneYiyuanModel * model=[OneYiyuanModel mj_objectWithKeyValues:addDic];
    
    //储存在Document目录
    
    NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString *filePath = [cacheDir stringByAppendingPathComponent:@"LQJshopCar.sqlite"];
    
    
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
    
    BOOL createSuccess =  [_db executeUpdate:@"create table if not exists shopCar(goodId text,goodCount text, goodPrice text,titleName text,productName text,imageurl text,allNum text,saleNum text,remainNum text,isSelect text)"];
    
    if (createSuccess)
    {
       int leftnum= ([userDict[@"ProCount"] intValue]-[userDict[@"SalerCount"] intValue]);
        
        NSString * leftCount = [NSString stringWithFormat:@"%d",leftnum];
        
        BOOL insert = [_db executeUpdate:@"insert into shopCar (goodId,goodCount,goodPrice,titleName,imageurl,allNum,saleNum,remainNum,isSelect) values(?,?,?,?,?,?,?,?,?)",userDict[@"ProductId"],@"1",userDict[@"ProductPrice"],userDict[@"ProductName"],userDict[@"productImage"],userDict[@"ProCount"],userDict[@"SalerCount"],leftCount,@"1"];
        
        if (insert)
        {
            NSLog(@"插入数据成功");
        }
        else
        {
            NSLog(@"插入数据失败");
        }
    };
    
    [_db close];
    
    return createSuccess;
}
#pragma mark-
#pragma mark --接收数据
- (void)recivedData
{
    NSString * urlstr;
    if (_str_url != nil)
    {
       urlstr = _str_url;
    }
    else
    {
       urlstr = @"http://c.app.zckj.159.net/API/Api.ashx?action=mall_yyg_class&cid=1&weid=nBcWr11319";
    }
    
    
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
-(BOOL)readFromFile:(NSString *)goodsname
{
    NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cacheDir stringByAppendingPathComponent:@"LQJshopCar.sqlite"];
    
    _db=[FMDatabase databaseWithPath:filePath];
    
    if (![_db open])
    {
        NSLog(@"数据库打开失败");
        return NO;
    }
    else
    {
        NSString * searchStr = [NSString stringWithFormat:@"select * from shopCar where goodId = %@",goodsname];
        FMResultSet *resultSet=[_db executeQuery:searchStr];
        if (resultSet != nil) {
            return YES;
        }else
        {
            return NO;
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

#pragma mark-
#pragma mark --接收通知,跳转到不同页面OnedetailVC ,shoppingCartVC 读取数据的不同方式--

- (void)noticReciever:(NSNotification * )notic
{
    //[notic object];
    /*
     str_one_yyid;
     str_one_weid;
     
     reduceBtn;
     addBtn;
     numLab;
     Lab_money;
     */
    OneDetailsViewController * oneDetailVC = [[OneDetailsViewController alloc] init];
    
    NSDictionary * userInformationDict = (NSDictionary *) [notic object];
    
    NSString * tagStr = userInformationDict[@"buttontag"];
    NSString * rowStr = userInformationDict[@"cellRow"];
    
    int i = [tagStr intValue];
    int cellRow = [rowStr intValue];
    
    switch (i){
        case 172700:
        {
            //购物车
            BOOL userIsOnboard ;
            
            if (userIsOnboard)
            {
                
            }
            else
            {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cellRow inSection:0];
                
                NSDictionary * tempRow = data_Array[cellRow];
                
                [self writeToFile:tempRow];
                
               JKCategoryCell* catecell=(JKCategoryCell*)[_sortTableView cellForRowAtIndexPath:indexPath];
                
                [catecell resetButtonStates:YES];
                
            }
            
         
        }
            break;
        case 172701:
        {
            //一元购
            [self.navigationController pushViewController:oneDetailVC animated:YES];
            
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
    
    ShoppingCartViewController * shoppingviewcontr = [[ShoppingCartViewController alloc] init];
    shoppingviewcontr.hidesBottomBarWhenPushed=NO;
    shoppingviewcontr.str_identif=@"LQJJKSortViewController";
    
    [self.navigationController pushViewController:shoppingviewcontr animated:YES];
}

-(void)setStr_url:(NSString *)str_url
{
    _str_url = str_url;
}
-(void)setName_sort:(NSString *)name_sort
{
    _name_sort = name_sort;
    self.title =name_sort;
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%@",[[touches anyObject] locationInView:self.view]);
//}
@end

