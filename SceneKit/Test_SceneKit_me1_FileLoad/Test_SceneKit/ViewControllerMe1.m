//
//  ViewControllerMe1
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import "ViewControllerMe1.h"
#import "XTJRootDefine.h"
#import "SSZipArchive.h"
#import "XTJCoreNetworkManager.h"
@import ModelIO;
@import SceneKit;
@import SceneKit.ModelIO;
@interface ViewControllerMe1 ()
<
SCNSceneRendererDelegate,SCNSceneExportDelegate,
SSZipArchiveDelegate
>
@property(nonatomic,strong)SCNScene *scene;
@property(nonatomic,strong)SCNView *scnView;
@property(nonatomic,strong)NSDictionary *downloadInfoDic;
@end

@implementation ViewControllerMe1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *doucumentsPath = [XTJTool doucumentsPath];
    NSLog(@"doucumentsPath path...%@",doucumentsPath);
    
    /*
     是否本地文件
     下载地址
     下载解压后的文件路径
     本地文件路径
     模型名
     */
    //obj
//    self.downloadInfoDic = @{
//                             @"isLocal":@(NO),
//                             @"url":@"http://o9ivu69va.bkt.clouddn.com/obj.zip",
//                             @"downloadFilePath":@"obj/file.obj",
//                             @"localFilePath":@"3d/飞龙obj/file.obj",
//                             @"modelName":@"SubDragonLE_Shape"
//                             };
    
    //dae
    self.downloadInfoDic = @{
                             @"isLocal":@(NO),
                             @"url":@"http://o9ivu69va.bkt.clouddn.com/art-o.zip",
                             @"downloadFilePath":@"art-o/file.dae",
                             @"localFilePath":@"3d/飞龙dae/file.dae",
                             @"modelName":@"SubDragonLE_Shape"
                             };
}

#pragma mark - < action >
- (IBAction)tap:(id)sender {
    
    NSString *url = self.downloadInfoDic[@"url"];
    [self downloadFile:url];
}

- (IBAction)tap1:(id)sender {
    [self setupScnview];
}

- (IBAction)tap2:(id)sender {
    [self removeDocFile];
}

- (IBAction)tap3:(id)sender {
    [self.scnView removeFromSuperview];
    self.scnView = nil;
}

- (IBAction)tap4:(id)sender {
    [self showLog];
}

#pragma mark -  method
-(void)showLog{

    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentDirectory lastObject];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSError *error = nil;
    NSArray *files = [fm contentsOfDirectoryAtPath:documentPath error:&error];
    if (error) {
        NSLog(@"error..%@",error.localizedDescription);
    }else{
        for (NSString *fileName in files) {
            NSLog(@"file name..%@",fileName);
        }
    }

}

-(void)removeDocFile{
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentDirectory lastObject];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *files = [fm contentsOfDirectoryAtPath:documentPath error:&error];
    if (error) {
        NSLog(@"error..%@",error.localizedDescription);
    }else{
        for (NSString *fileName in files) {
            NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
            NSError *error = nil;
            [fm removeItemAtPath:filePath error:&error];
            if (error) {
                NSLog(@"删除error..%@",error.localizedDescription);
            }else{
                NSLog(@"删除成功..%@",fileName);
            }
        }
    }
}


-(void)setupScnview{
    
    //读取1 项目文件夹/art.scnassets内模型
//    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/my3dmodel1/file.dae"];
    
    //读取2 项目文件夹/dae 但如果模型没有优化，如果cameraNode没有设置pointOfView则视角会错误
//    SCNScene *scene = [SCNScene sceneNamed:@"untitled.dae"];
    
    //读取3 项目文件夹/xxx.bundle内模型 必须是经过xcode优化过的模型 然后用SCNSceneSource读取
    SCNScene *scene = [SCNScene scene];
    self.scene = scene;
    
    //模型
    [self loadModel];

    //camera
    SCNCamera *camera = [SCNCamera camera];
    camera.automaticallyAdjustsZRange = YES;
    
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 100, 100);
    cameraNode.rotation = SCNVector4Make(1, 0, 0, -M_PI_4);
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
    
    SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
    floorNode.position = SCNVector3Make(0, 0, 0);
    floorNode.physicsBody = [SCNPhysicsBody staticBody];//静态身体
    [scene.rootNode addChildNode:floorNode];
    
    //box
    SCNBox *box = [SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];
    box.firstMaterial.diffuse.contents = ImageFile(@"image/婚庆布料");
    SCNNode *boxNode = [SCNNode node];
    boxNode.geometry = box;
    boxNode.position = SCNVector3Make(0, 0, 30);
    boxNode.physicsBody = [SCNPhysicsBody dynamicBody];
    [scene.rootNode addChildNode:boxNode];
    
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
}

#pragma mark - load model
/*
 MARK:
 加载本地模型：
 项目文件夹/art.scnassets内模型
 项目文件夹/dae 但如果模型没有优化，如果cameraNode没有设置pointOfView则视角会错误
 项目文件夹/xxx.bundle内模型 必须是经过xcode优化过的模型
 
 加载网上模型：
 把下载的文件移动到main bundle 只有模拟器成功 真机ios10解压失败找不到文件  ios11移动失败couldn’t be copied because you don’t have permission to access “art.scnassets”


 总结:
 1.本地模型，不管在哪，都可以用[SCNScene sceneNamed:]或者SCNSceneSource读取，
 如果是放在xxx.bundle里面，则模型要经过优化，否则无法读取
 2.网上模型，都要经过优化，只能通过SCNSceneSource读取
 3.用SCNSceneSource读取，可以获取更多信息，注意url必须是fileURL
 4.最后才scnView.scene = scene;，则视角能最大限度保证正常，因为此时pointOfView必定有值
 */
-(void)loadModel{
    
    //url
    NSURL *fileURL = nil;
    BOOL isLocal = [self.downloadInfoDic[@"isLocal"] boolValue];
    if (isLocal) {
        //本地文件
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"XTJResource" ofType:@"bundle"];
        NSString *file = self.downloadInfoDic[@"localFilePath"];
        filePath = [filePath stringByAppendingPathComponent:file];
        fileURL = [NSURL fileURLWithPath:filePath];
    }else{
        //网络文件
        NSString *file = self.downloadInfoDic[@"downloadFilePath"];
        fileURL = [self downloadFilePath:file];
    }
    
//    [self loadModelUseModelIO:fileURL];
    [self loadModelUseSCNSceneSource:fileURL];
}

/*
 Model I/O
 不能读取dae文件，报错DAE file has no contents
 obj模型会偏暗
 obj模型可能会过大，要注意缩小，scale参数值越小，比例越小
 */
-(void)loadModelUseModelIO:(NSURL *)fileURL{
    
    MDLAsset *asset = [[MDLAsset alloc] initWithURL:fileURL];
    NSLog(@"asset count...%lu",(unsigned long)asset.count);
    for (MDLObject *obj in asset) {
        
        //判断是不是MDLMesh类型
        MDLMesh *mesh = nil;
        if ([obj isKindOfClass:[MDLMesh class]]) {
            mesh = (MDLMesh *)[asset objectAtIndex:0];
        }else{
            NSLog(@"文件错误,return..");
            return;
        }
        
        //提取模型
        SCNNode *modelNode = [SCNNode nodeWithMDLObject:mesh];
        NSLog(@"model name..%@",modelNode.name);
        
        //模型可能过大，要缩小
        modelNode.scale = SCNVector3Make(0.01, 0.01, 0.01);
        
        //如果是obj模型，可能偏暗，则修改光照模型
        NSArray *ms = modelNode.geometry.materials;
        for (SCNMaterial *material in ms) {
            NSLog(@"material name..%@",material.name);
            material.lightingModelName = SCNLightingModelBlinn;
        }
        
        //加入到scenen
        [self.scene.rootNode addChildNode:modelNode];
    }
}

/*
 SCNSceneSource
 可读取obj和dae模型
 obj模型会偏暗，dae不会
 obj模型可能会过大，要注意缩小，scale参数值越小，比例越小；dae模型，scale可能是反过来的，scale参数值越小，比例越大
 */
-(void)loadModelUseSCNSceneSource:(NSURL *)fileURL{
    
    SCNSceneSource *sceneSource = [SCNSceneSource sceneSourceWithURL:fileURL options:nil];
    
    SCNScene *scenetmp = [sceneSource sceneWithOptions:nil error:nil];
    NSArray *nodes = scenetmp.rootNode.childNodes;
    NSString *modelName = self.downloadInfoDic[@"modelName"];
    NSLog(@"count..%lu",(unsigned long)nodes.count);
    
    //方法1.无法找到本地或网络的obj模型
//    SCNNode *modelNode = [sceneSource entryWithIdentifier:modelName withClass:[SCNNode class]];
//    [self.scene.rootNode addChildNode:modelNode];
    
    //方法2.可以
//    SCNNode *modelNode = [scenetmp.rootNode childNodeWithName:modelName recursively:YES];
//    modelNode.scale = SCNVector3Make(0.01, 0.01, 0.01);
//    [self.scene.rootNode addChildNode:modelNode];
    
    //方法3.不能直接把rootNode挪到另外的scene(会报警告)，所以把rootNode.childNodes遍历加入
    for (SCNNode *node in scenetmp.rootNode.childNodes) {
        
        NSLog(@"model name..%@",node.name);
        
        //调整模型尺寸
        node.scale = SCNVector3Make(0.01, 0.01, 0.01);
        
        //如果是obj模型，可能偏暗，则修改光照模型
        NSArray *ms = node.geometry.materials;
        for (SCNMaterial *material in ms) {
            NSLog(@"material name..%@",material.name);
            material.lightingModelName = SCNLightingModelBlinn;
        }
        
        //加入到scenen
        [self.scene.rootNode addChildNode:node];
    }
}

#pragma mark - 上传
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

#pragma mark -  下载/解压
-(void)downloadFile:(NSString *)url{
    
    //eg. url = http://o9ivu69va.bkt.clouddn.com/art-o.zip
    
    XTJBlockWeak(self);
    XTJCoreNetworkManager *af = [XTJCoreNetworkManager sharedInstance];
    [af downloadFileWithURL:url
          completionHandler:^(BOOL isSuccess, id respon, NSError *error) {
              if (isSuccess) {
                  NSString *path = respon;
                  NSLog(@"下载成功。。文件保存的路径。。%@",path);
                  
                  //移动
                  [weak_self moveDownloadFile:path];
              }else{
                  NSLog(@"下载失败。。%@",error.localizedDescription);
              }
          }];
}

-(void)moveDownloadFile:(NSString *)sourcePath{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    //doc/file_download.zip
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentDirectory lastObject];
    NSString *path = [documentPath stringByAppendingPathComponent:@"file_download.zip"];
    
    //main bundle
//    NSString *path = [[NSBundle mainBundle] bundlePath];
    
    //copy
    NSError *error = nil;
    [fm copyItemAtPath:sourcePath toPath:path error:&error];
    if (error) {
        NSLog(@"移动下载文件到doc失败。。。%@",error.localizedDescription);
    }else{
        NSLog(@"移动下载文件到doc成功...");
    }
    
    //unzip
    BOOL result = [SSZipArchive unzipFileAtPath:path toDestination:documentPath delegate:self];
    if (result) {
        NSLog(@"解压成功。。%@",path);
    }else{
        NSLog(@"解压失败。。。");
    }
    
}

//下载文件的地址
-(NSURL *)downloadFilePath:(NSString *)file{
    
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentDirectory lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:file];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePath]) {
        NSLog(@"找到已下载文件...%@",filePath);
        NSURL *url = [NSURL fileURLWithPath:filePath];
        return url;
    }else{
        NSLog(@"没有已下载文件..%@",filePath);
        return nil;
    }
    
    
    //    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    //    documentsDirectoryURL = [documentsDirectoryURL URLByAppendingPathComponent:file];
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
