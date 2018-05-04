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
    cameraNode.position = SCNVector3Make(0, 0, 50);
    
    [scene.rootNode addChildNode:cameraNode];
    
    //正方体
    SCNBox *box = [SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];
    box.firstMaterial.diffuse.contents = [UIImage imageNamed:@"女装布料"];
    
    SCNNode *boxNode = [SCNNode node];
    boxNode.geometry = box;
    
    [scene.rootNode addChildNode:boxNode];
    
    //动画
    SCNAction *rotation = [SCNAction rotateByAngle:10 aroundAxis:SCNVector3Make(0, 1, 0) duration:2];
    
    SCNAction *moveUp = [SCNAction moveTo:SCNVector3Make(0, 15, 0) duration:1];
    SCNAction *moveDown = [SCNAction moveTo:SCNVector3Make(0, -15, 0) duration:1];
    
    SCNAction *scaleIn = [SCNAction scaleTo:0.1 duration:1];
    SCNAction *scaleOut = [SCNAction scaleTo:1 duration:1];
    
    SCNAction *fadeIn = [SCNAction fadeOpacityTo:1 duration:1];
    SCNAction *fadeOut = [SCNAction fadeOpacityTo:0 duration:1];
    
    //顺序执行的动画
    SCNAction *seq_move = [SCNAction sequence:@[moveUp,moveDown]];
    SCNAction *seq_scale = [SCNAction sequence:@[scaleIn,scaleOut]];
    SCNAction *seq_fade = [SCNAction sequence:@[fadeIn,fadeOut]];
    
    //block动画
    SCNAction *blockAction = [SCNAction runBlock:^(SCNNode * _Nonnull node) {
        NSLog(@"....");
    }];
    
    //组合动画
    SCNAction *group = [SCNAction group:@[rotation,seq_move,seq_scale,seq_fade,blockAction]];
    
    //动画执行次数
    SCNAction *repeatAction = [SCNAction repeatAction:group count:3];
    [repeatAction reversedAction];
    
    repeatAction = [SCNAction repeatActionForever:group];
    
    
    //实行
    [boxNode runAction:repeatAction completionHandler:^{
        NSLog(@"动画完成了。。");
    }];
    
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
@end
