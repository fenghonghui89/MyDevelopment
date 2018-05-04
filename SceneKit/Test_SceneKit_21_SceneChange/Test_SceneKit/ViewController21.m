//
//  ViewControllerMe1
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

@import SpriteKit;

#import "ViewController21.h"
#import <SceneKit/SceneKit.h>
#import "XTJRootDefine.h"
#import "SSZipArchive.h"
#import "XTJCoreNetworkManager.h"
@interface ViewController21 ()
<
SCNSceneRendererDelegate,SCNSceneExportDelegate,
SSZipArchiveDelegate
>
@property(nonatomic,strong)SCNView *scnView;
@end

@implementation ViewController21

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *doucumentsPath = [XTJTool doucumentsPath];
    NSLog(@"doucumentsPath path...%@",doucumentsPath);
}

#pragma mark - < action >
- (IBAction)tap:(id)sender {
    
    [self presentScene1];
}

- (IBAction)tap1:(id)sender {
    [self presentScene2];
}

- (IBAction)tap2:(id)sender {
    [self.scnView removeFromSuperview];
    self.scnView = nil;
}

- (IBAction)tap3:(id)sender {
   
}

#pragma mark - < method >

-(void)presentScene1{
    
    [self.scnView removeFromSuperview];
    self.scnView = nil;
    
    SCNScene *scene = [SCNScene scene];
    scene.background.contents = ImageFile(@"image/skybox01_cube");//天空盒子
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"XTJMaterial" ofType:@"bundle"];
    filePath = [filePath stringByAppendingPathComponent:@"3d/my3dmodel1/file.dae"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    SCNSceneSource *sceneSource = [SCNSceneSource sceneSourceWithURL:url options:nil];
    SCNNode *modelNode = [sceneSource entryWithIdentifier:@"SubDragonLE_Shape" withClass:[SCNNode class]];
    [scene.rootNode addChildNode:modelNode];
    
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
//    SCNFloor *floor = [SCNFloor floor];
//    floor.firstMaterial.diffuse.contents = ImageFile(@"image/素材1");
//    floor.width = 1000;
//    floor.length = 1000;
//
//    SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
//    floorNode.position = SCNVector3Make(0, 0, 0);
//    floorNode.physicsBody = [SCNPhysicsBody staticBody];//静态身体
//    [scene.rootNode addChildNode:floorNode];
    
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
    
    //创建转换场景
    SKTransition *transition = [SKTransition doorwayWithDuration:1];
    
    [scnView presentScene:scene withTransition:transition incomingPointOfView:cameraNode completionHandler:^{
        
    }];
    
}

-(void)presentScene2{
    
    [self.scnView removeFromSuperview];
    self.scnView = nil;
    
    SCNScene *scene = [SCNScene scene];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"XTJMaterial" ofType:@"bundle"];
    filePath = [filePath stringByAppendingPathComponent:@"3d/my3dmodel1/file.dae"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    SCNSceneSource *sceneSource = [SCNSceneSource sceneSourceWithURL:url options:nil];
    SCNNode *modelNode = [sceneSource entryWithIdentifier:@"SubDragonLE_Shape" withClass:[SCNNode class]];
    [scene.rootNode addChildNode:modelNode];
    
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
    
    //创建转换场景
    SKTransition *transition = [SKTransition crossFadeWithDuration:1];
    
    [scnView presentScene:scene withTransition:transition incomingPointOfView:cameraNode completionHandler:^{
        
    }];
    
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
