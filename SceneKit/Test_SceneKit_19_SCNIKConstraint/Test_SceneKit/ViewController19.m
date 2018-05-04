//
//  ViewController19
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//约束

#import "ViewController19.h"
#import <SceneKit/SceneKit.h>
#import "XTJRootDefine.h"
@interface ViewController19 ()
<
SCNSceneRendererDelegate
>
@property(nonatomic,strong)SCNView *scnView;
@property(nonatomic,strong)SCNIKConstraint *ikConstraint;
@end

@implementation ViewController19

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setupScnview];
}

-(void)setupScnview{
    
    SCNScene *scene = [SCNScene scene];
    scene.physicsWorld.gravity = SCNVector3Make(0, 90, 0);//添加一个重力，让其方向朝上
    
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
    cameraNode.position = SCNVector3Make(0, 0, 1000);
    [scene.rootNode addChildNode:cameraNode];
    
    //light
    SCNLight *ambientlight = [SCNLight light];
    ambientlight.type = SCNLightTypeAmbient;
    ambientlight.color = [UIColor grayColor];
    SCNNode *ambientlightNode = [SCNNode node];
    ambientlightNode.light = ambientlight;
    [scnView.scene.rootNode addChildNode:ambientlightNode];
    
    //点光源
    SCNLight *omniLight = [SCNLight light];
    omniLight.type = SCNLightTypeOmni;
    omniLight.color = [UIColor yellowColor];
    
    SCNNode *omniLightNode = [SCNNode node];
    omniLightNode.light = omniLight;
    omniLightNode.position = SCNVector3Make(0, 0, 100);
    
    [scene.rootNode addChildNode:omniLightNode];

    
    //floor
    SCNFloor *floor = [SCNFloor floor];
    floor.firstMaterial.diffuse.contents = ImageFile(@"image/春夏布料");
    floor.width = 100;
    floor.length = 100;

    SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
    floorNode.position = SCNVector3Make(0, 0, 0);
    floorNode.physicsBody = [SCNPhysicsBody staticBody];//静态身体
    [scnView.scene.rootNode addChildNode:floorNode];
    
    //手掌
    SCNNode *handNode = [SCNNode node];
    handNode.geometry = [SCNBox boxWithWidth:20 height:20 length:20 chamferRadius:0];
    handNode.geometry.firstMaterial.diffuse.contents = [UIColor orangeColor];
    handNode.position = SCNVector3Make(0, -100, 0);

    //小手臂
    SCNNode *lowerArm = [SCNNode node];
    lowerArm.geometry = [SCNCylinder cylinderWithRadius:1 height:200];
    lowerArm.geometry.firstMaterial.diffuse.contents = [UIColor redColor];
    lowerArm.position = SCNVector3Make(0, -100, 0);
    lowerArm.pivot = SCNMatrix4MakeTranslation(0, 100, 0);//连接点
    [lowerArm addChildNode:handNode];
    
    /*
     上臂
     注意父node是控制点node,因此设置position是(0,0,0),是将其几何中心点移到父node的几何中心点上
     改变pivot则不会改变其position的值，但视觉上会改变。
     pivot是连接点，视觉位置大概是pivot.y-position.y
     例如这里，如果不设置pivot，则上臂中心点跟控制点中心点重合，设置之后会下移
     */
    SCNNode *upperArm = [SCNNode node];
    upperArm.geometry = [SCNCylinder cylinderWithRadius:1 height:200];
    upperArm.geometry.firstMaterial.diffuse.contents = [UIColor greenColor];
    upperArm.position = SCNVector3Make(0, 0, 0);
    upperArm.pivot = SCNMatrix4MakeTranslation(0, 100, 0);//连接点
    [upperArm addChildNode:lowerArm];


    //控制点 y-100 l-10
    SCNNode *controlNode = [SCNNode node];
    controlNode.geometry = [SCNSphere sphereWithRadius:10];
    controlNode.geometry.firstMaterial.diffuse.contents = [UIColor blueColor];
    controlNode.position = SCNVector3Make(0, 200, 0);
    [controlNode addChildNode:upperArm];
    

    //添加到场景中
    [scnView.scene.rootNode addChildNode:controlNode];
//    scnView.delegate = self;


    //反向运动约束
    SCNIKConstraint *ikContrait = [SCNIKConstraint inverseKinematicsConstraintWithChainRootNode:controlNode];
    
    /*
     影响因子，决定约束的强度，默认1，每一帧渲染都调整；0.5-某些帧不会调整；0-忽略
     SCNTransformConstraint不受约束
     */
    ikContrait.influenceFactor = 1;
    handNode.constraints = @[ikContrait];
    self.ikConstraint = ikContrait;
    
    //SCNLookAtConstraint，锁定某一个node，然后给camera添加约束
    SCNLookAtConstraint *lockAtContrait = [SCNLookAtConstraint lookAtConstraintWithTarget:handNode];
    lockAtContrait.gimbalLockEnabled = YES;//照相机视野保持在水平面上，即沿着y轴跟随目标节点
    cameraNode.constraints = @[lockAtContrait];

    //SCNTransformConstraint
    SCNTransformConstraint *transformConstraint = [SCNTransformConstraint transformConstraintInWorldSpace:YES
                                                                                                withBlock:^SCNMatrix4(SCNNode * _Nonnull node, SCNMatrix4 transform) {
                                                                                                    SCNMatrix4 newMatrix = node.transform;
                                                                                                    if (node.position.y>20) {
                                                                                                        newMatrix.m44= 0.0;
                                                                                                    }
                                                                                                    return newMatrix;
                                                                                                }];
//    handNode.constraints = @[ikContrait,transformConstraint];
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler)];
    [scnView addGestureRecognizer:tap];
    
}

-(void)tapHandler{
    [self createNodeToScene:self.scnView.scene addConstraint:self.ikConstraint];
}

-(void)createNodeToScene:(SCNScene *)scene addConstraint:(SCNIKConstraint *)ikConstrait{
    
    //创建小球
    SCNNode *node = [SCNNode node];
    
    node.position = SCNVector3Make(arc4random_uniform(200), arc4random_uniform(200), arc4random_uniform(200));
    node.geometry = [SCNSphere sphereWithRadius:10];
    node.geometry.firstMaterial.diffuse.contents = [UIColor colorWithRed:arc4random_uniform((255.0)+1)/255.0
                                                                   green:arc4random_uniform((255.0)+1)/255.0
                                                                    blue:arc4random_uniform((255.0)+1)/255.0
                                                                   alpha:1];
    [scene.rootNode addChildNode:node];
    
    //创建动画 当手掌接触到小球时，给小球添加一个动态身体
    [SCNTransaction begin];
    [SCNTransaction setAnimationDuration:0.5];
    ikConstrait.targetPosition = node.position;
    [SCNTransaction commit];
    node.physicsBody = [SCNPhysicsBody dynamicBody];//注意重力朝上，且不能放在创建小球的时候
}

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
