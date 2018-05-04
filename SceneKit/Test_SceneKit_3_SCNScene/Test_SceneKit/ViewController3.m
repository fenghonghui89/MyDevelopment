//
//  ViewController3
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import "ViewController3.h"
#import <SceneKit/SceneKit.h>
#import "XTJRootDefine.h"
@interface ViewController3 ()
{
    SCNView *_scnView;
}
@property(nonatomic,strong)SCNNode *firstViewCamera;
@property(nonatomic,strong)SCNNode *thirdViewCamera;
@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setupScnview];
}

-(void)setupScnview{
    
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/my3dmodel1/untitled.dae"];
    
    SCNView *scnView = [[SCNView alloc] initWithFrame:self.view.bounds];
    scnView.center = self.view.center;
    scnView.scene = scene;
    scnView.backgroundColor = [UIColor blackColor];
//    scnView.allowsCameraControl = YES;
    scnView.antialiasingMode = SCNAntialiasingModeMultisampling4X;//开启抗锯齿
    scnView.showsStatistics = YES;
    scnView.preferredFramesPerSecond = 60;//帧率
    [self.view addSubview:scnView];
    [self.view sendSubviewToBack:scnView];
    _scnView = scnView;
    
    //camera
//    SCNCamera *camera = [SCNCamera camera];
//    SCNNode *cameraNode = [SCNNode node];
//    cameraNode.camera = camera;
//    cameraNode.position = SCNVector3Make(0, 20, 50);
//    [scnView.scene.rootNode addChildNode:cameraNode];
    
    //light
    SCNLight *ambientlight = [SCNLight light];
    ambientlight.type = SCNLightTypeAmbient;
    ambientlight.color = [UIColor grayColor];
    SCNNode *ambientlightNode = [SCNNode node];
    ambientlightNode.light = ambientlight;
    [scnView.scene.rootNode addChildNode:ambientlightNode];
    
    
    //floor
    SCNFloor *floor = [SCNFloor floor];
    floor.firstMaterial.diffuse.contents = ImageFile(@"image/春夏布料");
    floor.width = 100;
    floor.length = 100;
    
    SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
    floorNode.position = SCNVector3Make(0, 0, 0);
    floorNode.physicsBody = [SCNPhysicsBody staticBody];//静态身体
    [scnView.scene.rootNode addChildNode:floorNode];
    
    
    //视角
    self.thirdViewCamera = [SCNNode node];
    self.thirdViewCamera.camera = [SCNCamera camera];
    self.thirdViewCamera.camera.automaticallyAdjustsZRange = YES;
    self.thirdViewCamera.position = SCNVector3Make(0, 20, 50);
    [scnView.scene.rootNode addChildNode:self.thirdViewCamera];

    self.firstViewCamera = [SCNNode node];
    self.firstViewCamera.camera = [SCNCamera camera];
    self.firstViewCamera.camera.automaticallyAdjustsZRange = YES;
    self.firstViewCamera.position = SCNVector3Make(0, 10, 50);
    [scnView.scene.rootNode addChildNode:self.firstViewCamera];

    scnView.pointOfView = self.thirdViewCamera;
    
}


- (IBAction)tap:(id)sender {
    
//    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentPath = [documentDirectory lastObject];
//    NSString *path = [documentPath stringByAppendingPathComponent:@"111.dae"];
//
//    NSURL *url = [NSURL fileURLWithPath:path];
//
//    //This URL must use the file scheme.
//    [_scnView.scene writeToURL:url options:nil delegate:nil progressHandler:^(float totalProgress, NSError * _Nullable error, BOOL * _Nonnull stop) {
//        NSLog(@"....%f",totalProgress);
//    }];
    
    _scnView.pointOfView = self.thirdViewCamera;
    
    SCNAction *move = [SCNAction moveTo:SCNVector3Make(0, 20, 50) duration:1];
    [self.thirdViewCamera runAction:move];
}

- (IBAction)tap1:(id)sender {
    
    _scnView.pointOfView = self.firstViewCamera;
    
    SCNAction *move = [SCNAction moveTo:SCNVector3Make(0, 10, 50) duration:1];
    [self.firstViewCamera runAction:move];
}
@end
