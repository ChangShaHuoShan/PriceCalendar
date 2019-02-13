//
//  CalendarModel.h
//  PriceCalendar
//
//  Created by 袁灿 on 2019/2/13.
//  Copyright © 2019年 火山. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalendarModel : NSObject

@property (nonatomic, assign) NSInteger yearInt;
@property (nonatomic, assign) NSInteger monthInt;
@property (nonatomic, assign) NSInteger dateInt;
@property (nonatomic, assign) NSInteger addPrice;

//自己添加的属性
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL isToday;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, assign) BOOL isDefaultMoney;
@property (nonatomic, assign) BOOL isPastDate; //过去的时间

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSDate *date;


@end

NS_ASSUME_NONNULL_END
