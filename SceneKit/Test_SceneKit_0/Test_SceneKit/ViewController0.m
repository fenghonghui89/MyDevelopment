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
{
    SCNView *_scnView;
}

@end

@implementation ViewController0

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setupScnview];
}

-(void)setupScnview{
    
    
    SCNScene *scene = [SCNScene scene];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"XTJMaterial" ofType:@"bundle"];
    filePath = [filePath stringByAppendingPathComponent:@"3d/my3dmodel1/file.dae"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSLog(@"文件存在");
    }else{
        NSLog(@"文件不存在");
    }
    NSURL *url = [NSURL fileURLWithPath:filePath];
    SCNSceneSource *sceneSource = [SCNSceneSource sceneSourceWithURL:url options:nil];
    SCNNode *modelNode = [sceneSource entryWithIdentifier:@"SubDragonLE_Shape" withClass:[SCNNode class]];
    [scene.rootNode addChildNode:modelNode];
    
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
    
}

- (IBAction)tap1:(id)sender {
   
}
@end
