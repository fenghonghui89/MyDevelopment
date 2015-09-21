//
//  XMLParser.m
//  NSXML
//
//  Created by hanyfeng on 14-6-23.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "XMLParser.h"

@implementation XMLParser

-(void)start
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Notes" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    //开始解析XML
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    parser.delegate = self;
    [parser parse];
    
    NSLog(@"解析完成...");
}

#pragma mark - NSXMLParserDelegate
//文档开始的时候触发
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.notes = [NSMutableArray new];
}

//文档出错的时候触发
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"%@",parseError);
}

//遇到一个开始标签时候触发
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    //把标签传给属性保存
    self.currentTagName = elementName;
    
    //如果标签为Note，则创建一个字典对象
    if ([self.currentTagName isEqualToString:@"Note"]) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        NSString *id = [attributeDict objectForKey:@"id"];
        [dict setObject:id forKey:@"id"];
        [self.notes addObject:dict];
    }
}

//遇到字符串时候触发
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //替换回车符和空格
	string =[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([string isEqualToString:@""]) {
        return;
    }
    
    NSMutableDictionary *dict = [self.notes lastObject];
    
	if ([_currentTagName isEqualToString:@"CDate"] && dict) {
        [dict setObject:string forKey:@"CDate"];
	}
    
    if ([_currentTagName isEqualToString:@"Content"] && dict) {
        [dict setObject:string forKey:@"Content"];
	}
    
    if ([_currentTagName isEqualToString:@"UserID"] && dict) {
        [dict setObject:string forKey:@"UserID"];
	}
}

//遇到结束标签时候出发
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
    self.currentTagName = nil;
}


//遇到文档结束时候触发
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.notes userInfo:nil];
    self.notes = nil;
}


@end
