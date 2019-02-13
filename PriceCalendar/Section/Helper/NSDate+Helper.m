//
//  NSDate+Helper.m
//  PriceCalendar
//
//  Created by 袁灿 on 2019/2/13.
//  Copyright © 2019年 火山. All rights reserved.
//

#import "NSDate+Helper.h"

@implementation NSDate (Helper)

- (NSString *)stringWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:self];
}

- (NSInteger)yearIndex
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:self];
    return components.year;
}

- (NSInteger)monthIndex
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:self];
    return components.month;
}

//判断两个日期是否为同一天
+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day] == [comp2 day] && [comp1 month] == [comp2 month] && [comp1 year] == [comp2 year];
}

//获取一个月有多少天
- (NSInteger)daysOfMonth
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSRange range = [calender rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return range.length;
}

//计算某个日期对应的星期
+ (NSInteger)getWeekdayOfDate:(NSDate *)date
{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [greCalendar components:NSCalendarUnitWeekday fromDate:date];
    return components.weekday - 1; //从星期日开始，也就是星期天是1 星期一是2 ……星期六是7
}

+ (NSDate *)getDateWithYear:(NSInteger)year month:(NSUInteger)month day:(NSInteger)day
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:day];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *mDate = [calender dateFromComponents:comps];
    NSDate *newDate = [[NSDate alloc] worldTimeToChinaTime:mDate];
    return newDate;
}

//将世界时间转化为中国区时间
- (NSDate *)worldTimeToChinaTime:(NSDate *)date
{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}

@end
