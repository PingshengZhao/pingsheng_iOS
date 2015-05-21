//
//  PSScrollView.m
//  LoopsSrollView
//
//  Created by pingsheng on 15/4/30.
//  Copyright (c) 2015年 pingsheng.zhao. All rights reserved.
//

#import "PSScrollView.h"
#import "PSCollectionViewCell.h"
#define KIdentifier @"cell"

@interface PSScrollView ()<UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *mainView;
@property (nonatomic, strong)NSArray * imagesGroup;
@property (nonatomic, strong)UIPageControl * pageControl;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)UICollectionViewDidSelectItemAtIndexPathForRow callBack;
@end

@implementation PSScrollView

+ (instancetype)psScrollViewWithFrame:(CGRect)frame imagesGroup:(NSArray *)imagesGroup completion:(UICollectionViewDidSelectItemAtIndexPathForRow)completion{
    PSScrollView * psScrollView = [[PSScrollView alloc] initWithFrame:frame];
    NSMutableArray * mutableArray = [NSMutableArray arrayWithArray:imagesGroup];
    [mutableArray insertObject:[imagesGroup lastObject] atIndex:0];
    [mutableArray addObject:[imagesGroup firstObject]];
    psScrollView.imagesGroup = [mutableArray copy];
    psScrollView.callBack = completion;
    [psScrollView setupMainView];
    [psScrollView setupPageControl];
    [psScrollView setupTimer];
    return psScrollView;
}

- (void)setupMainView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = self.frame.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor lightGrayColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[PSCollectionViewCell class] forCellWithReuseIdentifier:KIdentifier];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.contentOffset = CGPointMake(mainView.frame.size.width, 0);
    [self addSubview:mainView];
    _mainView = mainView;
}

- (void)setupPageControl {
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _mainView.frame.size.height - 20, _mainView.frame.size.width, 20)];
    _pageControl.numberOfPages = _imagesGroup.count - 2;
    _pageControl.backgroundColor = [UIColor blackColor];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.alpha = 0.5;
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.5];
    [self addSubview:_pageControl];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _mainView.frame = self.bounds;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imagesGroup.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PSCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:KIdentifier forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:_imagesGroup[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index;
    if (indexPath.row == 0 || indexPath.row == _imagesGroup.count - 2) {
        index = _imagesGroup.count - 2;
    }else if (indexPath.row == 1 || indexPath.row == _imagesGroup.count - 1) {
        index = 1;
    }else {
        index = indexPath.row;
    }
    _callBack(index);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int contentOffsetX = scrollView.contentOffset.x;
    if ((contentOffsetX / scrollView.frame.size.width) < 0 && contentOffsetX < scrollView.frame.size.width) {
        [scrollView setContentOffset:CGPointMake(_mainView.frame.size.width * (_imagesGroup.count - 2), 0) animated:NO];
    }else if ((contentOffsetX / scrollView.frame.size.width) > _imagesGroup.count - 1 && contentOffsetX > scrollView.frame.size.width * (_imagesGroup.count - 1)) {
        [scrollView setContentOffset:CGPointMake(_mainView.frame.size.width, 0) animated:NO];
    }
    
    if (contentOffsetX == 0) {
        _pageControl.currentPage = _imagesGroup.count - 3;
    }else if (contentOffsetX == scrollView.frame.size.width * (_imagesGroup.count - 1)) {
        _pageControl.currentPage = 0;
    }else {
        _pageControl.currentPage = (contentOffsetX / scrollView.frame.size.width) - 1;
    }

}

- (void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)automaticScroll {
    int currentIndex = _mainView.contentOffset.x / _mainView.frame.size.width;
    int targetIndex = currentIndex + 1;
    if (targetIndex == _imagesGroup.count) {
        targetIndex = 2;
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}




@end
