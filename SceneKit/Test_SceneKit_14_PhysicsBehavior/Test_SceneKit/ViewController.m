//
//  ViewController.m
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
// 物理行为

#import "ViewController.h"
#import <SceneKit/SceneKit.h>
#import "XTJRootDefine.h"

#define edge 5
@interface ViewController ()
<
SCNPhysicsContactDelegate
>
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
    
    //camera
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 20, 50);
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
    floor.firstMaterial.diffuse.contents = ImageFile(@"image/春夏布料");
    floor.width = 100;
    floor.length = 100;
    
    SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
    floorNode.position = SCNVector3Make(0, 0, 0);
    floorNode.physicsBody = [SCNPhysicsBody staticBody];//静态身体
    [scene.rootNode addChildNode:floorNode];
    
    //box
    CGFloat y = edge*0.5+edge*7;
    SCNBox *box = [SCNBox boxWithWidth:edge height:edge length:edge chamferRadius:0];
    box.firstMaterial.diffuse.contents = ImageFile(@"image/婚庆布料");
    SCNNode *boxNode = [SCNNode nodeWithGeometry:box];
    boxNode.physicsBody = [SCNPhysicsBody staticBody];
    boxNode.position = SCNVector3Make(0, y, 0);
    [scene.rootNode addChildNode:boxNode];
    
    //text
    SCNNode *text1 = [self createTextNodeWithString:@"酷"];
    [scene.rootNode addChildNode:text1];

    SCNNode *text2 = [self createTextNodeWithString:@"走"];
    [scene.rootNode addChildNode:text2];

    SCNNode *text3 = [self createTextNodeWithString:@"天"];
    [scene.rootNode addChildNode:text3];

    SCNNode *text4 = [self createTextNodeWithString:@"下"];
    [scene.rootNode addChildNode:text4];
    
    /*
     behavior
     但是有些几何体的锚点不在几何体的中心,比如SCNText的这样几何体, 它的锚点在左下角
     
     joint0:
     box的锚点默认是中心，把锚点往下移0.5边长则是底部中间点，但这里预留多点空间，可以使摆动更飘逸，且和第一个文字之间有空隙
     文字1的锚点默认是左下角，这里把锚点移到顶部中间点，即右移0.5边长上移1边长，因为box已经预留空间所以不用再多预留
     
     joint1/2/3:
     文字1的锚点默认是左下角，这里把锚点移到底部中间点，即右移0.5边长
     文字2的锚点默认是左下角，把锚点移到顶部中间点，即右移0.5边长上移1边长，但这里预留多点空间，可以使摆动更飘逸，且和上面的文字之间有空隙
     */
    SCNPhysicsHingeJoint *joint0 = [SCNPhysicsHingeJoint jointWithBodyA:boxNode.physicsBody
                                                                  axisA:SCNVector3Make(1, 0, 0)
                                                                anchorA:SCNVector3Make(0, -edge, 0)
                                                                  bodyB:text1.physicsBody
                                                                  axisB:SCNVector3Make(1, 0, 0)
                                                                anchorB:SCNVector3Make(edge*0.5, edge, 0)];

    SCNPhysicsHingeJoint *joint1 = [SCNPhysicsHingeJoint jointWithBodyA:text1.physicsBody
                                                                  axisA:SCNVector3Make(1, 0, 0)
                                                                anchorA:SCNVector3Make(edge*0.5, 0, 0)
                                                                  bodyB:text2.physicsBody
                                                                  axisB:SCNVector3Make(1, 0, 0)
                                                                anchorB:SCNVector3Make(edge*0.5, edge*1.2, 0)];

    SCNPhysicsHingeJoint *joint2 = [SCNPhysicsHingeJoint jointWithBodyA:text2.physicsBody
                                                                  axisA:SCNVector3Make(1, 0, 0)
                                                                anchorA:SCNVector3Make(edge*0.5, 0, 0)
                                                                  bodyB:text3.physicsBody
                                                                  axisB:SCNVector3Make(1, 0, 0)
                                                                anchorB:SCNVector3Make(edge*0.5, edge*1.2, 0)];

    SCNPhysicsHingeJoint *joint3 = [SCNPhysicsHingeJoint jointWithBodyA:text3.physicsBody
                                                                  axisA:SCNVector3Make(1, 0, 0)
                                                                anchorA:SCNVector3Make(edge*0.5, 0, 0)
                                                                  bodyB:text4.physicsBody
                                                                  axisB:SCNVector3Make(1, 0, 0)
                                                                anchorB:SCNVector3Make(edge*0.5, edge*1.2, 0)];
    
   
    [scene.physicsWorld addBehavior:joint0];
    [scene.physicsWorld addBehavior:joint1];
    [scene.physicsWorld addBehavior:joint2];
    [scene.physicsWorld addBehavior:joint3];
    
    //粒子系统
    SCNParticleSystem *ps = [SCNParticleSystem particleSystemNamed:@"fire.scnp" inDirectory:nil];
    SCNNode *psNode = [SCNNode node];
    [psNode addParticleSystem:ps];
    psNode.position = SCNVector3Make(0, 0, 0);
    [boxNode addChildNode:psNode];
    

    // add a tap gesture recognizer
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    NSMutableArray *gestureRecognizers = [NSMutableArray array];
    [gestureRecognizers addObject:tapGesture];
    [gestureRecognizers addObjectsFromArray:scnView.gestureRecognizers];
    scnView.gestureRecognizers = gestureRecognizers;

}

-(SCNNode *)createTextNodeWithString:(NSString *)string{

    SCNText *text = [SCNText textWithString:string extrusionDepth:1];
    text.font = [UIFont systemFontOfSize:5];
    text.firstMaterial.diffuse.contents = ImageFile(@"image/春夏布料");
    
    SCNBox *box = [SCNBox boxWithWidth:edge height:edge length:edge chamferRadius:0];
    SCNPhysicsShape *shape = [SCNPhysicsShape shapeWithGeometry:box options:nil];
    SCNPhysicsBody *body = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeDynamic shape:shape];
    
    SCNNode *node = [SCNNode nodeWithGeometry:text];
    node.physicsBody = body;
    
    return node;
}

#pragma mark - < action >
- (IBAction)tap:(id)sender {
    
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documentDirectory lastObject];
    NSString *path = [documentPath stringByAppendingPathComponent:@"111.dae"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    //This URL must use the file scheme.
    [_scnView.scene writeToURL:url options:nil delegate:nil progressHandler:^(float totalProgress, NSError * _Nullable error, BOOL * _Nonnull stop) {
        NSLog(@"....%f",totalProgress);
    }];
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

#pragma mark < SCNPhysicsContactDelegate >
- (void)physicsWorld:(SCNPhysicsWorld *)world didBeginContact:(SCNPhysicsContact *)contact{
    NSLog(@"didBeginContact...");
}
- (void)physicsWorld:(SCNPhysicsWorld *)world didUpdateContact:(SCNPhysicsContact *)contact{
    NSLog(@"didUpdateContact...");
}
- (void)physicsWorld:(SCNPhysicsWorld *)world didEndContact:(SCNPhysicsContact *)contact{
    NSLog(@"didEndContact...");
}
@end
