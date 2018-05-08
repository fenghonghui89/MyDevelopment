//
//  ViewController.m
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>
#import "XTJRootDefine.h"
#define XTJBlockWeak(type) __weak typeof(type) weak##_##type = type
#define screenW [[UIScreen mainScreen] bounds].size.width
#define screenH [[UIScreen mainScreen] bounds].size.height
#define AngleToRadian(angle) ((angle) * M_PI / 180.0)

@interface ViewController ()
{
    SCNView *_scnView;
}
@end

@implementation ViewController

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setupScnview];
}

#pragma mark - method
-(void)setupScnview{
    
    SCNScene *scene = [SCNScene sceneNamed:@"art-o.scnassets/ship.scn"];
    scene = [SCNScene scene];
    
    //camera
    SCNCamera *camera = [SCNCamera camera];
    camera.zNear = 1;//可是最近距离，默认1
    camera.zFar = 1000;//可是最远距离，默认100
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 100, 30);
    cameraNode.rotation = SCNVector4Make(1, 0, 0, -M_PI_4);//x,y,z,角度,xyz哪个设为1则绕哪个轴旋转
    [scene.rootNode addChildNode:cameraNode];
    
    //light
    SCNLight *light = [SCNLight light];
    light.type = SCNLightTypeAmbient;
    light.color = [UIColor grayColor];
    SCNNode *lightNode = [SCNNode node];
    lightNode.light = light;
    [scene.rootNode addChildNode:lightNode];

    //floor
    SCNFloor *floor = [SCNFloor floor];
    floor.reflectivity = 0.25;//反射率
    floor.firstMaterial.diffuse.contents = ImageFile(@"image/春夏布料");
    floor.width = 0;//默认0，无限延伸，可视范围根据camera
    floor.length = 0;//默认0，无限延伸，可视范围根据camera
    
    SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
    floorNode.position = SCNVector3Make(0, 0, 0);
    floorNode.physicsBody = [SCNPhysicsBody staticBody];//静态身体
    [scene.rootNode addChildNode:floorNode];
    
    //几何体
    /*
     当需要物理引擎来控制节点的移动和旋转时,应设置为dynamic.如果不需要移动,但仍能参与物理模拟,应设置为static.如果你既想控制某些节点的移动和旋转,同时仍能参与物理模拟,应设置为kinematic.
     */
    CGFloat height = 10;
    CGFloat y = height*0.5;
    SCNCylinder *cylinder = [SCNCylinder cylinderWithRadius:1 height:height];
    cylinder.firstMaterial.diffuse.contents = ImageFile(@"image/家居布料");
    SCNNode *cylinderNode = [SCNNode nodeWithGeometry:cylinder];
    cylinderNode.position = SCNVector3Make(0, y, 0);
    cylinderNode.physicsBody = [SCNPhysicsBody dynamicBody];//动态身体
    [scene.rootNode addChildNode:cylinderNode];

    SCNCylinder *cylinder2 = [SCNCylinder cylinderWithRadius:1 height:height];
    cylinder2.firstMaterial.diffuse.contents = ImageFile(@"image/婚庆布料");
    SCNNode *cylinderNode2 = [SCNNode nodeWithGeometry:cylinder2];
    cylinderNode2.position = SCNVector3Make(5, y, 0);
    cylinderNode2.physicsBody = [SCNPhysicsBody dynamicBody];//动态身体
    [scene.rootNode addChildNode:cylinderNode2];

    SCNCylinder *cylinder3 = [SCNCylinder cylinderWithRadius:1 height:height];
    cylinder3.firstMaterial.diffuse.contents = ImageFile(@"image/棉类布料");
    SCNNode *cylinderNode3 = [SCNNode nodeWithGeometry:cylinder3];
    cylinderNode3.position = SCNVector3Make(-5, y, 0);
    cylinderNode3.physicsBody = [SCNPhysicsBody kinematicBody];//运动身体
    [scene.rootNode addChildNode:cylinderNode3];

    SCNSphere *sphere = [SCNSphere sphereWithRadius:5];
    sphere.segmentCount = 20;//减少锯齿
    sphere.firstMaterial.diffuse.contents = ImageFile(@"image/女装布料");
    SCNNode *sphereNode = [SCNNode nodeWithGeometry:sphere];
    sphereNode.position = SCNVector3Make(0, 50, 0);
    sphereNode.physicsBody = [SCNPhysicsBody dynamicBody];//动态身体
    [scene.rootNode addChildNode:sphereNode];

    scnView.scene = scene;
    NSLog(@"%@",scnView.pointOfView);
    
    SCNView *scnView = [[SCNView alloc] initWithFrame:self.view.bounds];
    scnView.center = self.view.center;
    
    scnView.backgroundColor = [UIColor blackColor];
    scnView.allowsCameraControl = YES;
    scnView.antialiasingMode = SCNAntialiasingModeMultisampling4X;//开启抗锯齿
    scnView.showsStatistics = YES;
    scnView.preferredFramesPerSecond = 60;//帧率
    [self.view addSubview:scnView];
    [self.view sendSubviewToBack:scnView];
    _scnView = scnView;
    
    // add a tap gesture recognizer
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    NSMutableArray *gestureRecognizers = [NSMutableArray array];
    [gestureRecognizers addObject:tapGesture];
    [gestureRecognizers addObjectsFromArray:scnView.gestureRecognizers];
    scnView.gestureRecognizers = gestureRecognizers;
}

#pragma mark - < action >
- (IBAction)tap:(id)sender {
    
}

- (void) handleTap:(UIGestureRecognizer*)gestureRecognize
{
    // retrieve the SCNView
    SCNView *scnView = _scnView;
    
    // check what nodes are tapped
    CGPoint p = [gestureRecognize locationInView:scnView];
    NSArray *hitResults = [scnView hitTest:p options:nil];
    
    // check that we clicked on at least one object
    if([hitResults count] > 0){
        // retrieved the first clicked object
        SCNHitTestResult *result = [hitResults objectAtIndex:0];
        
        // get its material
        SCNMaterial *material = result.node.geometry.firstMaterial;
        
        // highlight it
        [SCNTransaction begin];
        [SCNTransaction setAnimationDuration:0.5];
        
        // on completion - unhighlight
        [SCNTransaction setCompletionBlock:^{
            [SCNTransaction begin];
            [SCNTransaction setAnimationDuration:0.5];
            
            material.emission.contents = [UIColor blackColor];
            
            [SCNTransaction commit];
        }];
        
        material.emission.contents = [UIColor orangeColor];
        
        [SCNTransaction commit];
    }
}
@end
