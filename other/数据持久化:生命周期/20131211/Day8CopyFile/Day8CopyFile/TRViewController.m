//
//  TRViewController.m
//  Day8CopyFile
//
//  Created by Tarena on 13-12-11.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property (nonatomic, strong)NSFileHandle *fileReader;
@property (nonatomic, strong)NSFileHandle *fileWriter;
@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSString *filePath = @"/Users/apple/Desktop/photo/美女/5-120621131622-50.jpg";
    self.fileReader = [NSFileHandle fileHandleForReadingAtPath:filePath];
    
    NSString *newFilePath = @"/Users/apple/Desktop/b.jpg";//复制文件的目标路径
    [[NSFileManager defaultManager] createFileAtPath:newFilePath contents:nil attributes:nil];//用FileManage创建文件
    
    //创建一个写数据的文件控制对象（注意：给的文件保存路径，一定要保证文件存在）
    self.fileWriter = [NSFileHandle fileHandleForWritingAtPath:newFilePath];
    
}

- (IBAction)clicked:(id)sender {
    
    //读取20k的数据（用同一个fileReader对象读取数据，fileReader会自动移动游标）
    NSData *subData = [_fileReader readDataOfLength:20*1024];
    
    [_fileWriter writeData:subData];//把数据写到文件（用同一个fileWriter对象写数据，也会自动移动游标）
    
    [_fileWriter synchronizeFile];//将数据及时写出去
    
//    //这种写data的方式会把原来的文件覆盖
//    [subData writeToFile:@"/Users/apple/Desktop/a.mp4" atomically:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
