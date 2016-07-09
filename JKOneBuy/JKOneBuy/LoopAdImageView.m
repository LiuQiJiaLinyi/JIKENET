//
//  LoopAdImageView.m
//  YZJOB-2
//
//  Created by 梁飞 on 15/9/25.
//  Copyright © 2015年 lfh. All rights reserved.
//

#import "LoopAdImageView.h"
#import "ADModel.h"

#import "UIImageView+WebCache.h"

@interface LoopAdImageView ()<UIScrollViewDelegate>

@property(strong,nonatomic)NSMutableArray * adModelArr;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)UIPageControl * pageControl;
@property(nonatomic,strong)NSTimer * timer;

@property(nonatomic,assign)CGFloat imgW;
@property(nonatomic,assign)CGFloat imgH;


@end

@implementation LoopAdImageView

+(instancetype)viewWithFrame:(CGRect)frame WithDataArray:(NSMutableArray *)dataArray
{

    LoopAdImageView * loopImage=[[LoopAdImageView alloc]initWithFrame:frame andDataArray:dataArray];
   
    return loopImage;


}
-(id)initWithFrame:(CGRect)frame andDataArray:(NSMutableArray *)dataArray
{
    

    self=[super initWithFrame:frame];
    
    if (self) {
        self.adModelArr=dataArray;
        self.imgW=frame.size.width;
        self.imgH=frame.size.height;
        
        if (self.adModelArr.count) {
            [self createUI];
        }
        
        
        
    }
    return self;
}
-(void)createUI
{

    self.scrollView=[[UIScrollView alloc]initWithFrame:self.bounds];
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.pagingEnabled=YES;
    self.scrollView.contentSize=CGSizeMake(self.imgW*self.adModelArr.count+2*self.imgW, self.imgH);
    [self addSubview:self.scrollView];
    
    self.scrollView.delegate=self;
    
    self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, self.imgH-10, self.imgW, 5)];
    self.pageControl.numberOfPages=self.adModelArr.count;
    self.pageControl.currentPage=0;
    self.pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
    //self.pageControl.pageIndicatorTintColor=[YZColor colorWithHexString:@"#dcdcdc"];
    [self addSubview:self.pageControl];
    
    [self.scrollView setContentOffset:CGPointMake(self.imgW, 0)];
    
    UIImageView * lastimage= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.imgW , self.imgH)];
    lastimage.userInteractionEnabled=YES;

   
    
    ADModel * adModelf=[ADModel mj_objectWithKeyValues:[self.adModelArr lastObject]];
    
   

    
    NSString *str_ad_image=[NSString stringWithFormat:@"%@",adModelf.imageurl];
    [lastimage sd_setImageWithURL:[NSURL URLWithString:str_ad_image] placeholderImage:[UIImage imageNamed:@"bannerNull"]];
    [self.scrollView addSubview:lastimage];
    
    for (int i=0; i<self.adModelArr.count; i++) {
        
        UIImageView * showImage=[[UIImageView alloc]initWithFrame:CGRectMake((i+1)*self.imgW, 0, self.imgW, self.imgH)];
        showImage.userInteractionEnabled=YES;
        
         ADModel * model=[ADModel mj_objectWithKeyValues:[self.adModelArr objectAtIndex:i]];
        [showImage sd_setImageWithURL:[NSURL URLWithString:model.imageurl] placeholderImage:[UIImage imageNamed:@"bannerNull"]];
        showImage.tag=i;
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAdIMage:)];
        [showImage addGestureRecognizer:tap];
        
        [self.scrollView addSubview:showImage];
        
    }
    
    UIImageView * firstImage=[[UIImageView alloc]initWithFrame:CGRectMake(self.imgW*self.adModelArr.count+self.imgW, 0, self.imgW, self.imgH)];
    
    ADModel * firstModel=[ADModel mj_objectWithKeyValues:[self.adModelArr objectAtIndex:0]];
    [firstImage sd_setImageWithURL:[NSURL URLWithString:firstModel.imageurl] placeholderImage:[UIImage imageNamed:@"bannerNull"]];
    [self.scrollView addSubview:firstImage];
    
    [self setUpTimer];
    

}

-(void)changeScroller
{
    
   
    CGPoint ptoff=self.scrollView.contentOffset;
    ptoff.x+=self.imgW;
    [self.scrollView setContentOffset:ptoff animated:YES];
    self.pageControl.currentPage=self.scrollView.contentOffset.x/self.imgW-1;
    
    if (ptoff.x==0 ) {
        ptoff.x=(self.adModelArr.count)*self.imgW;
        [self.scrollView setContentOffset:ptoff animated:NO];
        
    }
    else if(ptoff.x==(self.adModelArr.count+1)*self.imgW)
    {
       
        ptoff.x=self.imgW;
        [self.scrollView setContentOffset:ptoff animated:NO];
    }
    
   
    
}
-(void)tapAdIMage:(UITapGestureRecognizer*)tap
{
    ADModel * model=[self.adModelArr objectAtIndex:tap.view.tag];
    if (self.selectADModel!=nil) {
        self.selectADModel(model);
    }

}
-(void)setUpTimer
{

    self.timer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeScroller) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   
    CGPoint ptoff=self.scrollView.contentOffset;
    if (ptoff.x==0 ) {
        
        ptoff.x=(self.adModelArr.count)*self.imgW;
        
    }else if(ptoff.x==(self.adModelArr.count+1)*self.imgW)
    {
        
        ptoff.x=self.imgW;
    }
    
    [self.scrollView setContentOffset:ptoff animated:NO];
    
    self.pageControl.currentPage=self.scrollView.contentOffset.x/self.imgW-1;

}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    [self setUpTimer];

}

-(void)refreshData:(NSMutableArray *)dataArr
{
    self.adModelArr=dataArr;
    [self createUI];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
