//
//  YFScaleView.h
//  ShowImageDemo
//
//  Created by 孙云飞 on 16/11/18.
//  Copyright © 2016年 孙云飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YFScaleViewDelegate <NSObject>

- (void)hiddenViewTap;

@end
@interface YFScaleView : UIScrollView
@property(nonatomic,weak)id<YFScaleViewDelegate>hiddenDelegate;//delegate
//init method
- (instancetype)initWithImageName:(NSString *)imageName andFrame:(CGRect)rect;
@end
