//
//  APP-JI
//
//  Created by 黄鹏昊 on 2018/5/11.
//  Copyright © 2018年 黄鹏昊. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NotificationsMethods : NSObject

- (void)setupNotifications:(NSString *)question;
- (void)presentNotificationNow:(NSString *)question andHour:(NSString *)hour minute:(NSString *)minute;

@end
