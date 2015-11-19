//
//  ZListTextField.m
//  eSeller4iPad
//
//  Created by ZTaoTech on 13-9-27.
//  Copyright (c) 2013年 ZTaoTech. All rights reserved.
//

#import "ZListTextField.h"
#import "ZArchive.h"
//#import "ZPopUpSpecialItemView.h"
#import "ZDataCache.h"
#import "ZPopupUIItemDTO.h"
#import "ZShopDTO.h"
#import "ZMyShopsDTO.h"


@interface ZListTextField ()<UITableViewDelegate>
{
    NSMutableArray* _textArray;
    CGSize popSize;
    ZPopupUIItemDTO* selectedDTO;
    UIPopoverController* _popover;
    ZPopUpSpecialItemView* _popoverContent;
}

@end

@implementation ZListTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textArray = [[NSMutableArray alloc]init];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        //    _textField.tag = kNumber;
        self.returnKeyType =UIReturnKeyNext;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        
        self.clearsOnBeginEditing = YES;
        self.autoSelectLast = YES;
        
        [self addTarget:self
                 action:@selector(textFieldDidBegin:)
       forControlEvents:UIControlEventEditingDidBegin];
        [self addTarget:self
                 action:@selector(textFieldDidChange:)
       forControlEvents:UIControlEventEditingChanged];
        
        [self addTarget:self
                 action:@selector(textFieldDidEnd:)
       forControlEvents:UIControlEventEditingDidEnd];
    }
    return self;
}

-(void)dealloc
{
//    ZLogInfo(@"---Into----ZListTextField--dealloc-");
    [_textArray removeAllObjects];
    _textArray = nil;
    _popover = nil;
    _popoverContent = nil;
    _listDelegate = nil;
    _filterId = nil;
}

-(void)setPlaceHolder:(NSString*)placeHolder{
    self.placeholder = placeHolder;
//    [placeHolder release];
}

- (void)setupView{
    
}
- (void)setTxTag:(NSInteger)tag{
    self.tag = tag;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
- (void)textFieldDidEnd :(UITextField*)textField
{
//    ZLogInfo(@"textFieldDidEnd tag = %d, text = %@", textField.tag, textField.text);
    [_textArray removeAllObjects];
}
- (void)textChange:(NSString*)text
{
    if(_listType == 0)
    {
        return;
    }
    if(text.length == 0 && !_didBegin) {
        [_textArray removeAllObjects];
        [self popoverControllerDidDismissPopover:_popover];
        return;
    }
    [self getTextArray:text];
    [self popupView];
}

-(void)textFieldDidBegin:(UITextField*)textField
{
    if(_numPad) {
        UIView *numbPad = [[ZDataCache sharedInstance] psView];
        if (numbPad.hidden) {
            numbPad.hidden = NO;
            numbPad.userInteractionEnabled = YES;
        }
    }
    if (_didBegin) {
        [self textFieldDidChange:textField];
    }
}

- (void)textFieldDidChange :(UITextField*)textField
{
    ZLogInfo(@"textField.tag = %d, text = %@", (int)textField.tag, textField.text);
    NSString* origin = [NSString stringWithFormat:@"%@", textField.text];
    NSString* text = origin;
    
    if(text.length ==0 && !_didBegin) {
        [_textArray removeAllObjects];
        [self popoverControllerDidDismissPopover:_popover];
        return;
    }
    
    NSString* language = [textField.textInputMode  primaryLanguage];//[[UITextInputMode currentInputMode] primaryLanguage];
    if  ([language isEqualToString:@"zh-Hans"])
    {
        text = [origin stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    [self textChange:text];
}

- (void)getTextArray:(NSString*)text
{
    NSArray* array = nil;
    
    if (_textArray){
        [_textArray removeAllObjects];
//        [_textArray release];
//        _textArray = nil;
    }
    popSize = CGSizeMake(200,300);
    switch (_listType) {
//        case eListTypeKuanhao:
//            array = [[ZArchive instance] getGoodsDTO:text];
//            popSize = CGSizeMake(400,250);
//            break;
        case eListTypeItemKuanHaoAndItemFZ:
            array = [[ZArchive instance] getGoodsDTOWithItemFZ:text];
            popSize = CGSizeMake(400,250);
            break;
        case eListTypePointItem:
            array = [[ZArchive instance] getPointGoodsNameNumberUsed:text];
            popSize = CGSizeMake(400,250);
            break;
        case eListTypeKuanhaoUsed:
            array = [[ZArchive instance]getGoodsNameNumberUsed:text];
            popSize = CGSizeMake(480,250);
            break;
        case eListTypeItemName:
//            if([text length] >=4)
            {
                array = [[ZArchive instance] getGoodsNameDTOArray:text];
                popSize = CGSizeMake(400,250);
            }
            break;
        case eListTypeItemKuanHao:
//            if([text length] >=4)
            {
                array = [[ZArchive instance] getGoodsKuanHaoDTOArray:text];
                popSize = CGSizeMake(250,300);
            }
            break;
        case eListTypeSeller:
            array = [[ZArchive instance] getSalerNameArray:text];
            break;
        case eListTypeCustomerPhoneName:
//            if([text length] >=2)
            {
                array = [[ZArchive instance] getCustomerPhoneNameArray:text];
                popSize = CGSizeMake(250,250);
            }
            break;
        case eListTypeCustomerPhone:
            array = [[ZArchive instance] getCustomerPhoneArray:text];
            break;
        case eListTypeCategory:
            array = [[ZArchive instance] getItemCatEnabled:text];
            break;
        case eListTypeExpense:
            array = [[ZArchive instance] getItemExpenseEnabled:text];
            break;
        case eListTypeCustomer:
            array = [[ZArchive instance] getCustomerNameArray:text];
            break;
        case eListTypeManufacture:
            array = [[ZArchive instance] getSupplierNameArray:text];
            break;
        case eListTypeColor:
            if(_filterId) {
                array = [[ZArchive instance] getGoodsColorArray:_filterId];
            } else {
                array = [[ZArchive instance] getItemColorEnabled];
            }
            break;
        case eListTypeOrderMemo:
            array = [[ZArchive instance] getItemOrderMemoEnabled];
            popSize = CGSizeMake(100,150);
            break;
        case eListTypeDiscount:
            array = [[ZArchive instance] getItemDiscountEnabled];
            break;
        case eListTypeSize:
            array = [[ZArchive instance] getItemSizeEnabled];
            break;
        case eListTypeBrand:
            array = [[ZArchive instance] getItemBrandEnabled];
            break;
        case eListTypeSeason:
            array = [[ZArchive instance] getItemSeason];
            popSize = CGSizeMake(150,200);
            break;
        case eListTypeKuaiDi:
             array = [[ZArchive instance] getMyKuaiDi];
            break;
        case eListTypeItemCGType:
            array = [self getItemCGTypes];
            popSize = CGSizeMake(150,200);
            break;
        case eListTypeItemIOShops:
            array = [[ZArchive instance] getOthershops];
            break;
        case eListTypeShop:
            array = [self getShopTypes];
            popSize = CGSizeMake(200,200);
            break;
        case eListTypeMyShops:
            array = [self getMyShops];
            popSize = CGSizeMake(200,200);
            break;
        case eListTypeJobTitle:
            array = [[NSArray alloc]initWithObjects:@"经理",@"销售员",@"采购员", nil];
            break;
        default:
            break;
    }
    
    [_textArray addObjectsFromArray:array];
    ZLogInfo(@"---textArray count---%lu", (unsigned long)[_textArray count]);
}
-(void)popupView
{
    //    _popoverContent.oceanaViewController = self;
    
    
    
//    if(_popoverContent == nil) {
//        _popoverContent = [[ZPopUpSpecialItemView alloc]initWithSize:popSize];
//        _popover = [[UIPopoverController alloc] initWithContentViewController:_popoverContent];
//        
//        _popoverContent.preferredContentSize=_popoverContent.view.bounds.size;
//        _popoverContent.popController = _popover;
//    }
    if([ZDataCache sharedInstance].psView != nil){
        NSArray * psviews = [[NSArray alloc]initWithObjects:[ZDataCache sharedInstance].psView, nil];
        _popover.passthroughViews = psviews;
    }
    
    if([_textArray count] == 0 ) {//&& !_didBegin
        //没有找到数据，隐藏界面。
        [self popoverControllerDidDismissPopover:_popover];
        return;
    }
    [_popover setPopoverContentSize:popSize];
//    [_popoverContent initAddButton:popSize];
//    _popoverContent.currentListView = self;
//    _popoverContent.myArray = _textArray;
//    [_popoverContent refreshTable];
    [_popover presentPopoverFromRect:self.frame
                             inView:self.superview//相对于整个view的位置
           permittedArrowDirections:UIPopoverArrowDirectionAny
                           animated:YES];
}
- (void)popoverControllerDidDismissPopover:(UIPopoverController*)popoverController{
    if (_popover) {
        [_popover dismissPopoverAnimated:YES];
        _popover=nil;
        if (_popoverContent != nil) {
            _popoverContent = nil;
        }
    }
}

-(void)updateDTO:(ZPopupUIItemDTO*) dto {
    [_textArray removeAllObjects];
    self.text = dto.displayString;
    selectedDTO = dto;
    if(!_focusAfterSelected) {
        [self resignFirstResponder];
    }
    //没有仔细的设计，暂时这么解
    if(_listDelegate)
    {
        [_listDelegate setIdDTO:self];
    }
    [self popoverControllerDidDismissPopover:nil];
//    _popoverContent = nil;
//    if (_cellView) {
//        [_cellView setIdDTO:self];
//    } else {
//        if([self.delegate respondsToSelector:(@selector(setIdDTO:))])
//        {
//            [self.delegate performSelector:@selector(setIdDTO:) withObject:self];
//        }
//    }
}

-(ZPopupUIItemDTO*)getSelectedDTO {
    if([self.text length] > 0) {
        return selectedDTO;
    }
    return nil;
}
-(void)setSelectedDTO:(ZPopupUIItemDTO*)dto {
    selectedDTO = dto;
}

-(void)clearData
{
    selectedDTO = nil;
}

// 2 返货， 3， 调出， 4， 调入
-(NSArray*)getItemCGTypes
{
//    ZPopupUIItemDTO* dto0 = [[ZPopupUIItemDTO alloc]init];
//    dto0.itemId = 0;
//    dto0.displayString=@"进货";
//    
//    ZPopupUIItemDTO* dto1 = [[ZPopupUIItemDTO alloc]init];
//    dto1.itemId = 2;
//    dto1.displayString=@"返货";
    
    ZPopupUIItemDTO* dto2 = [[ZPopupUIItemDTO alloc]init];
    dto2.itemId = [NSNumber numberWithInt:3];
    dto2.displayString=@"调出";

    ZPopupUIItemDTO* dto3 = [[ZPopupUIItemDTO alloc]init];
    dto3.itemId = [NSNumber numberWithInt:4];
    dto3.displayString=@"调入";
    
//    ZPopupUIItemDTO* dto4 = [[ZPopupUIItemDTO alloc]init];
//    dto4.itemId = 5;
//    dto4.displayString=@"货品遗失";

    return [[NSArray alloc]initWithObjects:dto2,dto3, nil];
}

//店铺类型选择 服装批发零售， 其他
-(NSArray*)getShopTypes
{
    ZPopupUIItemDTO* dto2 = [[ZPopupUIItemDTO alloc]init];
    dto2.itemId = [NSNumber numberWithInt:100];
    dto2.displayString=@"服装批发零售";
    
    ZPopupUIItemDTO* dto3 = [[ZPopupUIItemDTO alloc]init];
    dto3.itemId = [NSNumber numberWithInt:5000];
    dto3.displayString=@"其他";
    
    return [[NSArray alloc]initWithObjects:dto2,dto3, nil];
}

-(NSArray*)getMyShops
{
    NSMutableArray* myShops = [[NSMutableArray alloc]init];
    if([[ZDataCache sharedInstance] myShopsDto]) {
        ZMyShopsDTO* myShopsDTO = [[ZDataCache sharedInstance] myShopsDto];
        for(ZShopDTO* shop in myShopsDTO.ownShops) {
            ZPopupUIItemDTO* dto3 = [[ZPopupUIItemDTO alloc]init];
            dto3.itemId = shop.shopId;
            dto3.displayString= shop.shopName;
            [myShops addObject:dto3];
        }
    }
    return myShops;
}

@end
