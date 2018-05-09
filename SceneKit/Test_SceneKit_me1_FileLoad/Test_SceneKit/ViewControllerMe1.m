//
//  ViewControllerMe1
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import "ViewControllerMe1.h"
#import "XTJRootDefine.h"
#import "XTJ3DManager.h"
@interface ViewControllerMe1 ()
<
SCNSceneRendererDelegate
>
@property(nonatomic,strong)SCNScene *scene;
@property(nonatomic,strong)SCNView *scnView;
@end

@implementation ViewControllerMe1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *doucumentsPath = [XTJTool doucumentsPath];
    NSLog(@"doucumentsPath path...%@",doucumentsPath);
    
    //obj
    XTJ3DInfoModel *downloadInfoDic = [XTJ3DInfoModel infoWithIsLocal:NO
                                                                  url:@"http://o9ivu69va.bkt.clouddn.com/obj.zip"
                                                     downloadFilePath:@"obj/file.obj"
                                                        localFilePath:@"3d/飞龙obj/file.obj"
                                                            modelName:@"SubDragonLE_Shape"];
    
//    //dae
//    downloadInfoDic = [XTJ3DInfoModel infoWithIsLocal:NO
//                                                  url:@"http://o9ivu69va.bkt.clouddn.com/art-o.zip"
//                                     downloadFilePath:@"art-o/file.dae"
//                                        localFilePath:@"3d/飞龙dae/file.dae"
//                                            modelName:@"SubDragonLE_Shape"];
//
//    //本地.scnassets
//    downloadInfoDic = [XTJ3DInfoModel infoWithIsLocal:NO
//                                                  url:@"http://o9ivu69va.bkt.clouddn.com/obj.zip"
//                                     downloadFilePath:@"art-o/file.dae"
//                                        localFilePath:@"飞龙obj/file.obj"
//                                            modelName:@"SubDragonLE_Shape"];
    
    [XTJ3DManager sharedInstance].downloadInfoDic = downloadInfoDic;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setupScnview];
}

#pragma mark - action
- (IBAction)tap:(id)sender {
    
    [[XTJ3DManager sharedInstance] downloadFile];
}

- (IBAction)tap1:(id)sender {
    //模型
    [[XTJ3DManager sharedInstance] loadModelUseSCNSceneSource:self.scene];
}

- (IBAction)tap2:(id)sender {
    [[XTJ3DManager sharedInstance] removeDocFile];
}

- (IBAction)tap3:(id)sender {
    [self.scnView removeFromSuperview];
    self.scnView = nil;
    
    [self setupScnview];
}

- (IBAction)tap4:(id)sender {
    [[XTJ3DManager sharedInstance] showDocFiles];
}

#pragma mark - method
-(void)setupScnview{
    
    //读取1 项目文件夹/art.scnassets内模型
//    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/my3dmodel1/file.dae"];
    
    //读取2 项目文件夹/dae 但如果模型没有优化，如果cameraNode没有设置pointOfView则视角会错误
//    SCNScene *scene = [SCNScene sceneNamed:@"untitled.dae"];
    
    //读取3 项目文件夹/xxx.bundle内模型 必须是经过xcode优化过的模型 然后用SCNSceneSource读取
    SCNScene *scene = [SCNScene scene];
    self.scene = scene;

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
