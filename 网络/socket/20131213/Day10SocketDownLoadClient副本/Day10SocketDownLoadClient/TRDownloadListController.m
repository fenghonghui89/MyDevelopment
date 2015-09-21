//
//  TRDownloadListController.m
//  Day10SocketDownLoadClient
//
//  Created by HanyFeng on 13-12-18.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRDownloadListController.h"

@interface TRDownloadListController ()
@property(nonatomic,strong)NSString* fileName;
@property(nonatomic,assign)int fileLength;
@property(nonatomic,strong)NSMutableData* fileData;
@end

@implementation TRDownloadListController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.downloadList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString* fileNameAndLength = self.downloadList[indexPath.row];
    NSArray* array = [fileNameAndLength componentsSeparatedByString:@"&&"];
    NSString* fileName = [array objectAtIndex:0];
    NSString* fileLength = [array objectAtIndex:1];
    
    cell.textLabel.text = fileName;
    cell.detailTextLabel.text = fileLength;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* fileNameAndLength = self.downloadList[indexPath.row];
    NSArray* array = [fileNameAndLength componentsSeparatedByString:@"&&"];
    NSString* fileName = [array objectAtIndex:0];
    NSString* headerString = [NSString stringWithFormat:@"downloadRequest&&%@&&",fileName];
    NSData* headerData = [headerString dataUsingEncoding:NSUTF8StringEncoding];
    self.clientSocket = [[AsyncSocket alloc] initWithDelegate:self];
    [self.clientSocket connectToHost:@"192.168.10.84" onPort:8000 error:nil];
    [self.clientSocket writeData:headerData withTimeout:-1 tag:0];
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSData* headerData = [data subdataWithRange:NSMakeRange(0, 100)];
    NSString *headerString = [[NSString alloc]initWithData:headerData encoding:NSUTF8StringEncoding];
    NSArray* array = [headerString componentsSeparatedByString:@"&&"];
    NSString* fileType = [array objectAtIndex:0];
    
    if ([headerString componentsSeparatedByString:@"&&"].count == 3 && [fileType isEqualToString: @"file"]) {
        self.fileName = [array objectAtIndex:1];
        self.fileLength = [(NSString*)[array objectAtIndex:2] intValue];
        self.fileData = [NSMutableData data];
        
        NSData* subFileData = [data subdataWithRange:NSMakeRange(100, data.length-100)];
        [self.fileData appendData:subFileData];
        if (self.fileData.length == self.fileLength) {
            NSString* filePath = [@"/Users/apple/Desktop" stringByAppendingPathComponent:self.fileName];
            [self.fileData writeToFile:filePath atomically:YES];
            NSLog(@"下载完成");
        }
        
    }else{
        [self.fileData appendData:data];
        if (self.fileData.length == self.fileLength) {
            NSString* filePath = [@"/Users/apple/Desktop" stringByAppendingPathComponent:self.fileName];
            [self.fileData writeToFile:filePath atomically:YES];
            NSLog(@"下载完成");
        }
    }
    
    [self.clientSocket readDataWithTimeout:-1 tag:0];

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
