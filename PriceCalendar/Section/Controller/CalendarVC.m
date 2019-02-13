//
//  CalendarVC.m
//  PriceCalendar
//
//  Created by 袁灿 on 2019/2/13.
//  Copyright © 2019年 火山. All rights reserved.
//

#import "CalendarVC.h"
#import "CalendarView.h"
#import "PublicModule.h"


@interface CalendarVC ()

@property (nonatomic, strong) CalendarView *calendarView;

@end

@implementation CalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kColor_White;
    self.title = @"价格日历";
    
    float labWidth = (SCREEN_WIDTH-70)/7;
    
    _calendarView = [[CalendarView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, (labWidth+10)*6+60+50)];
    [self.view addSubview:_calendarView];
}


@end
