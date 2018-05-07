//
//  ViewController26
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
// 获取点击的节点

@import SpriteKit;

#import "ViewController26.h"
#import <SceneKit/SceneKit.h>
#import "XTJRootDefine.h"
#import "SSZipArchive.h"
#import "XTJCoreNetworkManager.h"
@interface ViewController26 ()
<
SCNSceneRendererDelegate,SCNSceneExportDelegate,
SSZipArchiveDelegate
>
@property(nonatomic,strong)SCNView *scnView;
@property(nonatomic,strong)SCNNode *boxNode;
@end

@implementation ViewController26

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
    floorNode.name = @"地板";
    floorNode.geometry = floor;
    [scene.rootNode addChildNode:floorNode];
    
    //box
    SCNBox *box = [SCNBox boxWithWidth:100 height:100 length:100 chamferRadius:0];
    box.firstMaterial.diffuse.contents = ImageFile(@"image/春夏布料");
    SCNNode *boxNode = [SCNNode node];
    boxNode.name = @"盒子";
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
    
    // add a tap gesture recognizer
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    NSMutableArray *gestureRecognizers = [NSMutableArray array];
    [gestureRecognizers addObject:tapGesture];
    [gestureRecognizers addObjectsFromArray:scnView.gestureRecognizers];
    scnView.gestureRecognizers = gestureRecognizers;
}

#pragma mark - < action >
-(void)handleTap:(UITapGestureRecognizer *)gestureRecognize{
    
    // retrieve the SCNView
    SCNView *scnView = self.scnView;
    
    // check what nodes are tapped
    CGPoint p = [gestureRecognize locationInView:scnView];
    NSArray *hitResults = [scnView hitTest:p options:nil];
    
    // check that we clicked on at least one object
    if([hitResults count] > 0){
        // retrieved the first clicked object
        SCNHitTestResult *result = [hitResults objectAtIndex:0];
        
        //SCNHitTestResult参数
        SCNNode *node = result.node;//点击到的节点
        NSLog(@"节点名字:%@",node.name);
        NSInteger geoIndex = result.geometryIndex;//几何体索引
        NSLog(@"几何体索引..%ld",(long)geoIndex);
        NSInteger faceIndex = result.faceIndex;//面的索引
        NSLog(@"面的索引..%ld",(long)faceIndex);
        SCNVector3 localCoordinates = result.localCoordinates;//本地坐标系统
        SCNVector3 worldCoordinates = result.worldCoordinates;//世界坐标系统
//        SCNNode *boneNode = result.boneNode;//骨骼
        CGPoint textureCoordinates = [result textureCoordinatesWithMappingChannel:0];//纹理
        
        
        // get its material
        SCNMaterial *material = result.node.geometry.firstMaterial;//材质
        
        //高亮点击的部分
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
