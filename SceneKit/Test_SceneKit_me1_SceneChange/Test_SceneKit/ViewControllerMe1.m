//
//  ViewControllerMe1
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import "ViewControllerMe1.h"
#import <SceneKit/SceneKit.h>
#import "XTJRootDefine.h"
#import "SSZipArchive.h"
#import "XTJCoreNetworkManager.h"
@interface ViewControllerMe1 ()
<
SCNSceneRendererDelegate,SCNSceneExportDelegate,
SSZipArchiveDelegate
>
@property(nonatomic,strong)SCNView *scnView;
@end

@implementation ViewControllerMe1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *doucumentsPath = [XTJTool doucumentsPath];
    NSLog(@"doucumentsPath path...%@",doucumentsPath);
}

#pragma mark - < action >
- (IBAction)tap:(id)sender {
    
    [self downloadFile2];
}

- (IBAction)tap1:(id)sender {
    
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentDirectory lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"art-o"];
    
    [self showLog:filePath];
}

- (IBAction)tap2:(id)sender {
    
    [self setupScnview];
}

- (IBAction)tap3:(id)sender {
    [self saveFile];
}

#pragma mark - < method >
-(void)showLog:(NSString *)path{

    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSError *error = nil;
    NSArray *files = [fm contentsOfDirectoryAtPath:path error:&error];
    if (error) {
        NSLog(@"error..%@",error.localizedDescription);
    }else{
        for (NSString *fileName in files) {
            NSLog(@"file name..%@",fileName);
        }
    }

}


-(void)setupScnview{
    
    /*
     加载本地模型：
     项目文件夹/art.scnassets内模型
     项目文件夹/dae 但如果模型没有优化，如果cameraNode没有设置pointOfView则视角会错误
     项目文件夹/xxx.bundle内模型 必须是经过xcode优化过的模型 然后用SCNSceneSource读取
     
     加载网上模型：
     通过SCNScene读取下载的模型
     把下载的文件移动到main bundle 只有模拟器成功
     通过SCNSceneSource读取下载的模型 测试通过
     
     最后才scnView.scene = scene;，则视角能最大限度保证正常，因为此时pointOfView必定有值
     */
    
    //读取1 项目文件夹/art.scnassets内模型
//    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/my3dmodel1/file.dae"];
    
    //读取2 项目文件夹/dae 但如果模型没有优化，如果cameraNode没有设置pointOfView则视角会错误
//    SCNScene *scene = [SCNScene sceneNamed:@"untitled.dae"];
    
    //读取3 项目文件夹/xxx.bundle内模型 必须是经过xcode优化过的模型 然后用SCNSceneSource读取
    SCNScene *scene = [SCNScene scene];

    //scnview
    SCNView *scnView = [[SCNView alloc] initWithFrame:self.view.bounds];
    scnView.center = self.view.center;
    scnView.backgroundColor = [UIColor blackColor];
    scnView.allowsCameraControl = YES;
    scnView.antialiasingMode = SCNAntialiasingModeMultisampling4X;//开启抗锯齿
    scnView.showsStatistics = YES;
    scnView.preferredFramesPerSecond = 60;//帧率
    [self.view addSubview:scnView];
    [self.view sendSubviewToBack:scnView];
    self.scnView = scnView;
    
    scnView.scene = scene;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"XTJMaterial" ofType:@"bundle"];
    filePath = [filePath stringByAppendingPathComponent:@"3d/my3dmodel1/file.dae"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSLog(@"文件存在");
    }else{
        NSLog(@"文件不存在");
    }
    NSURL *url = [NSURL fileURLWithPath:filePath];
    SCNSceneSource *sceneSource = [SCNSceneSource sceneSourceWithURL:url options:nil];
    SCNNode *modelNode = [sceneSource entryWithIdentifier:@"SubDragonLE_Shape" withClass:[SCNNode class]];
    [scene.rootNode addChildNode:modelNode];
    
    //读取4 通过SCNScene读取下载的模型
//    NSURL *url = [self downloadFilePath2];
//    NSError *error = nil;
//    SCNScene *scene = [SCNScene sceneWithURL:url options:nil error:&error];
//    if (error) {
//        NSLog(@"load error...%@",error.localizedDescription);
//    }else{
//        NSLog(@"load success..");
//    }
    
    //读取5 把下载的文件移动到main bundle 只有模拟器成功
//    SCNScene *scene = [SCNScene scene];
//    NSURL *url = [self downloadFilePath1];
//    SCNSceneSource *sceneSource = [SCNSceneSource sceneSourceWithURL:url options:nil];
//    SCNNode *modelNode = [sceneSource entryWithIdentifier:@"SubDragonLE_Shape" withClass:[SCNNode class]];
//    [scene.rootNode addChildNode:modelNode];

    //读取6 通过SCNSceneSource读取下载的模型 测试通过
//    SCNScene *scene = [SCNScene scene];
//    NSURL *url = [self downloadFilePath2];
//    SCNSceneSource *sceneSource = [SCNSceneSource sceneSourceWithURL:url options:nil];
//    SCNNode *modelNode = [sceneSource entryWithIdentifier:@"SubDragonLE_Shape" withClass:[SCNNode class]];
//    [scene.rootNode addChildNode:modelNode];
    
    //camera
    SCNCamera *camera = [SCNCamera camera];
    camera.automaticallyAdjustsZRange = YES;
    
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 10, 50);
    [scene.rootNode addChildNode:cameraNode];
    
    //light
    SCNLight *ambientlight = [SCNLight light];
    ambientlight.type = SCNLightTypeAmbient;
    ambientlight.color = [UIColor grayColor];
    SCNNode *ambientlightNode = [SCNNode node];
    ambientlightNode.light = ambientlight;
    [scene.rootNode addChildNode:ambientlightNode];
    
    //floor
    SCNFloor *floor = [SCNFloor floor];
    floor.firstMaterial.diffuse.contents = ImageFile(@"image/素材1");
    floor.width = 1000;
    floor.length = 1000;
    
    SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
    floorNode.position = SCNVector3Make(0, 0, 0);
    floorNode.physicsBody = [SCNPhysicsBody staticBody];//静态身体
    [scene.rootNode addChildNode:floorNode];
    
    //box
//    SCNBox *box = [SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];
//    box.firstMaterial.diffuse.contents = ImageFile(@"image/婚庆布料");
//    SCNNode *boxNode = [SCNNode node];
//    boxNode.geometry = box;
//    boxNode.position = SCNVector3Make(0, 5, 0);
//    boxNode.physicsBody = [SCNPhysicsBody dynamicBody];
//    [scene.rootNode addChildNode:boxNode];
    
}

#pragma mark - < 上传 >
//进度：保存成scn文件

//模拟保存
-(void)saveFile{
    
    //保存目录
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentDirectory lastObject];
    NSString *path = [documentPath stringByAppendingPathComponent:@"SaveModels"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        NSLog(@"有保存目录...");
    }else{
        NSLog(@"无保存目录，创建...");
        NSError *error = nil;
        [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"创建保存目录失败..%@",error.localizedDescription);
        }else{
            NSLog(@"创建保存目录成功...%@",path);
        }
    }
    
    //保存文件
    NSString *filePath = [path stringByAppendingPathComponent:@"file_save.scn"];//注意必须保存成.scn文件
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];//This URL must use the file scheme.
    
    XTJBlockWeak(self);
    [_scnView.scene writeToURL:fileURL options:nil delegate:self progressHandler:^(float totalProgress, NSError * _Nullable error, BOOL * _Nonnull stop) {
        if (error) {
            NSLog(@"保存失败...%@",error.localizedDescription);
        }
        
        NSLog(@"保存进度....%f",totalProgress);
        if (totalProgress >= 1) {
            [weak_self createZipFile];
        }
    }];
}

//压缩
-(void)createZipFile{
    
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentDirectory lastObject];
    NSString *path = [documentPath stringByAppendingPathComponent:@"SaveModels/file_save.scn"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        NSLog(@"有保存的文件，尝试压缩...");
        NSString *filePath = path;
        NSString *zipFilePath = [documentPath stringByAppendingPathComponent:@"SaveModels/file_save.zip"];
        BOOL result = [SSZipArchive createZipFileAtPath:zipFilePath withFilesAtPaths:@[filePath]];
        if (result) {
            NSLog(@"压缩成功...");
        }else{
            NSLog(@"压缩失败...");
        }
    }else{
        NSLog(@"没有保存的文件，不压缩...");
        return;
    }
}

//模拟上传
-(void)uploadFile{
    //test server dic
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentDirectory lastObject];
    NSString *path_testServer = [documentPath stringByAppendingPathComponent:@"TestServer"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path_testServer]) {
        NSLog(@"有测试服务器目录...");
    }else{
        NSLog(@"无测试服务器目录，创建...");
        NSError *error = nil;
        [fm createDirectoryAtPath:path_testServer withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"创建测试服务器目录失败..%@",error.localizedDescription);
        }else{
            NSLog(@"创建测试服务器目录成功...%@",path_testServer);
        }
    }
    
    //服务器文件地址
    NSString *targetFilePath = [path_testServer stringByAppendingPathComponent:@"file_server.zip"];
    
    //源文件地址
    NSString *sourceFilePath = [documentPath stringByAppendingPathComponent:@"art.scnassets"];
    sourceFilePath = [sourceFilePath stringByAppendingPathComponent:@"file_save.zip"];
    
    if ([fm fileExistsAtPath:sourceFilePath]) {
        NSError *error = nil;
        [fm copyItemAtPath:sourceFilePath toPath:targetFilePath error:&error];
        if (error) {
            NSLog(@"模拟上传失败。。。%@",error.localizedDescription);
        }else{
            NSLog(@"模拟上传成功...");
        }
    }else{
        NSLog(@"模拟上传失败，找不到保存的文件。。。");
    }
}

#pragma mark - < 加载下载的模型1 把下载的文件移动到main bundle >
//模拟器可以 真机ios10解压失败找不到文件  ios11移动失败couldn’t be copied because you don’t have permission to access “art.scnassets”

//模拟下载
-(void)downloadFile1{
    
    XTJBlockWeak(self);
    XTJCoreNetworkManager *af = [XTJCoreNetworkManager sharedInstance];
    [af downloadFileWithURL:@"http://o9ivu69va.bkt.clouddn.com/art-o.zip"
          completionHandler:^(BOOL isSuccess, id respon, NSError *error) {
              if (isSuccess) {
                  NSString *path = respon;
                  NSLog(@"下载成功。。文件保存的路径。。%@",path);
                  [weak_self moveDownloadFile1:path];
              }else{
                  NSLog(@"下载失败。。%@",error.localizedDescription);
              }
          }];
}

-(void)moveDownloadFile1:(NSString *)sourcePath{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    //mainbundle/art.scnassets/file_download.zip
    NSString *path = [[NSBundle mainBundle] bundlePath];
    path = [path stringByAppendingPathComponent:@"art.scnassets"];
    path = [path stringByAppendingPathComponent:@"file_download.zip"];
    
    NSError *error = nil;
    [fm copyItemAtPath:sourcePath toPath:path error:&error];
    if (error) {
        NSLog(@"移动下载文件到doc失败。。。%@",error.localizedDescription);
    }else{
        NSLog(@"移动下载文件到doc成功...%@",path);
    }
    
    //解压
    [self unZipFile1];
    
}

//解压
-(void)unZipFile1{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    //mainbundle/file_download.zip
    NSString *path_source = [[NSBundle mainBundle] bundlePath];
    path_source = [path_source stringByAppendingPathComponent:@"art.scnassets"];
    NSString *path_target = [path_source stringByAppendingPathComponent:@"file_download.zip"];
    
    if ([fm fileExistsAtPath:path_target]) {
        NSLog(@"有下载的文件，尝试解压。。");
    }else{
        NSLog(@"没有下载的文件，不压缩，退出。。");
        return;
    }
    
    //解压缩的目标文件地址
    BOOL result = [SSZipArchive unzipFileAtPath:path_target toDestination:path_source delegate:self];
    if (result) {
        NSLog(@"解压成功。。%@",path_target);
    }else{
        NSLog(@"解压失败。。。%@",path_target);
    }
}

//下载文件的地址
-(NSURL *)downloadFilePath1{
    
    //mainbundle/art.scnassets/art-o/file.dae
    NSString *filePath = [[NSBundle mainBundle] bundlePath];
    filePath = [filePath stringByAppendingPathComponent:@"art.scnassets/art-o/file.dae"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePath]) {
        NSLog(@"已下载文件的地址...%@",filePath);
        NSURL *url = [NSURL fileURLWithPath:filePath];
        return url;
    }else{
        NSLog(@"没有已下载的文件..");
        return nil;
    }
    
    
    //    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    //    documentsDirectoryURL = [documentsDirectoryURL URLByAppendingPathComponent:@"art-o.scnassets/file.dae"];
    //    NSLog(@"已下载文件的地址...%@",documentsDirectoryURL);
    //    return documentsDirectoryURL;
}

#pragma mark - < 加载下载的模型2 通过SCNSceneSource读取下载的模型 >
//模拟下载
-(void)downloadFile2{
    
    XTJBlockWeak(self);
    XTJCoreNetworkManager *af = [XTJCoreNetworkManager sharedInstance];
    [af downloadFileWithURL:@"http://o9ivu69va.bkt.clouddn.com/art-o.zip"
          completionHandler:^(BOOL isSuccess, id respon, NSError *error) {
              if (isSuccess) {
                  NSString *path = respon;
                  NSLog(@"下载成功。。文件保存的路径。。%@",path);
                  [weak_self moveDownloadFile2:path];
              }else{
                  NSLog(@"下载失败。。%@",error.localizedDescription);
              }
          }];
}

-(void)moveDownloadFile2:(NSString *)sourcePath{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    //doc/file_download.zip
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentDirectory lastObject];
    NSString *path = [documentPath stringByAppendingPathComponent:@"file_download.zip"];
    
    NSError *error = nil;
    [fm copyItemAtPath:sourcePath toPath:path error:&error];
    if (error) {
        NSLog(@"移动下载文件到doc失败。。。%@",error.localizedDescription);
    }else{
        NSLog(@"移动下载文件到doc成功...");
    }
    
    //解压
    [self unZipFile2];
    
}

//解压
-(void)unZipFile2{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    //doc/file_download.zip
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path_source = [documentDirectory lastObject];
    NSString *path_target = [path_source stringByAppendingPathComponent:@"file_download.zip"];
    
    if ([fm fileExistsAtPath:path_target]) {
        NSLog(@"有下载的文件，尝试解压。。");
    }else{
        NSLog(@"没有下载的文件，退出。。");
        return;
    }
    
    //解压缩的目标文件地址
    BOOL result = [SSZipArchive unzipFileAtPath:path_target toDestination:path_source delegate:self];
    if (result) {
        NSLog(@"解压成功。。%@",path_target);
    }else{
        NSLog(@"解压失败。。。");
    }
}

//下载文件的地址
-(NSURL *)downloadFilePath2{
    
    //doc/art-o/file.dae
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentDirectory lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"art-o/file.dae"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePath]) {
        NSLog(@"已下载文件的地址...%@",filePath);
        NSURL *url = [NSURL fileURLWithPath:filePath];
        return url;
    }else{
        NSLog(@"没有已下载的文件..");
        return nil;
    }
    
    
    //    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    //    documentsDirectoryURL = [documentsDirectoryURL URLByAppendingPathComponent:@"art-o.scnassets/file.dae"];
    //    NSLog(@"已下载文件的地址...%@",documentsDirectoryURL);
    //    return documentsDirectoryURL;
}


#pragma mark - < SSZipArchiveDelegate >
- (void)zipArchiveWillUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo{
    NSLog(@"WillUnzipArchiveAtPat..");
}

- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPath{
    NSLog(@"DidUnzipArchiveAtPath..");
}

- (void)zipArchiveProgressEvent:(unsigned long long)loaded total:(unsigned long long)total{
    NSLog(@"zip ProgressEvent..%llu",loaded);
}

#pragma mark - < SCNSceneExportDelegate >
-(NSURL *)writeImage:(UIImage *)image withSceneDocumentURL:(NSURL *)documentURL originalImageURL:(NSURL *)originalImageURL{
    
    NSLog(@"writeImage...%@ %@ %@",image,documentURL,originalImageURL);
    return nil;
}

#pragma mark - < SCNSceneRendererDelegate >

- (void)renderer:(id <SCNSceneRenderer>)renderer updateAtTime:(NSTimeInterval)time{
    NSLog(@"1.updateAtTime..%f",time);
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didApplyAnimationsAtTime:(NSTimeInterval)time{
    NSLog(@"2.didApplyAnimationsAtTime..%f",time);
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didSimulatePhysicsAtTime:(NSTimeInterval)time{
    NSLog(@"3.didSimulatePhysicsAtTime..%f",time);
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didApplyConstraintsAtTime:(NSTimeInterval)time{
    NSLog(@"didApplyConstraintsAtTime..%f",time);
}

- (void)renderer:(id <SCNSceneRenderer>)renderer willRenderScene:(SCNScene *)scene atTime:(NSTimeInterval)time{
    NSLog(@"4.willRenderScene..%f",time);
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didRenderScene:(SCNScene *)scene atTime:(NSTimeInterval)time{
    NSLog(@"5.didRenderScene..%f",time);
}
@end
