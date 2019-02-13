//
//  NSDate+Helper.h
//  PriceCalendar
//
//  Created by 袁灿 on 2019/2/13.
//  Copyright © 2019年 火山. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Helper)

- (NSString *)stringWithFormat:(NSString *)format;

- (NSInteger)yearIndex;

- (NSInteger)monthIndex;

+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;

//获取一个月有多少天
- (NSInteger)daysOfMonth;

//计算某个日期对应的星期
+ (NSInteger)getWeekdayOfDate:(NSDate *)date;

//将世界时间转化为中国区时间
- (NSDate *)worldTimeToChinaTime:(NSDate *)date;

//传入年月日,返回对应的NSDate
+ (NSDate *)getDateWithYear:(NSInteger)year month:(NSUInteger)month day:(NSInteger)day;

@end

NS_ASSUME_NONNULL_END
