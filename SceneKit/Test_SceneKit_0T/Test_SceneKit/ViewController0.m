//
//  ViewController0
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//照相机视角切换

#import "ViewController0.h"
#import "XTJRootDefine.h"
#import "AAPLGameViewControllerPrivate.h"
#import "XTJ3DManager.h"
#import "XTJTouchView.h"

@interface ViewController0 ()
<
XTJTouchViewDelegate
>
{
    CGFloat camera_xFov;
    CGFloat camera_yFov;
    
    SCNVector3 cameraNode_position;
    SCNVector4 cameraNode_rotation;
    
    SCNVector3 cameraXHandle_position;
    SCNVector4 cameraXHandle_rotation;
    SCNVector3 cameraYHandle_position;
    SCNVector4 cameraYHandle_rotation;
}
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;
@property (weak, nonatomic) IBOutlet UIButton *btn7;

@property(nonatomic,strong)SCNScene *scene;
@property(nonatomic,strong)SCNNode *cameraNode;
@property(nonatomic,strong)SCNNode *camera1;
@property(nonatomic,strong)SCNNode *camera2;
@property(nonatomic,strong)SCNNode *boxNode;
@property(nonatomic,strong)SCNCamera *camera;
@end

@implementation ViewController0

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *doucumentsPath = [XTJTool doucumentsPath];
    NSLog(@"doucumentsPath path...%@",doucumentsPath);
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self customInit];
}

#pragma mark - init
-(void)customInit{
    
    [self.btn setTitle:@"人体" forState:UIControlStateNormal];
    [self.btn1 setTitle:@"长袖" forState:UIControlStateNormal];
    [self.btn2 setTitle:@"短袖" forState:UIControlStateNormal];
    [self.btn3 setTitle:@"短裤" forState:UIControlStateNormal];
    [self.btn4 setTitle:@"长裤" forState:UIControlStateNormal];
    [self.btn5 setTitle:@"鞋子" forState:UIControlStateNormal];
    [self.btn6 setTitle:@"换面料" forState:UIControlStateNormal];
    [self.btn7 setTitle:@"重置" forState:UIControlStateNormal];
    
    
    [self customInitData];
    [self setupScene];
}

-(void)customInitData{
    
    //实际
    camera_xFov = 52.5;
    camera_yFov = 52.5;
    cameraNode_position = SCNVector3Make(0, 50, 100);
    cameraNode_rotation = SCNVector4Zero;
    cameraXHandle_position = SCNVector3Zero;
    cameraXHandle_rotation = SCNVector4Make(1, 0, 0, -0.08);
    cameraYHandle_position = SCNVector3Zero;
    cameraYHandle_rotation = SCNVector4Make(0, 1, 0, 6.85);
    
    //测试 正对
//    camera_xFov = 53;
//    camera_yFov = 53;
//    cameraNode_position = SCNVector3Make(0, 50, 100);
//    cameraNode_rotation = SCNVector4Zero;
//    cameraXHandle_position = SCNVector3Zero;
//    cameraXHandle_rotation = SCNVector4Zero;
//    cameraYHandle_position = SCNVector3Zero;
//    cameraYHandle_rotation = SCNVector4Zero;
    
    //实际
//    camera_xFov = 52.5;
//    camera_yFov = 52.5;
//    cameraNode_position = SCNVector3Make(0, 50, 100);
//    cameraNode_rotation = SCNVector4Zero;
//    cameraXHandle_position = SCNVector3Zero;
//    cameraXHandle_rotation = SCNVector4Zero;
//    cameraYHandle_position = SCNVector3Zero;
//    cameraYHandle_rotation = SCNVector4Zero;
}

#pragma mark - scene
-(void)setupScene{
    
    //scene 场景
    SCNScene *scene = [SCNScene scene];
//    scene.background.contents = ImageFile(@"image/skybox01_cube");
    scene.background.contents = ImageFile(@"image/img_skybox");
    self.scene = scene;
    
    //floor
    SCNFloor *floor = [SCNFloor floor];
    floor.reflectivity = 0;
    floor.width = 170;
    floor.length = 200;
    floor.firstMaterial.diffuse.contents = ImageFile(@"image/素材2");
    SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
    floorNode.name = @"floorNode";
    floorNode.position = SCNVector3Make(0, 0, 0);
    floorNode.physicsBody = [SCNPhysicsBody staticBody];
    [scene.rootNode addChildNode:floorNode];

    //box
//    SCNBox *box = [SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];
//    box.firstMaterial.diffuse.contents = ImageFile(@"image/婚庆布料");
//    SCNNode *boxNode = [SCNNode node];
//    boxNode.castsShadow = YES;
//    boxNode.name = @"boxNode";
//    boxNode.geometry = box;
//    boxNode.position = SCNVector3Make(0, 0, 0);
//    boxNode.physicsBody = [SCNPhysicsBody dynamicBody];
//    [scene.rootNode addChildNode:boxNode];
//    self.boxNode = boxNode;
    
    //light
    [self setupLight];
    
    //camera
    [self setupCamera1];
    
    //添加额外的camera 未调通
//    [self addOtherCamera];
    
    //SCNView
    SCNView *scnView = [[SCNView alloc] initWithFrame:self.view.bounds];
    scnView.center = self.view.center;
    scnView.scene = scene;
    scnView.backgroundColor = [UIColor blackColor];
    scnView.antialiasingMode = SCNAntialiasingModeMultisampling4X;//开启抗锯齿
    scnView.showsStatistics = YES;
//    scnView.allowsCameraControl = YES;
    scnView.preferredFramesPerSecond = 60;//帧率
    [self.view addSubview:scnView];
    self.gameView = scnView;
    
    //touch view
    XTJTouchView *touchView = [[XTJTouchView alloc] initWithFrame:self.view.bounds];
    touchView.userInteractionEnabled = YES;
    touchView.delegate = self;
    [self.view addSubview:touchView];

    [self.view sendSubviewToBack:touchView];
    [self.view sendSubviewToBack:scnView];
    
}

#pragma mark - light
-(void)setupLight{
    
    SCNLight *ambientlight = [SCNLight light];
    ambientlight.type = SCNLightTypeAmbient;
    ambientlight.color = [UIColor grayColor];
    SCNNode *ambientlightNode = [SCNNode node];
    ambientlightNode.name = @"ambientlightNode";
    ambientlightNode.light = ambientlight;
    [self.scene.rootNode addChildNode:ambientlightNode];
    
//    SCNLight *omnilight = [SCNLight light];
//    omnilight.type = SCNLightTypeOmni;
//    omnilight.color = [UIColor whiteColor];
//    SCNNode *omnilightNode = [SCNNode node];
//    omnilightNode.name = @"omnilightNode";
//    omnilightNode.light = omnilight;
//    omnilightNode.position = SCNVector3Make(0, 100, 500);
//    [self.scene.rootNode addChildNode:omnilightNode];

    SCNLight *omnilight1 = [SCNLight light];
    omnilight1.type = SCNLightTypeOmni;
    omnilight1.color = [UIColor whiteColor];
    SCNNode *omnilightNode1 = [SCNNode node];
    omnilightNode1.name = @"omnilightNode1";
    omnilightNode1.light = omnilight1;
    omnilightNode1.position = SCNVector3Make(0, 100, -1000);
    [self.scene.rootNode addChildNode:omnilightNode1];
    
    [self shadowLight1];
}

-(void)shadowLight{
    
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
    light.spotOuterAngle = 45;//光照范围的角度
    light.zFar = 2000;//光照射的最远距离
    light.shadowSampleCount = 16;
    //    light.attenuationStartDistance = 90;
    //    light.attenuationEndDistance = 200;
    //    light.attenuationFalloffExponent = 2;//衰减曲线
    
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
    handleSpot.position = SCNVector3Make(0, 200, 100);
        handleSpot.rotation = SCNVector4Make(1, 0, 0, -M_PI_4);
    [handleSpot addChildNode:spotLight];
    [self.scene.rootNode addChildNode:handleSpot];
    
    //动作
    //    SCNAction *moveRight = [SCNAction moveTo:SCNVector3Make(100, 500, 0) duration:2];
    //    SCNAction *moveLeft = [SCNAction moveTo:SCNVector3Make(-100, 500, 0) duration:2];
    //    SCNAction *sequence = [SCNAction sequence:@[moveRight,moveLeft]];
    //
    //    [handleSpot runAction:[SCNAction repeatActionForever:sequence]];
    
    //添加约束 使光的方向指向几何体
    SCNLookAtConstraint *constaint = [SCNLookAtConstraint lookAtConstraintWithTarget:self.boxNode];
    spotLight.constraints = @[constaint];
}



-(void)shadowLight1{

    //平行光
    SCNLight *light = [SCNLight light];
    light.type = SCNLightTypeDirectional;
    light.color = [UIColor whiteColor];
    light.castsShadow = YES;
    light.shadowMode = SCNShadowModeForward;//设置这个后灯光的阴影效果才能呈现
    light.shadowSampleCount = 16;
//    light.automaticallyAdjustsShadowProjection = YES;
//    light.spotOuterAngle = 45;//光照范围的角度
//    light.zFar = 2000;//光照射的最远距离
    //    light.attenuationStartDistance = 90;
    //    light.attenuationEndDistance = 200;
    //    light.attenuationFalloffExponent = 2;//衰减曲线
    
    //灯光node
    SCNNode *spotLight = [SCNNode node];
    spotLight.light = light;
    spotLight.position = SCNVector3Make(0, 0, 0);
    spotLight.rotation = SCNVector4Make(1, 0, 0, 74.9);//74~75最佳
    spotLight.scale = SCNVector3Make(10, 10, 10);
    [self.scene.rootNode addChildNode:spotLight];

}

-(void)shadowLight2{
    
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
    light.spotOuterAngle = 45;//光照范围的角度
    light.zFar = 2000;//光照射的最远距离
    light.shadowSampleCount = 16;
    //    light.attenuationStartDistance = 90;
    //    light.attenuationEndDistance = 200;
    //    light.attenuationFalloffExponent = 2;//衰减曲线
    
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
    handleSpot.position = SCNVector3Make(0, 200, 100);
    handleSpot.rotation = SCNVector4Make(1, 0, 0, -M_PI_4);
    [handleSpot addChildNode:spotLight];
    [self.scene.rootNode addChildNode:handleSpot];
    
}

//左下往右上打光
-(void)assistantLight{
    
    //圆锥体做灯罩
    SCNCone *cone = [SCNCone coneWithTopRadius:1 bottomRadius:25 height:50];
    cone.radialSegmentCount = 10;
    cone.heightSegmentCount = 5;
    cone.firstMaterial.emission.contents = [UIColor yellowColor];
    
    //聚焦光
    SCNLight *light1 = [SCNLight light];
    light1.type = SCNLightTypeSpot;
    light1.castsShadow = YES;
    light1.shadowMode = SCNShadowModeForward;//设置这个后灯光的阴影效果才能呈现
    light1.spotOuterAngle = 45;//光照范围的角度
    light1.zFar = 2000;//光照射的最远距离
    //    light.attenuationStartDistance = 90;
    //    light.attenuationEndDistance = 200;
    //    light.attenuationFalloffExponent = 2;//衰减曲线
    
    //灯光node
    SCNNode *spotLight1 = [SCNNode node];
    spotLight1.geometry = cone;
    spotLight1.position = SCNVector3Make(0, 0, 0);
    spotLight1.light = light1;
    
    /*
     支点 用来控制灯光node的移动
     如果不加，然后把动作加到灯光node，会发现灯光不会移动
     */
    SCNNode *handleSpot1 = [SCNNode node];
    handleSpot1.position = SCNVector3Make(-100, 0, 100);
    //    handleSpot.rotation = SCNVector4Make(1, 0, 0, -M_PI_4);
    [handleSpot1 addChildNode:spotLight1];
    [self.scene.rootNode addChildNode:handleSpot1];
    
    //动作
    //    SCNAction *moveRight = [SCNAction moveTo:SCNVector3Make(100, 500, 0) duration:2];
    //    SCNAction *moveLeft = [SCNAction moveTo:SCNVector3Make(-100, 500, 0) duration:2];
    //    SCNAction *sequence = [SCNAction sequence:@[moveRight,moveLeft]];
    //
    //    [handleSpot runAction:[SCNAction repeatActionForever:sequence]];
    
    //添加约束 使光的方向指向几何体
    SCNLookAtConstraint *constaint1 = [SCNLookAtConstraint lookAtConstraintWithTarget:self.boxNode];
    spotLight1.constraints = @[constaint1];
}

#pragma mark - camera

-(void)setupCamera {
    static CGFloat const ALTITUDE = 1.0;
    static CGFloat const DISTANCE = 10.0;
    
    // We create 2 nodes to manipulate the camera:
    // The first node "_cameraXHandle" is at the center of the world (0, ALTITUDE, 0) and will only rotate on the X axis
    // The second node "_cameraYHandle" is a child of the first one and will ony rotate on the Y axis
    // The camera node is a child of the "_cameraYHandle" at a specific distance (DISTANCE).
    // So rotating _cameraYHandle and _cameraXHandle will update the camera position and the camera will always look at the center of the scene.
    
    //官方 因为scn文件已经包含一个camera 所以pointOfView有值
//    SCNNode *pov = self.gameView.pointOfView;
//    pov.eulerAngles = SCNVector3Zero;
//    pov.position = SCNVector3Make(0.0, 0.0, DISTANCE);
    
    //新建一个camera 代替系统默认的 也可以
    SCNCamera *camera = [SCNCamera camera];
    camera.xFov = 45;
    camera.yFov = 45;
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.eulerAngles = SCNVector3Zero;
    cameraNode.position = SCNVector3Make(0.0, 0.0, DISTANCE);
    self.gameView.pointOfView = cameraNode;
    self.cameraNode = cameraNode;
    self.camera = camera;

    _cameraXHandle = [[SCNNode alloc] init];
    _cameraXHandle.rotation = SCNVector4Make(1.0, 0.0, 0.0, -M_PI_4 * 0.125);
    [_cameraXHandle addChildNode:cameraNode];

    _cameraYHandle = [[SCNNode alloc] init];
    _cameraYHandle.position = SCNVector3Make(0, ALTITUDE, 0);
    _cameraYHandle.rotation = SCNVector4Make(0.0, 1.0, 0.0, M_PI_2 + M_PI_4 * 3.0);
    [_cameraYHandle addChildNode:_cameraXHandle];

    [self.scene.rootNode addChildNode:_cameraYHandle];
}

- (void)setupCamera1 {
    
    SCNCamera *camera = [SCNCamera camera];
    camera.xFov = camera_xFov;
    camera.yFov = camera_yFov;
    camera.zFar = 1000;
    camera.zNear = 1;
//    camera.automaticallyAdjustsZRange = YES;
//    camera.usesOrthographicProjection = YES;
    
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.eulerAngles = SCNVector3Zero;
    cameraNode.position = cameraNode_position;
    cameraNode.rotation = cameraNode_rotation;
    self.gameView.pointOfView = cameraNode;
    self.cameraNode = cameraNode;
    self.camera = camera;
    
    _cameraXHandle = [[SCNNode alloc] init];
    _cameraXHandle.position = cameraXHandle_position;
    _cameraXHandle.rotation = cameraXHandle_rotation;
    [_cameraXHandle addChildNode:cameraNode];
    
    _cameraYHandle = [[SCNNode alloc] init];
    _cameraYHandle.position = cameraYHandle_position;
    _cameraYHandle.rotation = cameraYHandle_rotation;
    [_cameraYHandle addChildNode:_cameraXHandle];
    
    [self.scene.rootNode addChildNode:_cameraYHandle];
}

- (void)setupCamera2 {
    
    SCNCamera *camera = [SCNCamera camera];
    camera.xFov = camera_xFov;
    camera.yFov = camera_yFov;
    camera.zFar = 1000;
    camera.zNear = 1;
    //    camera.automaticallyAdjustsZRange = YES;
    //    camera.usesOrthographicProjection = YES;
    
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.eulerAngles = SCNVector3Zero;
    cameraNode.position = cameraNode_position;
    cameraNode.rotation = cameraNode_rotation;
   
    [self.scene.rootNode addChildNode:cameraNode];
}

-(void)addOtherCamera{
    
    //初始camera
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 10, 50);
    [self.gameView.scene.rootNode addChildNode:cameraNode];
    self.cameraNode = cameraNode;
    
    //其他视角 camear
    self.camera1 = [SCNNode node];
    self.camera1.camera = [SCNCamera camera];
    self.camera1.camera.automaticallyAdjustsZRange = YES;
    self.camera1.position = SCNVector3Make(0, 30, 50);
    [self.gameView.scene.rootNode addChildNode:self.camera1];
    
    self.camera2 = [SCNNode node];
    self.camera2.camera = [SCNCamera camera];
    self.camera2.camera.automaticallyAdjustsZRange = YES;
    self.camera2.position = SCNVector3Make(0, 50, 50);
    [self.gameView.scene.rootNode addChildNode:self.camera2];
    
    //    //决定先用哪个
    //    self.gameView.pointOfView = self.camera;
}

#pragma mark - model
-(void)loadModel{
    
    [[XTJ3DManager sharedInstance] loadModel:self.scene.rootNode
                                    isLoacal:YES
                                    fileName:@"man.obj"
                                     dicPath:@"3d/fffff"
                                       sacle:SCNVector3Make(0.5, 0.5, 0.5)
                                    position:SCNVector3Make(0, 0, 0)
                               lightingModel:SCNLightingModelLambert];
    
}

#pragma mark - XTJTouchViewDelegate
//平移引起旋转
-(void)touchViewHasPan:(XTJTouchView *)touchView direction:(CGPoint)direction{
    
    /*
     上滑 坐标系中y变负 但摄像机应该仰视 所以变为正 -> 角度改变量为正
     下滑 坐标系中y变正 但摄像机应该俯视 所以变为负 -> 角度改变量为负
     */
    direction.y *= -1.0;
    static const CGFloat F = 0.005;
    
    // Make sure the camera handles are correctly reset (because automatic camera animations may have put the "rotation" in a weird state.
    [SCNTransaction begin];
    [SCNTransaction setAnimationDuration:0.0];
    
    [_cameraYHandle removeAllActions];
    [_cameraXHandle removeAllActions];
    
    if (_cameraXHandle.rotation.x < 0) {
        _cameraXHandle.rotation = SCNVector4Make(1, 0, 0, -_cameraXHandle.rotation.w);
    }

    if (_cameraYHandle.rotation.y < 0) {
        _cameraYHandle.rotation = SCNVector4Make(0, 1, 0, -_cameraYHandle.rotation.w);
    }
    
    [SCNTransaction commit];
    
    // Update the camera position with some inertia. 必须
    [SCNTransaction begin];
    [SCNTransaction setAnimationDuration:0.5];
    [SCNTransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    //影响沿x轴上下旋转
    //-1.0 0.45
    CGFloat x_rotation = _cameraXHandle.rotation.w + direction.y * F;
    if (x_rotation<-1.0) {
        x_rotation = -1.0;
    }else if(x_rotation>0.20){
        x_rotation = 0.20;
    }
//    x_rotation = MIN(0.13, _cameraXHandle.rotation.w + direction.y * F);
//    x_rotation = MAX(-M_PI_2, MIN(0.13, _cameraXHandle.rotation.w + direction.y * F));
    _cameraXHandle.rotation = SCNVector4Make(1, 0, 0, x_rotation);
    
    //影响沿y轴左右旋转 改变量为x轴的改变量 因为视角跟值的改变是相反的所以为负
//    CGFloat y_rotation = _cameraYHandle.rotation.y * (_cameraYHandle.rotation.w - direction.x * F);
    CGFloat y_rotation = (_cameraYHandle.rotation.w - direction.x * F);
    _cameraYHandle.rotation = SCNVector4Make(0, 1, 0, y_rotation);
    
    [SCNTransaction commit];
    
//    NSLog(@"平移引起旋转..%f %f",x_rotation,y_rotation);
}

//平移
-(void)touchViewHasMove:(XTJTouchView *)touchView direction:(CGPoint)direction{
    
    [SCNTransaction begin];
    [SCNTransaction setAnimationDuration:0.0];
    [SCNTransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
//    CGFloat x = _cameraYHandle.position.x+direction.x;
    CGFloat x = _cameraXHandle.position.x;
    
    //-26.0 28
    CGFloat y = direction.y*0.05;
    y = _cameraYHandle.position.y + y;
    if (y<-26.0) {
        y = -26.0;
    }else if(y>28){
        y = 28.0;
    }
//    NSLog(@"y...%f",y);
    
    CGFloat z = _cameraYHandle.position.z;
    
    _cameraYHandle.position = SCNVector3Make(x, y, z);
    
    [SCNTransaction commit];
}

//开始缩放
-(void)touchView:(XTJTouchView *)touchView pinchStartWithXFov:(void (^)(CGFloat))xFovBlock yFov:(void (^)(CGFloat))yFovBlock{
    xFovBlock(self.camera.xFov);
    yFovBlock(self.camera.yFov);
}

//缩放中
-(void)touchView:(XTJTouchView *)touchView pinchingWithXFov:(CGFloat)xFov yFov:(CGFloat)yFov{
//    NSLog(@"缩放中..%f %f",xFov,yFov);
    self.camera.xFov = xFov;
    self.camera.yFov = yFov;
}

//双击恢复
-(void)touchViewHasDoubleTap:(XTJTouchView *)touchView{
    
    NSLog(@"双击恢复。。");
    
    [SCNTransaction begin];
    [SCNTransaction setAnimationDuration:0];
    [SCNTransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    self.camera.xFov = camera_xFov;
    self.camera.yFov = camera_yFov;
    self.cameraNode.position = cameraNode_position;
    self.cameraNode.rotation = cameraNode_rotation;
    _cameraXHandle.position = cameraXHandle_position;
    _cameraXHandle.rotation = cameraXHandle_rotation;
    _cameraYHandle.position = cameraYHandle_position;
    _cameraYHandle.rotation = cameraYHandle_rotation;
    
    [SCNTransaction commit];
}
#pragma mark - action
- (IBAction)tap:(id)sender {
    
    [[XTJ3DManager sharedInstance] loadModel:self.scene.rootNode
                                     dicPath:@"3d/Project/man"
                                       sacle:SCNVector3Make(0.5, 0.5, 0.5)
                                    position:SCNVector3Make(0, 0, 0)
                               lightingModel:SCNLightingModelBlinn];

}

- (IBAction)tap1:(id)sender {
    
//    _gameView.pointOfView = self.camera1;
//
//    SCNAction *move = [SCNAction moveTo:SCNVector3Make(0, 30, 50) duration:1];
//    [self.camera1 runAction:move];
    
//    NSLog(@"....%f %f %f %f",self.camera.xFov,self.camera.yFov,self.camera.zNear,self.camera.zFar);
    
//    [self loadModel];
    
    [[XTJ3DManager sharedInstance] loadModel:self.scene.rootNode
                                     dicPath:@"3d/Project/shirtLong"
                                       sacle:SCNVector3Make(0.5, 0.5, 0.5)
                                    position:SCNVector3Make(0, 0, 0)
                               lightingModel:SCNLightingModelLambert];

    
    
}
- (IBAction)tap2:(id)sender {
    
//    _gameView.pointOfView = self.camera2;
//
//    SCNAction *move = [SCNAction moveTo:SCNVector3Make(0, 50, 50) duration:1];
//    [self.camera2 runAction:move];

//    [[XTJ3DManager sharedInstance] loadModel:self.scene.rootNode
//                                     dicPath:@"3d/trousers"
//                                       sacle:SCNVector3Make(0.5, 0.5, 0.5)
//                                    position:SCNVector3Make(0, 0, 0)
//                               lightingModel:SCNLightingModelLambert];
    
    [[XTJ3DManager sharedInstance] loadModel:self.scene.rootNode
                                     dicPath:@"3d/Project/shirtShort"
                                       sacle:SCNVector3Make(0.5, 0.5, 0.5)
                                    position:SCNVector3Make(0, 0, 0)
                               lightingModel:SCNLightingModelLambert];
}

- (IBAction)tap3:(id)sender {
    [[XTJ3DManager sharedInstance] loadModel:self.scene.rootNode
                                     dicPath:@"3d/Project/shorts"
                                       sacle:SCNVector3Make(0.5, 0.5, 0.5)
                                    position:SCNVector3Make(0, 0, 0)
                               lightingModel:SCNLightingModelLambert];
}

- (IBAction)tap4:(id)sender {
    
    [[XTJ3DManager sharedInstance] loadModel:self.scene.rootNode
                                     dicPath:@"3d/Project/trousers"
                                       sacle:SCNVector3Make(0.5, 0.5, 0.5)
                                    position:SCNVector3Make(0, 0, 0)
                               lightingModel:SCNLightingModelLambert];
    
}

- (IBAction)tap5:(id)sender {
    [[XTJ3DManager sharedInstance] loadModel:self.scene.rootNode
                                     dicPath:@"3d/Project/shose"
                                       sacle:SCNVector3Make(0.5, 0.5, 0.5)
                                    position:SCNVector3Make(0, 0, 0)
                               lightingModel:SCNLightingModelLambert];
    
}

- (IBAction)tap6:(id)sender {
    
    
    [[XTJ3DManager sharedInstance] changeMaterial:self.scene.rootNode
                                      targetModel:@"shit_Longshirt"
                                   targetMaterial:@"Longshirt"
                                           change:ImageFile3d(@"3d/Project/shirt/map_Kd_Longshirt_diffuse.tga")];
    
    [[XTJ3DManager sharedInstance] changeMaterial:self.scene.rootNode
                                      targetModel:@"LongShirt_Longshirt"
                                   targetMaterial:@"Longshirt"
                                           change:ImageFile3d(@"3d/Project/shirt/map_Kd_Longshirt_diffuse.tga")];
    
    [[XTJ3DManager sharedInstance] changeMaterial:self.scene.rootNode
                                      targetModel:@"Collar_y_Longshirt"
                                   targetMaterial:@"Longshirt"
                                           change:ImageFile3d(@"3d/Project/shirt/map_Kd_Longshirt_diffuse.tga")];
    
    [[XTJ3DManager sharedInstance] changeMaterial:self.scene.rootNode
                                      targetModel:@"Collar_Longshirt"
                                   targetMaterial:@"Longshirt"
                                           change:ImageFile3d(@"3d/Project/shirt/map_Kd_Longshirt_diffuse.tga")];
}

- (IBAction)tap7:(id)sender {
    [self.gameView removeFromSuperview];
    [self customInit];
}


@end
