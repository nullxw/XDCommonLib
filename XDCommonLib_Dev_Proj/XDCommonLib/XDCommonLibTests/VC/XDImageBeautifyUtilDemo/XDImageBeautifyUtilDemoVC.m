//
//  XDImageBeautifyUtilDemoVC.m
//  XDCommonLib
//
//  Created by suxinde on 16/5/19.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import "XDImageBeautifyUtilDemoVC.h"

#import "ImageFilterItem.h"
#import "XDImageBeautifyUtil.h"
#import "XDColorMatrix.h"

#import "UIView+Toast.h"

static const NSInteger kEffectViewSize = 60;

@interface XDImageBeautifyUtilDemoVC ()
@property(retain,nonatomic)ImageFilterItem *item;
@end

@implementation XDImageBeautifyUtilDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Photo Edit"];
    
    self.image = [UIImage imageNamed:@"Test2.jpg"];
    self.icon.image=_image;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.view makeToastActivity];
    [self initObject];
    [self.view hideToastActivity];
}

- (void)initObject {
    
    [self effectImages];
    NSArray *imageName = [NSArray arrayWithObjects:
                          @"原始",
                          @"lomo",
                          @"黑白",
                          @"怀旧",
                          @"哥特",
                          @"淡雅",
                          @"酒红",
                          @"清宁",
                          @"浪漫",
                          @"光晕",
                          @"蓝调",
                          @"梦幻",
                          @"夜色", nil];
    
    _scrollVIew.contentSize=CGSizeMake((kEffectViewSize+10)*_effectImages.count+10,_scrollVIew.frame.size.height);
    
    
    for (int i =0; i<_effectImages.count; i++) {
        
        /**
         这里用if(!_item){},只会显示最后一个，item并不像一个cell会重用。
         */
        _item  = [[[NSBundle mainBundle] loadNibNamed:@"ImageFilterItem" owner:self options:nil] objectAtIndex:0];
        
        _item.frame=CGRectMake(i*(kEffectViewSize+10)+10, 25, _item.frame.size.width, _item.frame.size.height);
        _item.icon.image=_effectImages[i];
        _item.label_title.text=imageName[i];
        __weak typeof(self) weakSelf = self;
        _item.iconClick=^(){
            /**
             warn:
             Capturing 'self' strongly in this block is likely to lead to a retain cycle
             在代码块中使用对象的成员时(成员变量是属性strong，retain时):
             甲里引用乙，乙里引用甲，就会导致 “retain cycle” -- “形成怪圈”的错误
             解决的办法是 创建一个本地变量 指向 自己(self)
             */
            weakSelf.icon.image=weakSelf.effectImages[i];
        };
        [_scrollVIew addSubview:_item];
    }
}
//原始,lomo,黑白,怀旧,哥特,淡雅,酒红,清宁,浪漫,光晕,蓝调,梦幻,夜色
- (NSArray *)effectImages {
    if(!_effectImages) {
        
        _effectImages = @[self.image,
                          [XDImageBeautifyUtil imageWithImage:self.image withColorMatrix:colormatrix_lomo],
                          [XDImageBeautifyUtil imageWithImage:self.image withColorMatrix:colormatrix_heibai],
                          [XDImageBeautifyUtil imageWithImage:self.image withColorMatrix:colormatrix_huaijiu],
                          [XDImageBeautifyUtil imageWithImage:self.image withColorMatrix:colormatrix_gete],
                          [XDImageBeautifyUtil imageWithImage:self.image withColorMatrix:colormatrix_danya],
                          [XDImageBeautifyUtil imageWithImage:self.image withColorMatrix:colormatrix_jiuhong],
                          [XDImageBeautifyUtil imageWithImage:self.image withColorMatrix:colormatrix_qingning],
                          [XDImageBeautifyUtil imageWithImage:self.image withColorMatrix:colormatrix_langman],
                          [XDImageBeautifyUtil imageWithImage:self.image withColorMatrix:colormatrix_guangyun],
                          [XDImageBeautifyUtil imageWithImage:self.image withColorMatrix:colormatrix_landiao],
                          [XDImageBeautifyUtil imageWithImage:self.image withColorMatrix:colormatrix_menghuan],
                          [XDImageBeautifyUtil imageWithImage:self.image withColorMatrix:colormatrix_yese]];
    }
    return _effectImages;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
