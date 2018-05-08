//
//  ViewController0
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import "ViewController0.h"
#import <SceneKit/SceneKit.h>
#import "XTJRootDefine.h"
@interface ViewController0 ()
@property(nonatomic,strong)SCNScene *scene;
@property(nonatomic,strong)SCNView *scnView;
@end

@implementation ViewController0

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setupScnview];
}

#pragma mark - < method >
-(void)setupScnview{
    
    //scene
    SCNScene *scene = [SCNScene scene];
    scene.background.contents = ImageFile(@"image/skybox01_cube");
    self.scene = scene;

//    //camera
//    SCNCamera *camera = [SCNCamera camera];
//    camera.automaticallyAdjustsZRange = YES;
//
//    SCNNode *cameraNode = [SCNNode node];
//    cameraNode.camera = camera;
//    cameraNode.position = SCNVector3Make(0, 100, 50);
//    cameraNode.rotation = SCNVector4Make(1, 0, 0, -M_PI_4);
//    [scene.rootNode addChildNode:cameraNode];
//
//    //light
//    SCNLight *ambientlight = [SCNLight light];
//    ambientlight.type = SCNLightTypeAmbient;
//    ambientlight.color = [UIColor grayColor];
//    SCNNode *ambientlightNode = [SCNNode node];
//    ambientlightNode.light = ambientlight;
//    [scene.rootNode addChildNode:ambientlightNode];
//
//    //floor
//    SCNFloor *floor = [SCNFloor floor];
//    floor.firstMaterial.diffuse.contents = ImageFile(@"image/素材1");
//    SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
//    floorNode.position = SCNVector3Make(0, 0, 0);
//    floorNode.physicsBody = [SCNPhysicsBody staticBody];//静态身体
//    [scene.rootNode addChildNode:floorNode];
    
    //model
    SCNScene *scene_model = [SCNScene sceneNamed:@"SceneKit Scene.scn"];
    [scene.rootNode addChildNode:scene_model.rootNode];
    
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
}



#pragma mark - < action >
- (IBAction)tap:(id)sender {
    
}

- (IBAction)tap1:(id)sender {
   
}
@end
