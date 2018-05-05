//
//  ViewController18
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//照相机视角切换

#import "ViewController18.h"
#import "XTJRootDefine.h"
#import "AAPLGameViewControllerPrivate.h"

@interface ViewController18 ()
@property(nonatomic,strong)SCNNode *camera;
@property(nonatomic,strong)SCNNode *camera1;
@property(nonatomic,strong)SCNNode *camera2;
@end

@implementation ViewController18

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setupScene];
}


-(void)setupScene{
    
    //scene 场景
    SCNScene *scene = [SCNScene sceneNamed:@"game.scnassets/level.scn"];
    
    //SCNView
    SCNView *scnView = [[SCNView alloc] initWithFrame:self.view.bounds];
    scnView.center = self.view.center;
    scnView.scene = scene;
    scnView.backgroundColor = [UIColor blackColor];
    scnView.antialiasingMode = SCNAntialiasingModeMultisampling4X;//开启抗锯齿
    scnView.showsStatistics = YES;
    scnView.preferredFramesPerSecond = 60;//帧率
    [self.view addSubview:scnView];
    [self.view sendSubviewToBack:scnView];
    _gameView = scnView;
    
    //light
    SCNLight *ambientlight = [SCNLight light];
    ambientlight.type = SCNLightTypeAmbient;
    ambientlight.color = [UIColor grayColor];
    SCNNode *ambientlightNode = [SCNNode node];
    ambientlightNode.light = ambientlight;
    [scene.rootNode addChildNode:ambientlightNode];
    
    //模型
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"XTJMaterial" ofType:@"bundle"];
    filePath = [filePath stringByAppendingPathComponent:@"3d/my3dmodel1/file.dae"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    SCNSceneSource *sceneSource = [SCNSceneSource sceneSourceWithURL:url options:nil];
    SCNNode *modelNode = [sceneSource entryWithIdentifier:@"SubDragonLE_Shape" withClass:[SCNNode class]];
    [scene.rootNode addChildNode:modelNode];
    
    //设置camera
    [self setupCamera];
    
    //添加额外的camera 未调通
//    [self addOtherCamera];

}



-(void)addOtherCamera{
    
    //初始camera
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 10, 50);
    [self.gameView.scene.rootNode addChildNode:cameraNode];
    self.camera = cameraNode;
    
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

#pragma mark - Managing the Camera

- (void)panCamera:(CGPoint)direction {

    direction.y *= -1.0;

    static const CGFloat F = 0.005;

    // Make sure the camera handles are correctly reset (because automatic camera animations may have put the "rotation" in a weird state.
    [SCNTransaction begin];
    [SCNTransaction setAnimationDuration:0.0];

    [_cameraYHandle removeAllActions];
    [_cameraXHandle removeAllActions];

    if (_cameraYHandle.rotation.y < 0) {
        _cameraYHandle.rotation = SCNVector4Make(0, 1, 0, -_cameraYHandle.rotation.w);
    }

    if (_cameraXHandle.rotation.x < 0) {
        _cameraXHandle.rotation = SCNVector4Make(1, 0, 0, -_cameraXHandle.rotation.w);
    }

    [SCNTransaction commit];

    // Update the camera position with some inertia. 必须
    [SCNTransaction begin];
    [SCNTransaction setAnimationDuration:0.5];
    [SCNTransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];

    _cameraYHandle.rotation = SCNVector4Make(0, 1, 0, _cameraYHandle.rotation.y * (_cameraYHandle.rotation.w - direction.x * F));
    _cameraXHandle.rotation = SCNVector4Make(1, 0, 0, (MAX(-M_PI_2, MIN(0.13, _cameraXHandle.rotation.w + direction.y * F))));

    [SCNTransaction commit];
}

- (void)setupCamera {
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
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.eulerAngles = SCNVector3Zero;
    cameraNode.position = SCNVector3Make(0.0, 0.0, DISTANCE);
    self.gameView.pointOfView = cameraNode;

    _cameraXHandle = [[SCNNode alloc] init];
    _cameraXHandle.rotation = SCNVector4Make(1.0, 0.0, 0.0, -M_PI_4 * 0.125);
    [_cameraXHandle addChildNode:cameraNode];

    _cameraYHandle = [[SCNNode alloc] init];
    _cameraYHandle.position = SCNVector3Make(0.0, ALTITUDE, 0.0);
    _cameraYHandle.rotation = SCNVector4Make(0.0, 1.0, 0.0, M_PI_2 + M_PI_4 * 3.0);
    [_cameraYHandle addChildNode:_cameraXHandle];

    [self.gameView.scene.rootNode addChildNode:_cameraYHandle];
}

#pragma mark - < action >
- (IBAction)tap:(id)sender {
    
    _gameView.pointOfView = self.camera;
    
    SCNAction *move = [SCNAction moveTo:SCNVector3Make(0, 10, 50) duration:1];
    [self.camera runAction:move];
}

- (IBAction)tap1:(id)sender {
    
    _gameView.pointOfView = self.camera1;
    
    SCNAction *move = [SCNAction moveTo:SCNVector3Make(0, 30, 50) duration:1];
    [self.camera1 runAction:move];
}
- (IBAction)tap2:(id)sender {
    
//    _gameView.pointOfView = self.camera2;
//
//    SCNAction *move = [SCNAction moveTo:SCNVector3Make(0, 50, 50) duration:1];
//    [self.camera2 runAction:move];
    
    [self.gameView removeFromSuperview];
    [self setupScene];
}

@end