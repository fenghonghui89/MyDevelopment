//
//  ViewController.m
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>

#define XTJBlockWeak(type) __weak typeof(type) weak##_##type = type
#define screenW [[UIScreen mainScreen] bounds].size.width
#define screenH [[UIScreen mainScreen] bounds].size.height
@interface ViewController ()
{
    SCNView *_scnView;
}
@end

@implementation ViewController

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
    _scnView = scnView;
    
    //正方体
    SCNBox *box = [SCNBox boxWithWidth:0.5 height:0.5 length:0.5 chamferRadius:0];
//    box.firstMaterial.diffuse.contents = [UIColor yellowColor];
    
    SCNNode *boxNode = [SCNNode node];
    boxNode.geometry = box;
    boxNode.position = SCNVector3Make(0, 0, -11);
    
    [scene.rootNode addChildNode:boxNode];
    
    //球体
    SCNSphere *sphere = [SCNSphere sphereWithRadius:0.1];
    
    SCNNode *sphereNode = [SCNNode node];
    sphereNode.geometry = sphere;
    sphereNode.position = SCNVector3Make(0, 0, -10);
    
    [scene.rootNode addChildNode:sphereNode];
    
    
    //环境光
    //无方向 位置无穷远 均匀散射
    //如果无任何光源 系统默认添加环境光
    SCNLight *ambientLight = [SCNLight light];
    ambientLight.type = SCNLightTypeAmbient;
    ambientLight.color = [UIColor colorWithWhite:0.67 alpha:1];//亮度未0.67的白光

    SCNNode *lightNode_Ambient = [SCNNode node];
    lightNode_Ambient.light = ambientLight;

    [scene.rootNode addChildNode:lightNode_Ambient];
    
    
    //全向光源
    //360度方向 有位置 会衰减
//    SCNLight *light = [SCNLight light];
//    light.type = SCNLightTypeOmni;
//    light.color = [UIColor yellowColor];
//
//    SCNNode *lightNode = [SCNNode node];
//    lightNode.light = light;
//    lightNode.position = SCNVector3Make(0, 100, 100);
//
//    [scene.rootNode addChildNode:lightNode];
    
    //平行光
    //有方向 没有位置 不衰减
    SCNLight *light = [SCNLight light];
    light.type = SCNLightTypeDirectional;
    light.color = [UIColor yellowColor];

    SCNNode *lightNode = [SCNNode node];
    lightNode.light = light;
    lightNode.position = SCNVector3Make(1000, 1000, 1000);//改光源位置不会有变化
    lightNode.rotation = SCNVector4Make(1, 0, 0, 15);//改照射方向会有变化

    [scene.rootNode addChildNode:lightNode];
    
    //点光源 具体使用看23-阴影的使用
    //有方向 有位置 有照射区域 可以衰减
//    SCNLight *light = [SCNLight light];
//    light.type = SCNLightTypeSpot;
//    light.color = [UIColor yellowColor];
//    light.castsShadow = YES;//捕捉阴影
//    light.zFar = 10;//设置它最远能照射到的地方为10 即只能照到球体
//    light.spotOuterAngle = 2;//光发射角度
//
//    SCNNode *lightNode = [SCNNode node];
//    lightNode.light = light;
//    lightNode.position = SCNVector3Make(0, 0, -9);
//
//    [scene.rootNode addChildNode:lightNode];
}

- (IBAction)tap:(id)sender {
    
    
}
@end
