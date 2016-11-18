//
//  ViewController.m
//  ShowImageDemo
//
//  Created by 孙云飞 on 16/11/18.
//  Copyright © 2016年 孙云飞. All rights reserved.
//

#import "ViewController.h"
#import "YFScrollView.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //data set
    self.dataArray = @[@"1.jpg",
                       @"2.jpg",
                       @"3.jpg",
                       @"4.jpg",
                       @"5.jpg"];
    //collectionView set
    UICollectionViewFlowLayout *f = [[UICollectionViewFlowLayout alloc]init];
    f.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) / 5, CGRectGetWidth(self.view.frame) / 5);
    f.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    f.minimumLineSpacing = 0;
    f.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.frame), 100) collectionViewLayout:f];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor grayColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
}

#pragma mark ---collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //add imageView to cell
    UIImageView *cellImage = [[UIImageView alloc]initWithFrame:cell.contentView.frame];
    cellImage.contentMode = UIViewContentModeScaleAspectFit;
    cellImage.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
    
    [cell.contentView addSubview:cellImage];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    //obtain imageView index
    YFScrollView *scr = [[YFScrollView alloc]initWithDataArray:self.dataArray andImageIndex:indexPath.row andFrame:self.view.frame];
    [scr addInKeyWindow];
}
@end
