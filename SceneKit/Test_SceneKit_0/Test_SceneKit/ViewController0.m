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
@property(nonatomic,strong)SCNScene *scene;
@property(nonatomic,strong)SCNNode *cameraNode;
@property(nonatomic,strong)SCNNode *camera1;
@property(nonatomic,strong)SCNNode *camera2;

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
    [self setupScene];
}

#pragma mark - init
-(void)setupScene{
    
    //scene 场景
    SCNScene *scene = [SCNScene scene];
    scene.background.contents = ImageFile(@"image/skybox01_cube");
    self.scene = scene;
    
    //light
    [self setupLight];

    //floor
    SCNFloor *floor = [SCNFloor floor];
    floor.firstMaterial.diffuse.contents = ImageFile(@"image/素材1");
    SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
    floorNode.name = @"floorNode";
    floorNode.position = SCNVector3Make(0, 0, 0);
    floorNode.physicsBody = [SCNPhysicsBody staticBody];
    [scene.rootNode addChildNode:floorNode];

    
    //box
    SCNBox *box = [SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];
    box.firstMaterial.diffuse.contents = ImageFile(@"image/婚庆布料");
    SCNNode *boxNode = [SCNNode node];
    boxNode.name = @"boxNode";
    boxNode.geometry = box;
    boxNode.position = SCNVector3Make(0, 0, 30);
    boxNode.physicsBody = [SCNPhysicsBody dynamicBody];
    [scene.rootNode addChildNode:boxNode];

    
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

-(void)setupLight{
    
    SCNLight *ambientlight = [SCNLight light];
    ambientlight.type = SCNLightTypeAmbient;
    ambientlight.color = [UIColor grayColor];
    SCNNode *ambientlightNode = [SCNNode node];
    ambientlightNode.name = @"ambientlightNode";
    ambientlightNode.light = ambientlight;
    [self.scene.rootNode addChildNode:ambientlightNode];
    
    SCNLight *omnilight = [SCNLight light];
    omnilight.type = SCNLightTypeOmni;
    omnilight.color = [UIColor whiteColor];
    SCNNode *omnilightNode = [SCNNode node];
    omnilightNode.name = @"omnilightNode";
    omnilightNode.light = omnilight;
    omnilightNode.position = SCNVector3Make(0, 100, 500);
    [self.scene.rootNode addChildNode:omnilightNode];
}

#pragma mark camera

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
    camera.xFov = 45;
    camera.yFov = 45;
    camera.zFar = 1000;
    camera.zNear = 1;
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.eulerAngles = SCNVector3Zero;
    cameraNode.position = SCNVector3Make(0, 100, 100);
    cameraNode.rotation = SCNVector4Make(1, 0, 0, -M_PI_4);
    self.gameView.pointOfView = cameraNode;
    self.cameraNode = cameraNode;
    self.camera = camera;
    
    _cameraXHandle = [[SCNNode alloc] init];
    _cameraXHandle.position = SCNVector3Make(0, 0, 0);
//    _cameraXHandle.rotation = SCNVector4Make(1.0, 0.0, 0.0, -M_PI_4);
    [_cameraXHandle addChildNode:cameraNode];
    
    _cameraYHandle = [[SCNNode alloc] init];
    _cameraYHandle.position = SCNVector3Make(0, 0, 0);
//    _cameraYHandle.rotation = SCNVector4Make(0.0, 1.0, 0.0, M_PI_2 + M_PI_4 * 3.0);
    [_cameraYHandle addChildNode:_cameraXHandle];
    
    [self.scene.rootNode addChildNode:_cameraYHandle];
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
                                    position:SCNVector3Make(0, 0, 0)];
    
}

#pragma mark - XTJTouchViewDelegate
//平移引起旋转
-(void)touchViewHasPan:(XTJTouchView *)touchView direction:(CGPoint)direction{
    
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
    
    _cameraXHandle.rotation = SCNVector4Make(1, 0, 0, (MAX(-M_PI_2, MIN(0.13, _cameraXHandle.rotation.w + direction.y * F))));
    _cameraYHandle.rotation = SCNVector4Make(0, 1, 0, _cameraYHandle.rotation.y * (_cameraYHandle.rotation.w - direction.x * F));
    
    [SCNTransaction commit];
}

//平移
-(void)touchViewHasMove:(XTJTouchView *)touchView direction:(CGPoint)direction{
    
    [SCNTransaction begin];
    [SCNTransaction setAnimationDuration:0.0];
    [SCNTransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
//    CGFloat x = _cameraYHandle.position.x+direction.x;
    CGFloat x = _cameraXHandle.position.x;
    CGFloat y = _cameraYHandle.position.y-direction.y;
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
    self.camera.xFov = xFov;
    self.camera.yFov = yFov;
}

//双击恢复
-(void)touchViewHasDoubleTap:(XTJTouchView *)touchView{
//    [_cameraYHandle removeFromParentNode];
//    [self setupCamera1];
//
//    [SCNTransaction begin];
//    [SCNTransaction setAnimationDuration:0.5];
//    [SCNTransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
//
//    self.camera.xFov = 45;
//    self.camera.yFov = 45;
//
//    [SCNTransaction commit];
    
    [SCNTransaction begin];
    [SCNTransaction setAnimationDuration:0.5];
    [SCNTransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    self.camera.xFov = 45;
    self.camera.yFov = 45;
    self.cameraNode.position = SCNVector3Make(0, 100, 100);
    self.cameraNode.rotation = SCNVector4Make(1, 0, 0, -M_PI_4);
    _cameraXHandle.position = SCNVector3Zero;
    _cameraXHandle.rotation = SCNVector4Zero;
    _cameraYHandle.position = SCNVector3Zero;
    _cameraYHandle.rotation = SCNVector4Zero;
    
    [SCNTransaction commit];
}
#pragma mark - action
- (IBAction)tap:(id)sender {
    
    
}

- (IBAction)tap1:(id)sender {
    
//    _gameView.pointOfView = self.camera1;
//
//    SCNAction *move = [SCNAction moveTo:SCNVector3Make(0, 30, 50) duration:1];
//    [self.camera1 runAction:move];
    
//    NSLog(@"....%f %f %f %f",self.camera.xFov,self.camera.yFov,self.camera.zNear,self.camera.zFar);
    
    [self loadModel];
}
- (IBAction)tap2:(id)sender {
    
//    _gameView.pointOfView = self.camera2;
//
//    SCNAction *move = [SCNAction moveTo:SCNVector3Make(0, 50, 50) duration:1];
//    [self.camera2 runAction:move];
    
}

- (IBAction)tap3:(id)sender {
    [self.gameView removeFromSuperview];
    [self setupScene];
}

- (IBAction)tap4:(id)sender {
    
}

- (IBAction)tap5:(id)sender {
    
}


@end
