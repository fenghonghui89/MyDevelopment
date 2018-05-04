//
//  ViewController23
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
// 阴影的使用

@import SpriteKit;

#import "ViewController23.h"
#import <SceneKit/SceneKit.h>
#import "XTJRootDefine.h"
#import "SSZipArchive.h"
#import "XTJCoreNetworkManager.h"
@interface ViewController23 ()
<
SCNSceneRendererDelegate,SCNSceneExportDelegate,
SSZipArchiveDelegate
>
@property(nonatomic,strong)SCNView *scnView;
@property(nonatomic,strong)SCNNode *boxNode;
@end

@implementation ViewController23

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
    [self shadow];
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
    
    //camera
    SCNCamera *camera = [SCNCamera camera];
    camera.automaticallyAdjustsZRange = YES;
    
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 1000, 1000);
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
    floor.reflectivity = 0;
    floor.firstMaterial.diffuse.contents = ImageFile(@"image/素材1");
    floor.firstMaterial.diffuse.contents = [UIColor grayColor];
    floor.width = 0;
    floor.length = 0;
    
    SCNNode *floorNode = [SCNNode node];
    floorNode.geometry = floor;
    [scene.rootNode addChildNode:floorNode];
    
    //box
    SCNBox *box = [SCNBox boxWithWidth:100 height:100 length:100 chamferRadius:0];
    box.firstMaterial.diffuse.contents = ImageFile(@"image/春夏布料");
    SCNNode *boxNode = [SCNNode node];
    boxNode.geometry = box;
    boxNode.position = SCNVector3Make(0, 50, 0);
    [scene.rootNode addChildNode:boxNode];
    self.boxNode = boxNode;
    
    //scnview
    SCNView *scnView = [[SCNView alloc] initWithFrame:self.view.bounds];
    scnView.center = self.view.center;
    scnView.scene = scene;
    scnView.backgroundColor = [UIColor blackColor];
    scnView.allowsCameraControl = YES;
    scnView.antialiasingMode = SCNAntialiasingModeMultisampling4X;//开启抗锯齿
    scnView.showsStatistics = YES;
    scnView.preferredFramesPerSecond = 60;//帧率
    [self.view addSubview:scnView];
    [self.view sendSubviewToBack:scnView];
    self.scnView = scnView;

    //聚焦光 阴影
    [self shadow];
    
    //TODO:发射有形状的光
}

-(void)shadow{
    
    //圆锥体做灯罩
    SCNCone *cone = [SCNCone coneWithTopRadius:1 bottomRadius:25 height:50];
    cone.radialSegmentCount = 10;
    cone.heightSegmentCount = 5;
    cone.firstMaterial.emission.contents = [UIColor yellowColor];
    
    //聚焦光
    SCNLight *light = [SCNLight light];
    light.type = SCNLightTypeSpot;
    light.castsShadow = YES;
    light.shadowMode = SCNShadowModeForward;//设置这个后灯光的阴影效果才能呈现
    light.spotOuterAngle = 60;
    light.zFar = 2000;//光照射的最远距离
    
    //灯光node
    SCNNode *spotLight = [SCNNode node];
    spotLight.geometry = cone;
    spotLight.position = SCNVector3Make(0, 0, 0);
    spotLight.light = light;
    
    /*
     支点 用来控制灯光node的移动
     如果不加，然后把动作加到灯光node，会发现灯光不会移动
     */
    SCNNode *handleSpot = [SCNNode node];
    handleSpot.position = SCNVector3Make(0, 500, 40);
    [handleSpot addChildNode:spotLight];
    [self.scnView.scene.rootNode addChildNode:handleSpot];
    
    //动作
    SCNAction *moveRight = [SCNAction moveTo:SCNVector3Make(100, 500, 0) duration:2];
    SCNAction *moveLeft = [SCNAction moveTo:SCNVector3Make(-100, 500, 0) duration:2];
    SCNAction *sequence = [SCNAction sequence:@[moveRight,moveLeft]];
    
    [handleSpot runAction:[SCNAction repeatActionForever:sequence]];
    
    //添加约束 使光的方向指向几何体
    SCNLookAtConstraint *constaint = [SCNLookAtConstraint lookAtConstraintWithTarget:self.boxNode];
    spotLight.constraints = @[constaint];
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
