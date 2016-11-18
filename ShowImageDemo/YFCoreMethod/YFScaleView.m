//
//  YFScaleView.m
//  ShowImageDemo
//
//  Created by 孙云飞 on 16/11/18.
//  Copyright © 2016年 孙云飞. All rights reserved.
//

#import "YFScaleView.h"
@interface YFScaleView()<UIScrollViewDelegate>
@property(nonatomic,strong)UIImageView *scaleImageView;
@end
@implementation YFScaleView
//init method
- (instancetype)initWithImageName:(NSString *)imageName andFrame:(CGRect)rect{

    self = [super initWithFrame:rect];
    if (self) {
        //set scrollView
        self.delegate = self;
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 2.0;
        self.contentSize = CGSizeMake(CGRectGetWidth(rect), CGRectGetHeight(rect));
        //imageView init
        self.scaleImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.scaleImageView.image = [UIImage imageNamed:imageName];
        self.scaleImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.scaleImageView];
        //add hiddenView tap
        UITapGestureRecognizer *hiddenTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(p_hiddenView)];
        [self addGestureRecognizer:hiddenTap];
        //add scale top
        UITapGestureRecognizer *scaleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(p_scaleMehtod)];
        scaleTap.numberOfTapsRequired = 2;
        [hiddenTap requireGestureRecognizerToFail:scaleTap];
        [self addGestureRecognizer:scaleTap];
    }
    return self;
}

#pragma mark ----top method
- (void)p_hiddenView{

    if ([self.hiddenDelegate respondsToSelector:@selector(hiddenViewTap)]) {
        [self.hiddenDelegate hiddenViewTap];
    }
}

- (void)p_scaleMehtod{

    if (self.zoomScale <= 1.0) {
        [self setZoomScale:2.0 animated:YES];
    }else{
    
        [self setZoomScale:1.0 animated:YES];
    }
}

#pragma mark ---scrooView delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

    return self.scaleImageView;
}
@end
