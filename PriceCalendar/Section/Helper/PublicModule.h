//
//  PublicModule.h
//  PriceCalendar
//
//  Created by 袁灿 on 2019/2/13.
//  Copyright © 2019年 火山. All rights reserved.
//

#ifndef PublicModule_h
#define PublicModule_h

//常用参数宏定义
#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT               [[UIScreen mainScreen] bounds].size.height

//色值角度宏定义
#define COLOR(r,g,b,a) ([UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)])
#define SHORTCOLOR(r) ([UIColor colorWithRed:(r)/255.0f green:(r)/255.0f blue:(r)/255.0f alpha:(1)])
#define RADIANS(x) (M_PI * x / 180.0)

//常用颜色宏定义
#define kColor_Black            SHORTCOLOR(0x33)
#define kColor_Gray             SHORTCOLOR(0x66)
#define kColor_LightGray        SHORTCOLOR(0x99)
#define kColor_Orange           COLOR(242,176,85,1)

#define kColor_Red              COLOR(255,0,0,1)
#define kColor_White            SHORTCOLOR(0xff)
#define kColor_Blue             COLOR(0x30,0x90,0xe6,1)
#define kColor_LightBlue        COLOR(3, 169, 246, 1)
#define kColor_LightRed         COLOR(251,132,134,1)
#define kColor_Transparent      COLOR(0,0,0,0.1)
#define kColor_ButtonClick      COLOR(214,214,214,1)

#define kColor_MainPageBlue     COLOR(0x0,0x6f,0xd2,1)
#define kColor_Green            COLOR(76,192,95,1)

#define kColor_NavBar           COLOR(244,245,247,1)
#define kColor_TabBar           COLOR(248,249,250,1)
#define kColor_Background       SHORTCOLOR(0xf5)
#define kColor_Line             SHORTCOLOR(0xdd)
#define kColor_MainPageLine     COLOR(0xe4,0xe4,0xe4,1)

#define kColor_WordGrayColor    SHORTCOLOR(102)
#define kColor_BorderLine       SHORTCOLOR(204)

//字体宏定义
#define FONT(size)      [UIFont systemFontOfSize:(size)]
#define FONTBOLD(size)  [UIFont boldSystemFontOfSize:(size)]
#define FONTPX(px)      [UIFont systemFontOfSize:(px/1.193)]
#define FONTBOLDPX(px)  [UIFont boldSystemFontOfSize:(px/1.193)]


//常用字体宏定义
#define kFont_Title     FONT(17)
#define kFont_Button    FONT(18)

#define kFont_Large     FONT(16)
#define kFont_Middle    FONT(14)
#define kFont_Small     FONT(12)


//常用参数宏定义
#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT               [[UIScreen mainScreen] bounds].size.height
#define SCREEN_HEAD                 64
#define SCREEN_HEIGHT_WITHOUTHEAD   SCREEN_HEIGHT-64
#define LINE_SIZE                   1/[[UIScreen mainScreen] scale]
#define LINE_SPACE                  5
#define PICKERVIEW_HEIGHT           256 //UIDatePicker、UIPickerView的高度

//字符串处理宏定义
#define NON(str) (str?str:@"")
#define STR_NUM(num) ([NSString stringWithFormat:@"%ld",(long)num])
#define STR_OBJ(obj) (obj?[NSString stringWithFormat:@"%@",obj]:nil)
#define isEmpty(str) (str.length == 0 || str == nil)
#define STR_MONEY(money) ([NSString stringWithFormat:@"￥%@",money])


#endif /* PublicModule_h */
