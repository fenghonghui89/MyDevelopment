//
//  TRViewController.m
//  Day12ParseLrc
//
//  Created by Tarena on 13-12-17.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"
#import "TRUtils.h"
@interface TRViewController ()
@property (nonatomic, strong)NSMutableDictionary *lrcDic;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //歌词请求地址
	NSURL *url = [NSURL URLWithString:@"http://box.zhangmen.baidu.com/bdlrc/256/25635.lrc"];
    //请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //用同步传输发送请求并取得服务器回复给我的data
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:Nil error:Nil];
    //歌词中含有中文，解码要注意编码格式的选择（中文GB2312解码）
    NSString *lrcString = [[NSString alloc]initWithData:data encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    NSLog(@"---%@----",lrcString);

    //从歌词文件中提取出时间与歌词，组成的字典（字典是无序的，所以返回的歌词也是乱的）
    self.lrcDic = [TRUtils parseLrcByString:lrcString];
    
    //播放歌曲
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:@"/Users/hanyfeng/Desktop/怒放的生命.mp3"] error:Nil];
    [self.player play];
    
    //按照歌曲的播放自动更新歌词显示
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(updateTableView) userInfo:Nil repeats:YES];
}

//按照歌曲当前时间显示对应歌词
-(void)updateTableView{
    
    //定义一个变量为当前播放时间对应的行号
    int seletedRow = 0;
    
    //对字典中的所有key（时间）排序（字典是无序的集合）：把所有key提取到一个数组中，转为float类型进行比较，值少的升序，值大的降序
    NSArray *keys = [self.lrcDic.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 floatValue]<[obj2 floatValue]) {
            return NSOrderedAscending;
        }else return NSOrderedDescending;
    }];
    
    //每个key值和歌曲当前时间做比较，如果key值比当前时间大，则选择上一句（即该时间对应歌词的行号为key的下标-1），并退出循环
    for (int i=0;i<keys.count;i++) {
        NSNumber *key = keys[i];
        
        if ([key floatValue]>self.player.currentTime) {
            seletedRow = i-1;
            break;
        }
    }

    //协议方法：自动滚动到某一行
    [self.myTV selectRowAtIndexPath:[NSIndexPath indexPathForRow:seletedRow++ inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lrcDic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    //因为字典是无序的所以要排序：取出字典中的所有key(时间)，按照时间大小进行排序
    NSArray *keys = self.lrcDic.allKeys;
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 floatValue]< [obj2 floatValue]) {
            return NSOrderedAscending;
        }else return NSOrderedDescending;
    }];
    
    //取出该行对应的key，把key对应的歌词显示到cell
    NSNumber *key = keys[indexPath.row];
    cell.textLabel.text = [self.lrcDic objectForKey:key];
    
    //定义cell的样式
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor yellowColor];
    cell.backgroundColor = [UIColor blackColor];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];//文字居中
    cell.textLabel.highlightedTextColor = [UIColor redColor];//高亮状态下文字的颜色
    
    //cell被选中时，创建一个view做为背景view并改变背景颜色
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
}

//每一行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
