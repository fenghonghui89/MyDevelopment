//
//  MD_NSXML_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/29.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_NSXML_VC.h"
#import "TRBook.h"

@interface MD_NSXML_VC ()<NSXMLParserDelegate>
@property (nonatomic, strong)TRBook *currentBook;
@property (nonatomic, copy)NSString *currentString;
@property (nonatomic, strong)NSMutableArray *books;
@end

@implementation MD_NSXML_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  
  [self customInit];
}
#pragma mark - < method > -
-(void)customInit{
  
  self.books = [NSMutableArray array];
  
  NSString *path = [[NSBundle mainBundle] pathForResource:@"books" ofType:@"xml"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  
  NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
  parser.delegate = self;
  [parser parse];
  
  for (TRBook *book in self.books) {
    NSLog(@"名称：%@ 作者：%@ 页数：%@ 价格：%@",book.name,book.author,book.page,book.price);
  }
}

#pragma mark - < callback > -

//attributeDict 标签属性 elementName标签名称
-(void)parser:(NSXMLParser *)parser didStartElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(nonnull NSDictionary<NSString *,NSString *> *)attributeDict{
  
  if ([elementName isEqualToString:@"book"]) {
    NSLog(@"attributeDict :%@",attributeDict);
    self.currentBook = [[TRBook alloc]init];
    [self.books addObject:self.currentBook];
  }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
  
  self.currentString = string;
}

-(void)parser:(NSXMLParser *)parser didEndElement:(nonnull NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
  
  if ([elementName isEqualToString:@"name"]) {
    self.currentBook.name = self.currentString;
  }else if ([elementName isEqualToString:@"author"]) {
    self.currentBook.author = self.currentString;
  }else if ([elementName isEqualToString:@"price"]) {
    self.currentBook.price = self.currentString;
  }else if ([elementName isEqualToString:@"page"]) {
    self.currentBook.page = self.currentString;
  }
}
@end
