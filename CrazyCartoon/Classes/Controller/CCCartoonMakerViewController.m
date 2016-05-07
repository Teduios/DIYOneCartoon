//
//  CCCartoonMakerViewController.m
//  CrazyCartoon
//
//  Created by Tarena on 16/4/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "CCCartoonMakerViewController.h"
#import "CCPictureList.h"
#import "CCSelectedImage.h"
#import "YYText.h"
#import "CCSelectedLabel.h"
#import "MBProgressHUD.h"
#import "CCPreviewViewController.h"



/** 屏幕宽 */
#define kScreenW [UIScreen mainScreen].bounds.size.width
/** itemtag */
#define kItemIconTag 100;

@interface CCCartoonMakerViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>
/** 计算属性 */
@property (nonatomic) CGFloat lineSpace;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
/** 图片列表 */
@property (nonatomic, strong) CCPictureList *pictureList;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, assign) NSInteger numberOfMainViewPicture;
@property (weak, nonatomic) IBOutlet UIView *writeWordView;
@property (weak, nonatomic) IBOutlet UITextField *writeWordTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *mainView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewBottomLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewHeightLayout;


- (IBAction)writeWordBtn:(id)sender;
- (IBAction)closeCollectionViewBtn:(id)sender;
- (IBAction)emotionBtn:(id)sender;
- (IBAction)addOnePiecePicture:(id)sender;
- (IBAction)minusOnePiecePicture:(id)sender;





@end

@implementation CCCartoonMakerViewController
-(NSInteger)numberOfMainViewPicture{
    if (!_numberOfMainViewPicture) {
        _numberOfMainViewPicture = 1;
    }
    return _numberOfMainViewPicture;
}
-(NSArray *)list{
    if (!_list) {
        _list = [CCPictureList getPictureList];
    }
    return _list;
}
- (CGFloat)lineSpace{
    
    return (kScreenW - 6*50)/6;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _pageControl.numberOfPages = (self.list.count+17)/18;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _collectionView) {
        _pageControl.currentPage = _collectionView.contentOffset.x / kScreenW + 0.5;
    }
}

#pragma mark - UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _collectionView) {
        UIImage *image = [UIImage new];
        image = self.list[indexPath.row];
        CCSelectedImage *imv = [[CCSelectedImage alloc]initWithImage:image];
        [self.mainView addSubview:imv];
    }
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if ([touches.anyObject.view isKindOfClass:[CCSelectedImage class]]) {
//        self.mainView.userInteractionEnabled = NO;
//    }
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == _collectionView) {
        return self.list.count;
    }
    return self.numberOfMainViewPicture;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _collectionView) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
        UIImage *image = self.list[indexPath.row];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
        imageV.image = image;
        [cell.contentView addSubview:imageV];
        return cell;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (collectionView == _collectionView) {
        return self.lineSpace;
    }
    return 2;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (collectionView == _collectionView) {
        return 0;
    }
    return 2;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (collectionView == _collectionView) {
        return UIEdgeInsetsMake(0, self.lineSpace/2, 0, self.lineSpace/2);
    }
    return UIEdgeInsetsMake(2, 0, 2, 0);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _collectionView) {
        CGSize size = CGSizeMake(50, 50);
        return size;
    }
    CGSize size = CGSizeMake(kScreenW-44, 150);
    return size;
}

- (IBAction)finishWriting:(id)sender {
    CCSelectedLabel *label = [[CCSelectedLabel alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
    label.text = self.writeWordTextField.text;
    [self.mainView addSubview:label];
    
    self.writeWordView.hidden = YES;
    self.writeWordTextField.text = @"";
}

- (IBAction)writeWordBtn:(id)sender {
    self.writeWordView.hidden = !self.writeWordView.hidden;
}


-(void)closeCollectionView{
    self.collectionViewBottomLayout.constant = -250;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}
-(void)openCollectionView{
    self.collectionViewBottomLayout.constant = 50;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}
- (IBAction)closeCollectionViewBtn:(id)sender {
    [self closeCollectionView];
}

- (IBAction)emotionBtn:(id)sender {
    if (self.collectionViewBottomLayout.constant == 50) {
        [self closeCollectionView];
    }else{
        [self openCollectionView];
    }
    
}

- (IBAction)addOnePiecePicture:(id)sender {
    if (self.numberOfMainViewPicture <8) {
        if (self.numberOfMainViewPicture <2) {
            self.mainViewHeightLayout.constant += 152;
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
                [self.view layoutIfNeeded];
            } completion:nil];
        }
        self.numberOfMainViewPicture += 1;
        [self.mainView reloadData];
    }else{
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"不能再多啦！";
        [hud hide:YES afterDelay:0.7];
    }
    
}

- (IBAction)minusOnePiecePicture:(id)sender {
    if (self.numberOfMainViewPicture > 1) {
        if (self.numberOfMainViewPicture ==2) {
            self.mainViewHeightLayout.constant -= 152;
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
                [self.view layoutIfNeeded];
            } completion:nil];
        }
        self.numberOfMainViewPicture -= 1;
        
        [self.mainView reloadData];
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"没格子你画啥？";
        [hud hide:YES afterDelay:0.7];
        
    }
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id destVc = segue.destinationViewController;
    
    CGSize size = CGSizeMake(self.mainView.frame.size.width, self.mainView.frame.size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [self.mainView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *ima = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    if ([destVc isKindOfClass:[CCPreviewViewController class]]) {
        CCPreviewViewController *pvc = destVc;
        pvc.image = ima;
        
    }
}

@end
