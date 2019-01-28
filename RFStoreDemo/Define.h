//
//  Define.h
//  BC_ConvenientTravel
//
//  Created by 便便出行 on 2018/11/5.
//  Copyright © 2018 Triple_L. All rights reserved.
//

#ifndef Define_h
#define Define_h


#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define NavBarHeight 44.0
#define TabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)//tabBar高
#define NavigationHieght (StatusBarHeight + NavBarHeight)//导航栏高





//、、打印
#ifdef DEBUG

#define NSLog(...) NSLog(__VA_ARGS__)//DEBUG

#define JKLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )

#else

# define NSLog(...) //release

#define JKLog(format, ...)

#endif




//偏好设置
#define KUserDefaults       [NSUserDefaults standardUserDefaults]
//通知
#define KNotificationCenter [NSNotificationCenter defaultCenter]
//版本
#define KAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define KAppName    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

//判断空
#define KStringIsEmpty(str)     ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

#define KArrayIsEmpty(array)    (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

#define KDictIsEmpty(dic)       (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys.count == 0)

#define KObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//弱引用
#define __weakCycle __weak typeof(self) weakSelf = self




//RGB的颜色设置
#define KRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define KRGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]
//16进制颜色宏定义
#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]
#define UIColorFromHexA(s,a) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:a]
//常用颜色
#define main_Color              UIColorFromHex(0xFC5A14)  //主题色
#define Background_color        UIColorFromHex(0xF0F0F0)  //背景颜色
#define DividingLine_color      UIColorFromHex(0xDCDCDC)  //分割线颜色
#define Black_text_color        UIColorFromHex(0x333333)  //字体颜色0x333333
#define Gray_text_color         UIColorFromHex(0x666666)  //字体颜色0x666666
#define LightGray_text_color    UIColorFromHex(0x999999)  //字体颜色0x666666


#define white_Color             [UIColor whiteColor]
#define black_Color             [UIColor blackColor]
#define red_Color               [UIColor redColor]
#define group_Color             [UIColor groupTableViewBackgroundColor]



//适配
#define KWidthScreen    [UIScreen mainScreen].bounds.size.width
#define KHeightScreen   [UIScreen mainScreen].bounds.size.height
#define KWindow         [[[UIApplication sharedApplication] delegate] window]


//以 iphone6为基准 自适应
#define HeightAdaption(designedPX)  (designedPX * KHeightScreen / 667.0)
#define WidthAdaption(designedPX)   (designedPX * KWidthScreen / 375.0)

//  iPhone X
#define Device_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//ios8 系统以上
#define IOSVersion8_or_Later (IOS_VERSION >= 8.0)
//获取手机系统版本
#define Device_VERSION [[UIDevice currentDevice] systemVersion]



//定义UIImage对象
#define ImageNamed(named) [UIImage imageNamed:named]
#define ImageOfFile(file) [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:file]]

//字体的大小
#define Font(float) [UIFont systemFontOfSize:float]
//字体的自适应大小
#define FontAdapt(float) [UIFont systemFontOfSize:WidthAdaption(float)]





//归档解档
#define CODING(self)\
\
-(void)encodeWithCoder:(NSCoder *)aCoder{\
unsigned int count;\
Ivar *list = class_copyIvarList([self class], &count);\
for (int i = 0; i<count; i++) {\
Ivar iv = list[i];\
const char *name = ivar_getName(iv);\
NSString *nameStr = [NSString stringWithUTF8String:name];\
id value = [self valueForKey:nameStr];\
[aCoder encodeObject:value forKey:nameStr];\
}\
free(list);\
NSLog(@"归档%@..",[self class]);\
\
}\
-(instancetype)initWithCoder:(NSCoder *)aDecoder{\
if (self == [super init]) {\
unsigned int count;\
Ivar *list = class_copyIvarList([self class], &count);\
for (int i = 0; i<count; i++) {\
Ivar iv = list[i];\
const char *name = ivar_getName(iv);\
NSString *nameStr = [NSString stringWithUTF8String:name];\
id value = [aDecoder decodeObjectForKey:nameStr];\
[self setValue:value forKey:nameStr];\
}\
free(list);\
}\
NSLog(@"解档%@..",[self class]);\
\
return self;\
}

//路径
#define PATH_DOCUMENT NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject

#endif /* Define_h */
