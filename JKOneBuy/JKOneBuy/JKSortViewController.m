//
//  JKSortViewController.m
//  JKOneBuy
//
//  Created by teaplant on 16/6/23.
//  Copyright © 2016年 teaplant. All rights reserved.
//

#import "JKSortViewController.h"
#import "JKSortCell.h"

@implementation JKSortViewController




-(void)viewDidLoad{

    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    [self.view addSubview:self.sortTableView];
    
    self.title=@"分类";
    
    
}

-(UITableView *)sortTableView{

    if (_sortTableView==nil) {
        
        _sortTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        
        [_sortTableView setDelegate:self];
        [_sortTableView setDataSource:self];
        
        [_sortTableView reloadData];
        
        
    }

    
    return _sortTableView;
}

#pragma mark tableView代理函数
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
   
    return 60;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"sortCell";
      JKSortCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell= [[[NSBundle mainBundle]loadNibNamed:@"JKSortCell" owner:nil options:nil] firstObject];
           }
   
    JKSortModel *sortModel=[[JKSortModel alloc]init];
    
    sortModel.pro_name=@"数码设备";
    sortModel.pro_icon=@"";
    
    
    [cell setSortInfo:sortModel];
    
    return cell;
}





@end
