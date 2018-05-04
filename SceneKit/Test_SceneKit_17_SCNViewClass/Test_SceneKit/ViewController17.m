//
//  ViewController17
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
// SCNView方法属性

#import "ViewController17.h"
#import <SceneKit/SceneKit.h>
#import "XTJRootDefine.h"
@interface ViewController17 ()

@property(nonatomic,strong)SCNView *scnView;
@end

@implementation ViewController17

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setupScnview];
}

-(void)setupScnview{
    
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/my3dmodel1/untitled.dae"];
    
    /*
     选择渲染模式
     SCNPreferredRenderingAPIKey - opengl value代表api版本 1/2/3
     SCNPreferLowPowerDeviceKey - metal value代表开关 yes or no
     */
    SCNView *scnView = [[SCNView alloc] initWithFrame:self.view.bounds options:@{SCNPreferredRenderingAPIKey:@(3)}];
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
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 20, 50);
    [scene.rootNode addChildNode:cameraNode];
    
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
    
}

- (IBAction)tap1:(id)sender {
    
    //游戏引擎类型
//    if (self.scnView.eaglContext) {
//        NSLog(@"opengl");
//    }else{
//        NSLog(@"metal");
//    }
    
    //游戏截屏
    [self.scnView snapshot];
}
@end
