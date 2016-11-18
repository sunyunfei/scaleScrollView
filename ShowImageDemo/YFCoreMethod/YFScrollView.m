//
//  YFScrollView.m
//  ShowImageDemo
//
//  Created by 孙云飞 on 16/11/18.
//  Copyright © 2016年 孙云飞. All rights reserved.
//

#import "YFScrollView.h"
#import "YFScaleView.h"
static int k_tag = 101;
@interface YFScrollView()<UIScrollViewDelegate,YFScaleViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UILabel *indexLabel;//show index label
@property(nonatomic,assign)NSInteger index;//image index
@property(nonatomic,assign)NSInteger allCount;//all image count
@end
@implementation YFScrollView
- (instancetype)initWithDataArray:(NSArray *)dataArray
                    andImageIndex:(NSInteger)index
                         andFrame:(CGRect)rect{
    self = [super initWithFrame:rect];
    if (self) {
        self.allCount = dataArray.count;
        self.backgroundColor = [UIColor whiteColor];
        self.alpha = 0.0;
        //set scrollView
        [self p_loadScrollView:dataArray andIndex:index];
        //add indexLabel
        [self p_loadIndexLabel];
         self.index = index;
        //add scaleImage
        [self p_loadScaleImageArray:dataArray andIndex:index];
    }
    return self;
}
- (void)addInKeyWindow{

    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1.0;
    }];
}
#pragma mark ---- init UI
//set scrollView
- (void)p_loadScrollView:(NSArray *)dataArray andIndex:(NSInteger)index{

    //set scrollView
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * dataArray.count, CGRectGetHeight(self.frame));
    [self addSubview:self.scrollView];
}

//add scaleImage method
- (void)p_loadScaleImageArray:(NSArray *)dataArray andIndex:(NSInteger)index{
    
    for(int i = 0;i < dataArray.count;i ++){
    
        YFScaleView *scaleView = [[YFScaleView alloc]initWithImageName:dataArray[i] andFrame:CGRectMake(i * CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        scaleView.tag = i + k_tag;
        scaleView.hiddenDelegate = self;
        [self.scrollView addSubview:scaleView];
    }
    //offsetx in scrollView
    [self.scrollView setContentOffset:CGPointMake(index * CGRectGetWidth(self.frame), 0) animated:NO];
}

//add indexLabel
- (void)p_loadIndexLabel{
    self.indexLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 60, CGRectGetWidth(self.frame), 60)];
    self.indexLabel.backgroundColor =[UIColor greenColor];
    self.indexLabel.font = [UIFont systemFontOfSize:20 weight:20];
    self.indexLabel.textAlignment = NSTextAlignmentCenter;
    self.indexLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.indexLabel];
}

#pragma mark -----data deal
- (void)setIndex:(NSInteger)index{

    _index = index;
    self.indexLabel.text = [NSString stringWithFormat:@"%li / %li",(long)self.index + 1,(long)self.allCount];
}

#pragma mark ----scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSInteger offsetX = (self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame) / 2) / CGRectGetWidth(self.scrollView.frame);
    if (self.index != offsetX) {
        YFScaleView *scaleView = [self viewWithTag:k_tag + offsetX];
        if (scaleView.zoomScale != 1.0) {
            scaleView.zoomScale = 1.0;
        }
        
        self.index = offsetX;
    }
}

#pragma mark ---- delegate
- (void)hiddenViewTap{

    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}
@end
