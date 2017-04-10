//
//  LLDrawer.h
//  HaoYunWang
//
//  Created by 刘旭斌 on 2017/4/10.
//  Copyright © 2017年 kodbin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define imgW 10//图片宽
#define imgH 10//图片高
#define tableH 130//下拉视图高度
#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)//角度
#define kBorderColor [UIColor colorWithRed:219/255.0 green:217/255.0 blue:216/255.0 alpha:1]//边框颜色
#define kTextColor   [UIColor darkGrayColor]//字体颜色

typedef void(^LLDrawerBlock)(NSInteger);

@interface LLDrawer : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *btn;//按钮
    UILabel *titleLabel;//文字label
    BOOL _isOpen;
}
@property (nonatomic,assign) BOOL isOpen;//是否展开
@property (nonatomic,strong) UITableView *listTable;//下拉视图
@property (nonatomic,strong) NSMutableArray *titlesList;//内容数组
@property (nonatomic,assign) NSInteger defaultIndex;//选中的下标
@property (nonatomic,assign) CGFloat tableHeight;//tableview的高度,没有设置则默认130
@property (nonatomic,strong) UIImageView *arrow;//右图
@property (nonatomic,copy) NSString *arrowImgName;//箭头图片名
@property (nonatomic,strong) UIView *supView;//下拉视图的父视图
@property (nonatomic,copy)LLDrawerBlock block;

//init
- (id)initWithFrame:(CGRect)frame itemsArr:(NSMutableArray *)itemsArr supView:(UIView *)supView block:(LLDrawerBlock)block;
//set(xib)
- (void)setWithItemsArr:(NSMutableArray *)itemsArr supView:(UIView *)supView block:(LLDrawerBlock)block;







@end
