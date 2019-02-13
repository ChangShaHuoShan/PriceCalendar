//
//  CalendarView.m
//  PriceCalendar
//
//  Created by 袁灿 on 2019/2/13.
//  Copyright © 2019年 火山. All rights reserved.
//

#define kButtonNum 42

#import "CalendarView.h"
#import "PublicModule.h"
#import "NSDate+Helper.h"
#import "CalendarModel.h"

@interface CalendarView ()

@property (nonatomic, strong) UIView                        *titleView;
@property (nonatomic, strong) UIView                        *bgView;

@property (nonatomic, strong) UILabel                       *labTitle;
@property (nonatomic, strong) UIButton                      *btnPrevious;
@property (nonatomic, strong) UIButton                      *btnNext;

@property (nonatomic, strong) NSMutableArray                *listData;

@end

@implementation CalendarView
{
    NSMutableArray *arrButton;
    NSMutableArray *arrLab1; //日期
    NSMutableArray *arrLab2; //价格
    NSMutableArray *selectedItem; //选中的日期
    
    float labWidth;
    NSInteger currentMonth;
    NSInteger currentYear;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColor_White;
        [self initData];
        [self initCalendarUI];
        [self reloadData];
    }
    return self;
}

- (void)initCalendarUI
{
    [self titleView];
    [self bgView];
    [self labTitle];
    [self btnPrevious];
    [self btnNext];
    [self initWeekdayUI];
    [self initCalendarWeekUI];
}

- (void)initData
{
    currentMonth = [[NSDate date] monthIndex];
    currentYear = [[NSDate date] yearIndex];
    
    arrButton = [[NSMutableArray alloc] init];
    arrLab1 = [[NSMutableArray alloc] init];
    arrLab2 = [[NSMutableArray alloc] init];
    selectedItem = [[NSMutableArray alloc] init];
}

#pragma mark - Calendar UI

- (UIView *)titleView
{
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
        _titleView.backgroundColor = kColor_White;
        [self addSubview:_titleView];
    }
    return _titleView;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 60, SCREEN_WIDTH-20, self.frame.size.height-70)];
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
        [self addSubview:_bgView];
    }
    return _bgView;
}

- (UILabel *)labTitle
{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 30)];
        _labTitle.center = CGPointMake(self.frame.size.width/2, 25);
        _labTitle.textAlignment = NSTextAlignmentCenter;
        _labTitle.font = kFont_Large;
        _labTitle.textAlignment = NSTextAlignmentCenter;
        _labTitle.textColor = kColor_Black;
        [self addSubview:_labTitle];
    }
    return _labTitle;
}

- (UIButton *)btnPrevious
{
    if (!_btnPrevious) {
        _btnPrevious = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 50)];
        [_btnPrevious setImage:[UIImage imageNamed:@"icon_left"] forState:UIControlStateNormal];
        [_btnPrevious setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_btnPrevious.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_btnPrevious addTarget:self action:@selector(btnPreviousMonth:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnPrevious];
    }
    return _btnPrevious;
}

- (UIButton *)btnNext
{
    if (!_btnNext) {
        _btnNext= [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-50, 0, 40, 50)];
        [_btnNext setImage:[UIImage imageNamed:@"icon_right"] forState:UIControlStateNormal];
        [_btnNext setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_btnNext.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_btnNext addTarget:self action:@selector(btnNextMonth:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnNext];
    }
    return _btnNext;
}

- (void)initWeekdayUI
{
    NSArray *arrWeekDay = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
    labWidth = (_bgView.frame.size.width-70)/arrWeekDay.count;
    
    for (NSInteger i=0; i<arrWeekDay.count; i++) {
        UILabel *labWeekDay = [[UILabel alloc] initWithFrame:CGRectMake((labWidth+10)*i, 5, labWidth, 45)];
        labWeekDay.textAlignment = NSTextAlignmentCenter;
        labWeekDay.text = [arrWeekDay objectAtIndex:i];
        labWeekDay.font = kFont_Large;
        
        if (i==0 || i == arrWeekDay.count-1) {
            labWeekDay.textColor = [UIColor orangeColor];
        } else {
            labWeekDay.textColor = [UIColor blackColor];
        }
        [_bgView addSubview:labWeekDay];
    }
}

- (void)initCalendarWeekUI
{
    for (NSInteger i=0; i<kButtonNum; i++) {
        
        NSInteger x = i % 7;
        NSInteger y = i / 7;
        
        UIButton *btnDay = [[UIButton alloc] initWithFrame:CGRectMake(5+x*(labWidth+10), 50+y*(labWidth+10)+3, labWidth, labWidth)];
        [btnDay setTag:i];
        [btnDay.titleLabel setFont:kFont_Large];
        [btnDay addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnDay setBackgroundColor:[UIColor whiteColor]];
        
        btnDay.layer.cornerRadius = 3;
        btnDay.layer.masksToBounds = YES;
        
        [_bgView addSubview:btnDay];
       
        UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(5+x*(labWidth+10), 55+y*(labWidth+10)+3, labWidth, (labWidth-10)/2)];
        lab1.textColor = kColor_Black;
        lab1.font = kFont_Middle;
        lab1.textAlignment = NSTextAlignmentCenter;
        [_bgView addSubview:lab1];
        
        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(5+x*(labWidth+10), 55+(labWidth-10)/2+y*(labWidth+10)+3, labWidth, (labWidth-10)/2)];
        lab2.textColor = kColor_Black;
        lab2.font = kFont_Middle;
        lab2.textAlignment = NSTextAlignmentCenter;        
        [_bgView addSubview:lab2];
        
        [arrButton addObject:btnDay];
        [arrLab1 addObject:lab1];
        [arrLab2 addObject:lab2];
        
    }
}

#pragma mark - Calendar Data

//前一月
- (void)btnPreviousMonth:(UIButton *)btn
{
    currentMonth --;
    if (currentMonth < 1) {
        currentYear --;
        currentMonth = 12;
    }
    [self reloadData];
}

//后一月
- (void)btnNextMonth:(UIButton *)btn
{
    currentMonth ++;
    if (currentMonth > 12) {
        currentYear ++;
        currentMonth = 1;
    }
    [self reloadData];
}

//刷新一个月的数据
- (void)reloadData
{
    NSDate *currentDate = [NSDate getDateWithYear:currentYear month:currentMonth day:1];
    
    NSInteger firstDay = [NSDate getWeekdayOfDate:currentDate];
    NSInteger totalDays = [currentDate daysOfMonth];
    
    
    NSInteger year = currentYear;
    NSInteger month = currentMonth;
    NSInteger day = 0;
    
    //获取上个月的数据
    NSDate *preDate;
    if (currentMonth == 1) {
        preDate = [NSDate getDateWithYear:currentYear-1 month:12 day:1];
    } else {
        preDate = [NSDate getDateWithYear:currentYear month:currentMonth-1 day:1];
        
    }
    NSInteger preDays = [currentDate daysOfMonth];
    
    _labTitle.text = [currentDate stringWithFormat:@"yyyy-MM"];
    
    self.listData = [[NSMutableArray alloc] init];
    
    for (NSInteger i=0; i<kButtonNum; i++) {
        CalendarModel *model = [[CalendarModel alloc] init];
        model.index = i;
        
        if (i < firstDay) { //前一个月日期
            year = currentYear;
            month = currentMonth - 1;
            if (month < 1) {
                month = 12;
                year = currentYear - 1;
            }
            day = preDays+i-firstDay+1;
            model = [self calendarModel:model year:year month:month day:day price:100 isShow:NO];
            
        } else if (i < totalDays + firstDay) { //当前月日期
            year = currentYear;
            month = currentMonth;
            day = i-firstDay+1;
            model = [self calendarModel:model year:year month:month day:day price:100 isShow:YES];
            
        } else { // 下一个月日期
            year = currentYear;
            month = currentMonth + 1;
            if (month > 12) {
                month = 1;
                year = currentYear + 1;
            }
            model = [self calendarModel:model year:year month:month day:day price:100 isShow:NO];
        }
        
        for (NSInteger j=0; j<selectedItem.count; j++) {
            CalendarModel *selectModel = selectedItem[j];
            if (model.yearInt == selectModel.yearInt && model.monthInt == selectModel.monthInt && model.dateInt == selectModel.dateInt)
            {
                model.isSelected = YES;
                break;
            }
        }
        
        [self showOneDayOfCalendar:model];
        [self.listData addObject:model];
    }
}

//给CalendarModel赋值
- (CalendarModel *)calendarModel:(CalendarModel *)model
                            year:(NSInteger)year
                           month:(NSInteger)month
                             day:(NSInteger)day
                           price:(NSInteger)price
                          isShow:(BOOL)isShow
{
    model.yearInt = year;
    model.monthInt = month;
    model.dateInt = day;
    model.addPrice = 100;
    model.isShow = isShow;
    model.date = [NSDate getDateWithYear:year month:month day:day];
    model.isToday = [NSDate isSameDay:model.date date2:[NSDate date]];
    return model;
}

#pragma mark - Calendar Operate

//点击某一天
- (void)btnClick:(UIButton *)btn
{
    CalendarModel *model = _listData[btn.tag];
    if (model.isSelected) {
        model.isSelected = NO;
        [selectedItem removeObject:model];
    } else {
        model.isSelected = YES;
        [selectedItem addObject:model];
    }
    [self showOneDayOfCalendar:model];

}

#pragma mark - Calendar Display

//显示某一天的日期
- (void)showOneDayOfCalendar:(CalendarModel *)model
{
    UIButton *btn = [arrButton objectAtIndex:model.index];
    UILabel *lab1 = [arrLab1 objectAtIndex:model.index];
    UILabel *lab2 = [arrLab2 objectAtIndex:model.index];
    
    if (model.isShow) {
        if (!model.isPastDate) {
            if (model.isSelected) {
                btn.enabled = YES;
                lab1.textColor = model.isToday ? kColor_Red : kColor_White;
                lab2.textColor = kColor_White;
                lab1.text =STR_NUM(model.dateInt);
                lab2.text = STR_MONEY(STR_NUM(model.addPrice));
                btn.backgroundColor = kColor_Orange;
                
            } else {
                
                btn.enabled = YES;
                lab1.textColor = model.isToday ? kColor_Red : kColor_Black;
                lab2.textColor = kColor_Orange;
                lab1.text =STR_NUM(model.dateInt);
                lab2.text = STR_MONEY(STR_NUM(model.addPrice));
                btn.backgroundColor = kColor_White;
            }
            
        } else {
            btn.enabled = NO;
            lab1.text = STR_NUM(model.dateInt);
            lab2.text = STR_MONEY(STR_NUM(0));
            lab1.textColor = lab2.textColor = kColor_LightGray;
            btn.backgroundColor = kColor_White;
        }
    } else {
        btn.enabled = NO;
        lab1.textColor = lab2.textColor = btn.backgroundColor = kColor_White;
    }
}


@end
