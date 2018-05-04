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
    
    //camera
    SCNCamera *camera = [SCNCamera camera];

    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 0, 5);

    [scene.rootNode addChildNode:cameraNode];
    
//    SCNBox *geometry = [SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];//正方体
    SCNPlane *geometry = [SCNPlane planeWithWidth:1 height:1];//平面
    
    //球体
//    SCNSphere *geometry = [SCNSphere sphereWithRadius:0.5];
//    geometry.segmentCount = 200;//减少锯齿
    
//    SCNPyramid *geometry = [SCNPyramid pyramidWithWidth:1 height:1 length:1];//金字塔
//    SCNCylinder *geometry = [SCNCylinder cylinderWithRadius:1 height:2];//圆柱体
//    SCNCone *geometry = [SCNCone coneWithTopRadius:0 bottomRadius:1 height:1];//圆锥体
//    SCNTube *geometry = [SCNTube tubeWithInnerRadius:1 outerRadius:1.2 height:2];//管道
//    SCNTorus *geometry = [SCNTorus torusWithRingRadius:1 pipeRadius:0.5];//圆环面
//    SCNFloor *geometry = [SCNFloor floor];//地板 node.position = SCNVector3Make(0, -5, 0);
//    SCNText *geometry = [SCNText textWithString:@"好好学习" extrusionDepth:0.5];//立体文字
    
    //自定义形状 注意是SCNShape不是SCNSphere
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 1, 1) cornerRadius:0.5];
//    SCNShape *geometry = [SCNShape shapeWithPath:path extrusionDepth:3];
    
    //SegmentCount 减少锯齿
//    SCNBox *geometry = [SCNBox boxWithWidth:1 height:1 length:1 chamferRadius:0.5];
//    geometry.chamferSegmentCount = 200;//减少锯齿
    
    
    geometry.firstMaterial.diffuse.contents = @"1.png";

    SCNNode *node = [SCNNode nodeWithGeometry:geometry];
    node.position = SCNVector3Make(0, 0, 0);

    [scene.rootNode addChildNode:node];
    
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
- (IBAction)tap1:(id)sender {
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
