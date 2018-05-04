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
    scnView.scene = scene;
    scnView.backgroundColor = [UIColor redColor];
    scnView.allowsCameraControl = YES;
    scnView.antialiasingMode = SCNAntialiasingModeMultisampling4X;//开启抗锯齿
    scnView.showsStatistics = YES;
    scnView.preferredFramesPerSecond = 60;//帧率
    [self.view addSubview:scnView];
    [self.view sendSubviewToBack:scnView];
    _scnView = scnView;
    
    SCNBox *box = [SCNBox boxWithWidth:0.5 height:0.5 length:0.5 chamferRadius:0];
    box.firstMaterial.diffuse.contents = @"女装布料.png";
    
    SCNNode *node = [SCNNode node];
    node.geometry = box;
    
    [scene.rootNode addChildNode:node];
    
}

- (IBAction)tap:(id)sender {
    
    UIImage *image = _scnView.snapshot;//截屏
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(150, 150, 100, 100)];
    iv.image = image;
    [self.view addSubview:iv];
}
@end
