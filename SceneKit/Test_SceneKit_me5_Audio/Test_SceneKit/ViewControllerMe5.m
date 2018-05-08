//
//  ViewControllerMe5
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import "ViewControllerMe5.h"
#import <SceneKit/SceneKit.h>
#import "XTJRootDefine.h"
@interface ViewControllerMe5 ()
@property(nonatomic,strong)SCNScene *scene;
@property(nonatomic,strong)SCNView *scnView;
@end

@implementation ViewControllerMe5

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setupScnview];
}

#pragma mark -  method
-(void)setupScnview{
    
    //scene
    SCNScene *scene = [SCNScene scene];
    scene.background.contents = ImageFile(@"image/skybox01_cube");
    self.scene = scene;

    //camera
    SCNCamera *camera = [SCNCamera camera];
    camera.automaticallyAdjustsZRange = YES;

    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 100, 50);
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
    
    //scnview
    SCNView *scnView = [[SCNView alloc] initWithFrame:self.view.bounds];
    scnView.center = self.view.center;
    scnView.scene = scene;
    scnView.backgroundColor = [UIColor blackColor];
    scnView.allowsCameraControl = YES;
    scnView.antialiasingMode = SCNAntialiasingModeMultisampling4X;//开启抗锯齿
    scnView.showsStatistics = YES;
    scnView.preferredFramesPerSecond = 60;//帧率
    scnView.playing = YES;
    [self.view addSubview:scnView];
    [self.view sendSubviewToBack:scnView];
    self.scnView = scnView;
}

-(void)avdio{
    
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"XTJMaterial" withExtension:@"bundle"];
    NSURL *fileURL = [bundleURL URLByAppendingPathComponent:@"music/鼓掌.mp3"];
    SCNAudioSource *music = [[SCNAudioSource alloc] initWithURL:fileURL];
    //音量
    music.volume = 0.3;
    //循环播放
    music.loops = NO;
    //流读取
    music.shouldStream = YES;
    //空间化(是否随位置不同有3D效果)
    music.positional = NO;
    
    SCNAudioPlayer *player = [SCNAudioPlayer audioPlayerWithSource:music];
    [self.scene.rootNode addAudioPlayer:player];
}

#pragma mark - < action >
- (IBAction)tap:(id)sender {
    [self avdio];
}

- (IBAction)tap1:(id)sender {
   
}
@end
