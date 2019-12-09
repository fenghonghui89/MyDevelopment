//
//  MD_XML_GDataXMLNode_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/30.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//
/*
 1.增加“libxml2.dylib”系统库库
 2.header search paths 添加 /user/inclued/libxml2
 3.-fno-objc-arc
 */


#import "MD_XML_GDataXMLNode_VC.h"
//#import "GDataXMLNode.h"
@interface MD_XML_GDataXMLNode_VC ()

@end

@implementation MD_XML_GDataXMLNode_VC

- (void)viewDidLoad {
  [super viewDidLoad];
  
}
//
//-(void)viewDidAppear:(BOOL)animated{
//
//  [super viewDidAppear:animated];
//
//  [self customInit];
//}
//
//-(void)customInit{
//
//  NSString *path = [[NSBundle mainBundle] pathForResource:@"books" ofType:@"xml"];
//  NSData *data = [NSData dataWithContentsOfFile:path];
//
//  NSError *error = nil;
//  GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
//  GDataXMLElement *root = document.rootElement;
//
//  NSArray *books = [root elementsForName:@"book"];
//  for (GDataXMLElement *book in books) {
//    GDataXMLElement *name = [[book elementsForName:@"name"] lastObject];
//    NSString *bookId = [[book attributeForName:@"id"] stringValue];
//    NSLog(@"name:%@ id:%@",name.stringValue,bookId);
//  }
//}

@end
