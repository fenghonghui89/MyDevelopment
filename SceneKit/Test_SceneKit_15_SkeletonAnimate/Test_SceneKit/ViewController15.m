//
//  ViewController15
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
// 骨骼动画

#import "ViewController15.h"
#import <SceneKit/SceneKit.h>
#import "XTJRootDefine.h"
#import "SSZipArchive.h"
#import "XTJCoreNetworkManager.h"
#define edge 5
@interface ViewController15 ()
<
SCNPhysicsContactDelegate,SSZipArchiveDelegate
>
{
    SCNView *_scnView;
}
@end

@implementation ViewController15

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

-(void)setupScnview{
    
    SCNScene *scene = [SCNScene scene];

    //camera
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 30, 50);
    cameraNode.rotation = SCNVector4Make(1, 0, 0, -M_PI_4);
    [scene.rootNode addChildNode:cameraNode];
    
    //light
    SCNLight *light = [SCNLight light];
    light.type = SCNLightTypeAmbient;
    light.color = [UIColor grayColor];
    SCNNode *lightNode = [SCNNode node];
    lightNode.light = light;
    [scene.rootNode addChildNode:lightNode];

    //floor
    SCNFloor *floor = [SCNFloor floor];
    floor.firstMaterial.diffuse.contents = ImageFile(@"image/素材1");
    floor.width = 0;
    floor.length = 0;
    
    SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
    floorNode.position = SCNVector3Make(0, 0, 0);
    floorNode.physicsBody = [SCNPhysicsBody staticBody];//静态身体
    [scene.rootNode addChildNode:floorNode];
    
    //scnview
    SCNView *scnView = [[SCNView alloc] initWithFrame:self.view.bounds];
    scnView.center = self.view.center;
    scnView.backgroundColor = [UIColor blackColor];
    scnView.allowsCameraControl = YES;
    scnView.antialiasingMode = SCNAntialiasingModeMultisampling4X;//开启抗锯齿
    scnView.showsStatistics = YES;
    scnView.debugOptions = SCNDebugOptionShowPhysicsShapes|SCNDebugOptionShowPhysicsFields;
    scnView.preferredFramesPerSecond = 60;//帧率
    [self.view addSubview:scnView];
    [self.view sendSubviewToBack:scnView];
    _scnView = scnView;

    //本地模型 已经优化or未优化都可以
//    SCNScene *scenetmp = [SCNScene sceneNamed:@"skinning.dae"];
//    NSArray *nodes = scenetmp.rootNode.childNodes;
//    NSLog(@"count..%lu",(unsigned long)nodes.count);
//    SCNNode *personNode = [scenetmp.rootNode childNodeWithName:@"avatar_attach" recursively:YES];
    
    //网上模型 必须已经优化
    NSURL *url = [self downloadFilePath2];
    SCNSceneSource *sceneSource = [SCNSceneSource sceneSourceWithURL:url options:nil];
    NSError *error = nil;
    if (error) {
        NSLog(@"error:%@",error.localizedDescription);
    }
    NSArray *nodes = [sceneSource identifiersOfEntriesWithClass:[SCNNode class]];
    NSLog(@"count..%lu",(unsigned long)nodes.count);
    SCNNode *personNode = [sceneSource entryWithIdentifier:@"avatarRoot" withClass:[SCNNode class]];
    personNode.scale = SCNVector3Make(0.01, 0.01, 0.01);
    [scene.rootNode addChildNode:personNode];
    
    //获取模型包含的动画组
    NSArray *animationIDs =  [sceneSource identifiersOfEntriesWithClass:[CAAnimation class]];
    NSUInteger animationCount = [animationIDs count];
    NSMutableArray *longAnimations = [[NSMutableArray alloc] initWithCapacity:animationCount];
    CFTimeInterval maxDuration = 0;
    for (NSInteger index = 0; index < animationCount; index++) {
        CAAnimation *animation = [sceneSource entryWithIdentifier:animationIDs[index] withClass:[CAAnimation class]];
        if (animation) {
            maxDuration = MAX(maxDuration, animation.duration);
            NSLog(@"maxDuration。。%f",animation.duration);
            [longAnimations addObject:animation];
        }
    }

    CAAnimationGroup *longAnimationsGroup = [[CAAnimationGroup alloc] init];
    longAnimationsGroup.animations = longAnimations;
    longAnimationsGroup.duration = maxDuration;
    
    CAAnimationGroup *idleAnimationGroup = [longAnimationsGroup copy];
    idleAnimationGroup.timeOffset = 20;//6.45833333333333
    
    CAAnimationGroup *lastAnimationGroup;
    lastAnimationGroup = [CAAnimationGroup animation];
    lastAnimationGroup.animations = @[idleAnimationGroup];
    lastAnimationGroup.duration = 24.71-20;
    lastAnimationGroup.repeatCount = 10000;
    lastAnimationGroup.autoreverses = YES;
    
    [personNode addAnimation:lastAnimationGroup forKey:@"animation"];

    //查看骨头
    SCNNode *skeletonNode = [scnView.scene.rootNode childNodeWithName:@"skeleton" recursively:YES];
    skeletonNode = [sceneSource entryWithIdentifier:@"skeleton" withClass:[SCNNode class]];
    [self visualizeBones:true ofNode:skeletonNode inheritedScale:1];
    
    //box
    SCNBox *box = [SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];
    box.firstMaterial.diffuse.contents = ImageFile(@"image/素材2");
    SCNNode *boxNode = [SCNNode nodeWithGeometry:box];
    [scene.rootNode addChildNode:boxNode];
    
    
    scnView.scene = scene;
}

#pragma mark - Skeleton visualisation
-(void)visualizeBones:(BOOL)show ofNode:(SCNNode *)node inheritedScale:(CGFloat)scale{
    
    // We propagate an inherited scale so that the boxes
    // representing the bones will be of the same size
    scale *= node.scale.x;
    
    if (show) {
        if (node.geometry == nil)
            node.geometry = [SCNBox boxWithWidth:6.0 / scale height:6.0 / scale length:6.0 / scale chamferRadius:0.5];
    }
    else {
        if ([node.geometry isKindOfClass:[SCNBox class]])
            node.geometry = nil;
    }
    
    for (SCNNode *child in node.childNodes)
        [self visualizeBones:show ofNode:child inheritedScale:scale];
}

#pragma mark - < 加载下载的模型2 通过SCNSceneSource读取下载的模型 >
//模拟下载
-(void)downloadFile2{
    
    XTJBlockWeak(self);
    XTJCoreNetworkManager *af = [XTJCoreNetworkManager sharedInstance];
    [af downloadFileWithURL:@"http://o9ivu69va.bkt.clouddn.com/skinning-t.zip"
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
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"skinning-t/skinning.dae"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePath]) {
        NSLog(@"已下载文件的地址...%@",filePath);
        NSURL *url = [NSURL fileURLWithPath:filePath];
        return url;
    }else{
        NSLog(@"没有已下载的文件..%@",filePath);
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


#pragma mark - < action >
- (IBAction)tap:(id)sender {
    [self downloadFile2];
}
- (IBAction)tap1:(id)sender {
    [self setupScnview];
}

- (void) handleTap:(UIGestureRecognizer*)gestureRecognize
{
    // retrieve the SCNView
    SCNView *scnView = _scnView;
    
    // check what nodes are tapped
    CGPoint p = [gestureRecognize locationInView:scnView];
    NSArray *hitResults = [scnView hitTest:p options:nil];
    
    // check that we clicked on at least one object
    if([hitResults count] > 0){
        // retrieved the first clicked object
        SCNHitTestResult *result = [hitResults objectAtIndex:0];
        
        // get its material
        SCNMaterial *material = result.node.geometry.firstMaterial;
        
        // highlight it
        [SCNTransaction begin];
        [SCNTransaction setAnimationDuration:0.5];
        
        // on completion - unhighlight
        [SCNTransaction setCompletionBlock:^{
            [SCNTransaction begin];
            [SCNTransaction setAnimationDuration:0.5];
            
            material.emission.contents = [UIColor blackColor];
            
            [SCNTransaction commit];
        }];
        
        material.emission.contents = [UIColor orangeColor];
        
        [SCNTransaction commit];
    }
}

#pragma mark - < SCNPhysicsContactDelegate >
- (void)physicsWorld:(SCNPhysicsWorld *)world didBeginContact:(SCNPhysicsContact *)contact{
    NSLog(@"didBeginContact...");
}
- (void)physicsWorld:(SCNPhysicsWorld *)world didUpdateContact:(SCNPhysicsContact *)contact{
    NSLog(@"didUpdateContact...");
}
- (void)physicsWorld:(SCNPhysicsWorld *)world didEndContact:(SCNPhysicsContact *)contact{
    NSLog(@"didEndContact...");
}
@end
