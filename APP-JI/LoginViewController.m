//
//  LoginViewController.m
//  APP-JI
//
//  Created by 黄鹏昊 on 2018/5/11.
//  Copyright © 2018年 黄鹏昊. All rights reserved.
//

#import "LoginViewController.h"
#import "ListTableViewController.h"
#import "FMDB.h"

@interface LoginViewController ()
@property(nonatomic, readwrite, assign) BOOL prefersLargeTitles;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];

    //设置更好看的导航栏
      if (@available(iOS 11.0, *)) {
        [[UINavigationBar appearance] setPrefersLargeTitles:true];
      }
    
    //获取当前日期
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日"];
    NSString *nowDay = [dateFormatter stringFromDate:currentDate];
    NSLog(@"当前日期:%@",nowDay);
    
    // 建立资料库
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"JIDatabase.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return ;
    }else
        NSLog(@"db opened");
    
    //建立table
    if (![db tableExists:@"LoginTime"]) {
        
        [db executeUpdate:@"CREATE TABLE LoginTime (Day text, Value text)"];
        NSLog(@"Create table LoginTime succeed!");
    }
    //建立table
    if (![db tableExists:@"DataList"]) {
        
        [db executeUpdate:@"CREATE TABLE DataList (Question text, Type text, AnswerT text)"];
        NSLog(@"Creat table DataList succeed!");
    }
    //建立table
    if (![db tableExists:@"LogList"]) {
        
        [db executeUpdate:@"CREATE TABLE LogList (Question text, Time text, Answer text)"];
        NSLog(@"Creat table LogList succeed!");
    }

    
    //找地址
    NSString *today = [db stringForQuery:@"SELECT Value FROM LoginTime WHERE Day = ?",@"Day"];
    //NSString *today = @"2016年05月01日";
    NSLog(@"%@",today);
    
    NSMutableArray *arr = [NSMutableArray array];
    
    if (today) {
        if ([today isEqualToString:nowDay]) {
        }else{
            //更新
            [db executeUpdate:@"UPDATE LoginTime SET Value = ? WHERE Day = ?",nowDay,@"Day"];
            
            
            //删除
            FMResultSet *rs = [db executeQuery:@"select * from DataList;"];
            
            while ([rs next]) {
                
                NSString *question = [rs stringForColumn:@"Question"];
                NSString *type = [rs stringForColumn:@"Type"];
                
                //删除
                [db executeUpdate:@"DELETE FROM DataList WHERE Question = ?",question];
                
                NSDictionary *dict = [[NSDictionary alloc]init];
                dict = [NSDictionary dictionaryWithObjectsAndKeys:question,@"question" ,type,@"type",nil];
                
                [arr addObject:dict];
            }
            
            [rs close];

            for (NSDictionary *dict in arr)
            {
                NSString *question = [NSString stringWithString:[dict objectForKey:@"question"]];
                NSString *type = [NSString stringWithString:[dict objectForKey:@"type"]];
                
                //写入
                [db executeUpdate:@"INSERT INTO DataList (Question, Type) VALUES (?,?)",question, type];
            }
        }
        
    }else{
        //写入
        [db executeUpdate:@"INSERT INTO LoginTime (Day, Value) VALUES (?,?)",@"Day", nowDay];
    }
    [db close];
    
    ListTableViewController *listTVC = [[ListTableViewController alloc]init];
    [self.navigationController pushViewController:listTVC animated:NO];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
