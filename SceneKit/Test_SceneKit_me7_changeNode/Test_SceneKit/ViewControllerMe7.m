//
//  ViewControllerMe7
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import "ViewControllerMe7.h"
#import "XTJRootDefine.h"
#import "BJ3DManager.h"
@interface ViewControllerMe7 ()
<
SCNSceneRendererDelegate
>
@property(nonatomic,strong)SCNScene *scene;
@property(nonatomic,strong)SCNView *scnView;
@end

@implementation ViewControllerMe7

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *doucumentsPath = [XTJTool doucumentsPath];
    NSLog(@"doucumentsPath path...%@",doucumentsPath);
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setupScnview];
}

#pragma mark - action
- (IBAction)tap:(UIButton *)sender {
    [sender setTitle:@"下载" forState:UIControlStateNormal];
    
//    [[XTJDownloadManager sharedInstance] downloadFile:@"http://o9ivu69va.bkt.clouddn.com/dargon_obj.zip"
//                                    completionHandler:^(BOOL isSuccess, NSString *errMsg) {
//
//                                    }];
    
//    [[XTJDownloadManager sharedInstance] downloadFile:@"http://3hmlg.oss-cn-shenzhen.aliyuncs.com/test.pptx"
//                                    completionHandler:^(BOOL isSuccess, NSString *errMsg) {
//
//                                    }];
}

- (IBAction)tap1:(UIButton *)sender {
    [sender setTitle:@"加载" forState:UIControlStateNormal];
    
    [self loadModel];
}

- (IBAction)tap2:(UIButton *)sender {
    [sender setTitle:@"清空doc" forState:UIControlStateNormal];
    
//    [[XTJ3DManager sharedInstance] removeDocFile];
}

- (IBAction)tap3:(UIButton *)sender {
    [sender setTitle:@"reset" forState:UIControlStateNormal];
    
    [self.scnView removeFromSuperview];
    self.scnView = nil;
    
    [self setupScnview];
}

- (IBAction)tap4:(UIButton *)sender {
    [sender setTitle:@"换模型" forState:UIControlStateNormal];

    [self changeModel];
}

- (IBAction)tap5:(UIButton *)sender {
    [sender setTitle:@"show log" forState:UIControlStateNormal];
    
//    [[XTJ3DManager sharedInstance] showDocFiles];
//
//    for (SCNNode *node in self.scene.rootNode.childNodes) {
//        NSLog(@"scene node..%@",node.name);
//    }
    
    [self changeMap];
}

#pragma mark - method
-(void)setupScnview{
    
    SCNScene *scene = [SCNScene scene];
    self.scene = scene;

    //camera
    SCNCamera *camera = [SCNCamera camera];
    camera.automaticallyAdjustsZRange = YES;
    
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.name = @"cameraNode";
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 100, 100);
    cameraNode.rotation = SCNVector4Make(1, 0, 0, -M_PI_4);
//    cameraNode.position = SCNVector3Make(0, 0, 10);
    [scene.rootNode addChildNode:cameraNode];
    
    //light
    SCNLight *ambientlight = [SCNLight light];
    ambientlight.type = SCNLightTypeAmbient;
    ambientlight.color = [UIColor grayColor];
    SCNNode *ambientlightNode = [SCNNode node];
    ambientlightNode.name = @"ambientlightNode";
    ambientlightNode.light = ambientlight;
    [scene.rootNode addChildNode:ambientlightNode];
    
//    SCNLight *omnilight = [SCNLight light];
//    omnilight.type = SCNLightTypeOmni;
//    omnilight.color = [UIColor whiteColor];
//    SCNNode *omnilightNode = [SCNNode node];
//    omnilightNode.name = @"omnilightNode";
//    omnilightNode.light = omnilight;
//    omnilightNode.position = SCNVector3Make(0, 100, 100);
//    [scene.rootNode addChildNode:omnilightNode];
    
//    SCNLight *omnilight1 = [SCNLight light];
//    omnilight1.type = SCNLightTypeOmni;
//    omnilight1.color = [UIColor whiteColor];
//    SCNNode *omnilightNode1 = [SCNNode node];
//    omnilightNode1.name = @"omnilightNode";
//    omnilightNode1.light = omnilight1;
//    omnilightNode1.position = SCNVector3Make(0, 100, -100);
//    [scene.rootNode addChildNode:omnilightNode1];
    
 
    SCNLight *omnilight3 = [SCNLight light];
    omnilight3.type = SCNLightTypeOmni;
    omnilight3.color = [UIColor whiteColor];
    SCNNode *omnilightNode3 = [SCNNode node];
    omnilightNode3.name = @"omnilightNode";
    omnilightNode3.light = omnilight3;
    omnilightNode3.position = SCNVector3Make(100, 100, 0);
    [scene.rootNode addChildNode:omnilightNode3];
    
    //floor
//    SCNFloor *floor = [SCNFloor floor];
//    floor.firstMaterial.diffuse.contents = ImageFile(@"image/素材1");
//    SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
//    floorNode.name = @"floorNode";
//    floorNode.position = SCNVector3Make(0, 0, 0);
//    floorNode.physicsBody = [SCNPhysicsBody staticBody];//静态身体
//    [scene.rootNode addChildNode:floorNode];
    
    //box
//    SCNBox *box = [SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];
//    box.firstMaterial.diffuse.contents = ImageFile(@"image/婚庆布料");
//    SCNNode *boxNode = [SCNNode node];
//    boxNode.name = @"boxNode";
//    boxNode.geometry = box;
//    boxNode.position = SCNVector3Make(0, 0, 30);
//    boxNode.physicsBody = [SCNPhysicsBody dynamicBody];
//    [scene.rootNode addChildNode:boxNode];
    
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

#pragma mark - 模型
-(void)loadModel{
    //bgNode
//    SCNNode *bgNode = [SCNNode node];
//    bgNode.name = @"bg";
//    [self.scene.rootNode addChildNode:bgNode];
//
//    SCNNode *parentNode = bgNode;
    
//    //download
//    [[XTJ3DManager sharedInstance] loadModel:self.scene.rootNode
//                                    isLoacal:YES
//                                    filePath:@"3d/dargon_obj/file.obj"
//                                       sacle:SCNVector3Make(0.01, 0.01, 0.01)
//                                    position:SCNVector3Make(0, 0, 0)];
    
//    //model1
//    [[XTJ3DManager sharedInstance] loadModel:parentNode
//                                    isLoacal:YES
//                                    filePath:@"3d/dargon_obj/file.obj"
//                                       sacle:SCNVector3Make(0.01, 0.01, 0.01)
//                                    position:SCNVector3Make(0, 0, 0)];
//
//    //model2
//    [[XTJ3DManager sharedInstance] loadModel:parentNode
//                                    isLoacal:YES
//                                    filePath:@"3d/man_obj/file.obj"
//                                       sacle:SCNVector3Make(0.1, 0.1, 0.1)
//                                    position:SCNVector3Make(25, 0, 0)];
//
//    //model3
//    [[XTJ3DManager sharedInstance] loadModel:parentNode
//                                    isLoacal:YES
//                                    filePath:@"3d/xianjian_obj/file.obj"
//                                       sacle:SCNVector3Make(0.5, 0.5, 0.5)
//                                    position:SCNVector3Make(-25, 0, 0)];
    
//    //场景
//    [[XTJ3DManager sharedInstance] loadModel:self.scene.rootNode
//                                    isLoacal:YES
//                                    filePath:@"3d/game_scn/level.scn"
//                                       sacle:SCNVector3Zero
//                                    position:SCNVector3Zero];
    
    //人物
//    [[XTJ3DManager sharedInstance] loadModel:self.scene.rootNode
//                                    isLoacal:YES
//                                    filePath:@"3d/CEISHI/yifu_1.obj"
//                                       sacle:SCNVector3Make(0.5, 0.5, 0.5)
//                                    position:SCNVector3Make(0, 0, 0)];

//    [[XTJ3DManager sharedInstance] loadModel:self.scene.rootNode
//                                    isLoacal:YES
//                                    filePath:@"3d/CEISHI/Man.obj"
//                                       sacle:SCNVector3Make(0.5, 0.5, 0.5)
//                                    position:SCNVector3Make(0, 0, 0)];
    
    //裤子
//    [[XTJ3DManager sharedInstance] loadModel:self.scene.rootNode
//                                    isLoacal:YES
//                                    filePath:@"3d/man/man.obj"
//                                       sacle:SCNVector3Make(0.5, 0.5, 0.5)
//                                    position:SCNVector3Make(0, 0, 0)];


}

-(void)changeModel{
    
    SCNNode *currentNode = [self.scene.rootNode childNodeWithName:@"Top_SweatShirt01_Big_F_LOD0" recursively:YES];
    
    SCNScene *sceneTmp = [SCNScene sceneNamed:@"XTJResource.bundle/3d/CEISHI/YIFU-2.obj"];
    SCNNode *changeNode = [sceneTmp.rootNode childNodeWithName:@"Top_SweatShirt01_Big_M_LOD0" recursively:YES];
    changeNode.scale = SCNVector3Make(0.5, 0.5, 0.5);
//    changeNode.position = currentNode.position;//把坐标设置为要被替换的node的坐标
    
    [currentNode.parentNode replaceChildNode:currentNode with:changeNode];
}

-(void)changeMap{
//    [[XTJ3DManager sharedInstance] changeMaterial:self.scene.rootNode
//                                      targetModel:@"Top_SweatShirt01_Big_M_LOD0"
//                                   targetMaterial:@"07___Default"
//                                           change:ImageFile(@"image/earth")];
    
//    [[XTJ3DManager sharedInstance] changeMaterial:self.scene.rootNode
//                                      targetModel:@"Mentor_Street_Upper_Part"
//                                   targetMaterial:@"07___Default"
//                                           change:ImageFile(@"3d/kuzi/SMPL_Wings_color2.tga")];
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
