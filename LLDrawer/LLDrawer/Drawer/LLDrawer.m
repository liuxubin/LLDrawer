//
//  LLDrawer.m
//  HaoYunWang
//
//  Created by 刘旭斌 on 2017/4/10.
//  Copyright © 2017年 kodbin. All rights reserved.
//

#import "LLDrawer.h"

@implementation LLDrawer

- (id)initWithFrame:(CGRect)frame itemsArr:(NSMutableArray *)itemsArr supView:(UIView *)supView block:(LLDrawerBlock)block{

    if (self = [super initWithFrame:frame]) {
        self.titlesList = itemsArr;
        self.supView = supView;
        self.block = block;
        [self defaultSettings];
    }
    return self;
}
- (void)setWithItemsArr:(NSMutableArray *)itemsArr supView:(UIView *)supView block:(LLDrawerBlock)block{
    self.titlesList = itemsArr;
    self.supView = supView;
    self.block = block;
    [self defaultSettings];

}

//默认设置
- (void)defaultSettings
{
    //按钮(底部全局)
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.borderColor = kBorderColor.CGColor;
    btn.layer.borderWidth = 0.5;
    btn.clipsToBounds = YES;
    btn.layer.masksToBounds = YES;
    btn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [btn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
//    WS(ws);
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.bottom.equalTo(ws);
//    }];
    
    //文字
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 0, self.frame.size.width-imgW - 5 - 2, self.frame.size.height)];
    titleLabel.font = [UIFont systemFontOfSize:11];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = kTextColor;
    [btn addSubview:titleLabel];
    
    //图标(右边)
    _arrow = [[UIImageView alloc]initWithFrame:CGRectMake(btn.frame.size.width - imgW - 10, (self.frame.size.height-imgH)/2.0, imgW, imgH)];
    _arrowImgName = @"down_dark";
    _arrow.image = [UIImage imageNamed:_arrowImgName];
    [btn addSubview:_arrow];
    
    //下来菜单(默认不展开)
    _isOpen = NO;
    _listTable = [[UITableView alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height, self.frame.size.width, 0) style:UITableViewStylePlain];
    _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listTable.delegate = self;
    _listTable.dataSource = self;
    _listTable.layer.borderWidth = 0.5;
    _listTable.layer.borderColor = kBorderColor.CGColor;
    [_supView addSubview:_listTable];
    titleLabel.text = [_titlesList objectAtIndex:_defaultIndex];
}
//重新frame
- (void)layoutSubviews{
    [super layoutSubviews];
    _listTable.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height, self.frame.size.width, 0);
    btn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
//刷新视图
- (void)reloadData
{
    [_listTable reloadData];
    titleLabel.text = [_titlesList objectAtIndex:_defaultIndex];
    btn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

//点击事件
- (void)tapAction
{
    if (_isOpen)
    {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = _listTable.frame;
            frame.size.height = 0;
            [_listTable setFrame:frame];
        } completion:^(BOOL finished) {
            [_listTable removeFromSuperview];
            _isOpen = NO;
            [UIView animateWithDuration:0.25 animations:^{
                _arrow.transform = CGAffineTransformRotate(_arrow.transform, DEGREES_TO_RADIANS(180));
            }];
        }];
    }else
    {
        [UIView animateWithDuration:0.25 animations:^{
            if (_titlesList.count > 0) {
                //重新重头
                [_listTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
            [_supView addSubview:_listTable];
            [_supView bringSubviewToFront:_listTable];
            CGRect frame = _listTable.frame;
            frame.size.height = _tableHeight > 0 ? _tableHeight:tableH;
            [_listTable setFrame:frame];
        } completion:^(BOOL finished) {
            
            NSLog(@"%@",NSStringFromCGRect(_listTable.frame));
            _isOpen = YES;
            [UIView animateWithDuration:0.25 animations:^{
                _arrow.transform = CGAffineTransformRotate(_arrow.transform, DEGREES_TO_RADIANS(180));
                
            }];
        }];
    }
}
#pragma mark -tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titlesList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellIndentifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, self.frame.size.width, self.frame.size.height)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:11.0];
        label.textColor = kTextColor;
        label.tag = 1000;
        [cell addSubview:label];
        
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
        line.backgroundColor = kBorderColor;
        [cell addSubview:line];
        
    }
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = [_titlesList objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    titleLabel.text = [_titlesList objectAtIndex:indexPath.row];
    _isOpen = YES;
    [self tapAction];
    
    //调用
    self.block(indexPath.row);
    
}

@end
