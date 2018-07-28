//
//  IntroPageView.m
//  724
//
//  Created by cuixi on 2018/7/24.
//  Copyright © 2018年 cuixi. All rights reserved.
//

#import "IntroPageView.h"
#import "YYImage.h"

#define K_Width [UIScreen mainScreen].bounds.size.width
#define K_Height [UIScreen mainScreen].bounds.size.height

@interface IntroPageView()<UIScrollViewDelegate>

@property (nonatomic,strong) NSArray<NSString *> *imageArray;
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@end

@implementation IntroPageView

+ (instancetype)pageWithFrame:(CGRect)frame images:(NSArray<NSString *> *)images{
    IntroPageView *introPageView = [[self alloc] initWithFrame:frame];//原来是self alloc
    introPageView.imageArray = images;
    return introPageView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addGesture];
    }
    return self;
}

- (void)addGesture{
    self.backgroundColor = [UIColor clearColor];
    //添加手势
    UITapGestureRecognizer *tapGestureRecongnizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureEndPageView)];
    tapGestureRecongnizer.numberOfTapsRequired = 1;
    [self.scrollView addGestureRecognizer:tapGestureRecongnizer];
}

- (void)gestureEndPageView{
    if (_pageControl.currentPage == self.imageArray.count -1) {
        [self removeFromSuperview];
    }
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        [self addSubview:scrollView];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (void)setImageArray:(NSArray<NSString *> *)imageArray{
    _imageArray = imageArray;
    [self loadPageView];
}

- (void)loadPageView{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.contentSize = CGSizeMake((self.imageArray.count + 1) * K_Width, K_Height);
    self.pageControl.numberOfPages = self.imageArray.count;
    
    [self.imageArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc]init];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(idx * K_Width, 0, K_Width, K_Height);
        
//        YYImage *image = [YYImage imageNamed:obj];
        UIImage *image = [UIImage imageNamed:obj];
        [imageView setImage:image];
        [self.scrollView addSubview:imageView];
    }];
    NSLog(@"");
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(K_Width/2, K_Height-60, 0, 40)];
        pageControl.backgroundColor = [UIColor whiteColor];
        pageControl.pageIndicatorTintColor = [UIColor blackColor];
        pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return _pageControl;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self addGesture];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    NSInteger page = (offset.x/(self.bounds.size.width)+0.5);//?
    self.pageControl.currentPage = page;
    self.pageControl.hidden = (page > self.imageArray.count - 1);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x >= (_imageArray.count)*K_Width) {
        [self removeFromSuperview];
    }
}

@end
