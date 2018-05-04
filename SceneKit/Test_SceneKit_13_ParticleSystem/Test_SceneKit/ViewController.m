//
//  ViewController.m
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
// 粒子系统

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
    
    //粒子系统
    SCNParticleSystem *particleSystem = [SCNParticleSystem particleSystemNamed:@"fire.scnp" inDirectory:nil];
    particleSystem.emitterShape = box;//产生例子的空间区域的形状
    
    SCNNode *node = [SCNNode node];
    [node addParticleSystem:particleSystem];
    node.position = SCNVector3Make(0, 0, 0);
    [boxNode addChildNode:node];
    

    // add a tap gesture recognizer
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    NSMutableArray *gestureRecognizers = [NSMutableArray array];
    [gestureRecognizers addObject:tapGesture];
    [gestureRecognizers addObjectsFromArray:scnView.gestureRecognizers];
    scnView.gestureRecognizers = gestureRecognizers;

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
