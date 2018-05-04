//
//  ViewController20
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//各种力

#import "ViewController20.h"
#import <SceneKit/SceneKit.h>
#import "XTJRootDefine.h"
@interface ViewController20 ()
<
SCNSceneRendererDelegate
>
@property(nonatomic,strong)SCNView *scnView;
@end

@implementation ViewController20

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setupScnview];
}

-(void)setupScnview{
    
    SCNScene *scene = [SCNScene scene];
    
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
    
    //camera
    SCNCamera *camera = [SCNCamera camera];
    camera.automaticallyAdjustsZRange = YES;
    
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 20, 100);
    [scene.rootNode addChildNode:cameraNode];
    scnView.pointOfView = cameraNode;
    
    //light
    SCNLight *ambientlight = [SCNLight light];
    ambientlight.type = SCNLightTypeAmbient;
    ambientlight.color = [UIColor grayColor];
    SCNNode *ambientlightNode = [SCNNode node];
    ambientlightNode.light = ambientlight;
    [scnView.scene.rootNode addChildNode:ambientlightNode];
    
    //floor
    SCNFloor *floor = [SCNFloor floor];
    floor.firstMaterial.diffuse.contents = ImageFile(@"image/素材1");
    floor.width = 1000;
    floor.length = 1000;

    SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
    floorNode.position = SCNVector3Make(0, 0, 0);
    floorNode.physicsBody = [SCNPhysicsBody staticBody];//静态身体
    [scnView.scene.rootNode addChildNode:floorNode];
    
    //box
//    SCNBox *box = [SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];
//    box.firstMaterial.diffuse.contents = ImageFile(@"image/婚庆布料");
//    SCNNode *boxNode = [SCNNode node];
//    boxNode.geometry = box;
//    boxNode.position = SCNVector3Make(0, 5, 0);
//    boxNode.physicsBody = [SCNPhysicsBody dynamicBody];
//    [scene.rootNode addChildNode:boxNode];
    
    //随机node
    for (int i = 0; i<100; i++) {
        [self createNode];
    }
    
    //施加力 参数决定方向及力度
//    [boxNode.physicsBody applyForce:SCNVector3Make(-10, 0, 0) impulse:YES];
    
    //拖拽力
//    [self dragField:boxNode];
//
//    //旋转力
//    [self vortexField];
    
    //朝向一个点的力
//    [self radialGravity];
    
    //随机力
    [self noiseField];
    
    
//    //camera 约束
//    SCNLookAtConstraint *lookAt = [SCNLookAtConstraint lookAtConstraintWithTarget:boxNode];
//    cameraNode.constraints = @[lookAt];
}

-(void)createNode{
    
    SCNSphere *box = [SCNSphere sphereWithRadius:1];
    box.firstMaterial.diffuse.contents = ImageFile(@"image/婚庆布料");
    SCNNode *boxNode = [SCNNode node];
    boxNode.geometry = box;
    boxNode.position = SCNVector3Make(arc4random_uniform(20), arc4random_uniform(20), arc4random_uniform(20));
    boxNode.physicsBody = [SCNPhysicsBody dynamicBody];
    [self.scnView.scene.rootNode addChildNode:boxNode];
}
#pragma mark - < 各种力 >
/*
 拖拽力
 没有方向，只有大小，主要是阻碍物体的运动
 如果物体没有速度，拖拽力不会对物体产生影响
 */
-(void)dragField:(SCNNode *)superNode{
    
    SCNPhysicsField *drayField = [SCNPhysicsField dragField];
    drayField.strength = 30;//力的强度
    drayField.direction = SCNVector3Make(0, 1, 0);//方向对拖拽力无效
    SCNNode *drayFieldNode = [SCNNode node];
    drayFieldNode.physicsField = drayField;
    [superNode addChildNode:drayFieldNode];
}

/*
 旋转力
 类似右手螺旋法则，轴线方向是大拇指指向的方向，手指环绕的方向才是力的方向
 */
-(void)vortexField{
    SCNPhysicsField *vortexField = [SCNPhysicsField vortexField];
    vortexField.strength = 1;
    vortexField.direction = SCNVector3Make(-1, 0, 0);
    SCNNode *vortexFieldNode = [SCNNode node];
    vortexFieldNode.physicsField = vortexField;
    [self.scnView.scene.rootNode addChildNode:vortexFieldNode];//注意是添加到scene

}

/*
 朝向一个点的力
 可设置位置，力会朝向设置的位置
 力度的值如果为负，则方向会相反
 */
-(void)radialGravity{
    
    SCNPhysicsField *radialGravity = [SCNPhysicsField radialGravityField];
    radialGravity.strength = -1000;
    
    SCNNode *node = [SCNNode node];
    node.physicsField = radialGravity;
    node.position = SCNVector3Make(0, 0, 0);
    
    [self.scnView.scene.rootNode addChildNode:node];
}

/*
 随机力
 例如下雪、萤火虫效果
 */
-(void)noiseField{
    
    SCNPhysicsField *noiseField = [SCNPhysicsField noiseFieldWithSmoothness:0 animationSpeed:1];//噪点的平滑性 运动的速度
    noiseField.strength = 100;
    
    SCNNode *node = [SCNNode node];
    node.physicsField = noiseField;
    node.position = SCNVector3Make(0, 0, 0);
    
    [self.scnView.scene.rootNode addChildNode:node];
}

/*
 一种和速度成正比的随机力
 */
-(void)turbulenceField{
    SCNPhysicsField *turbulenceField = [SCNPhysicsField turbulenceFieldWithSmoothness:0 animationSpeed:1];
    turbulenceField.strength = 100;
    
    SCNNode *node = [SCNNode node];
    node.physicsField = turbulenceField;
    node.position = SCNVector3Make(0, 0, 0);
    
    [self.scnView.scene.rootNode addChildNode:node];
}


/**
 弹性力(胡克定律)
 需要设置力的大小和位置
 */
-(void)springField{
    
    SCNPhysicsField *springField = [SCNPhysicsField springField];

}

/**
 电场力
 这种力的大小，取决于物体带的电荷的多少和距离磁场的距离，方向取决于电荷的正负
 默认属性是正
 */
-(void)electricField{
    
    SCNPhysicsField *electricField = [SCNPhysicsField electricField];
    
}

/**
 磁场力
 吸引或排斥物体，取决于电荷的大小、正负、速度、距离等因素
 */
-(void)magneticField{
    
    SCNPhysicsField *magneticField = [SCNPhysicsField magneticField];
    
}


/**
 自定义力
 */
-(void)customField{
    
}

#pragma mark - < action >
- (IBAction)tap:(id)sender {
    
}

- (IBAction)tap1:(id)sender {
   
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
