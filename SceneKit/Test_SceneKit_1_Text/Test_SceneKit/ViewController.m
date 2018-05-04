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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScnview];
    
    
}


-(void)setupScnview{
    
    SCNScene *scene = [SCNScene scene];
    
    SCNView *scnView = [[SCNView alloc] initWithFrame:self.view.bounds];
    scnView.scene = scene;
    scnView.backgroundColor = [UIColor redColor];
    scnView.allowsCameraControl = YES;
    scnView.antialiasingMode = SCNAntialiasingModeMultisampling4X;
    [self.view addSubview:scnView];
    
    SCNText *text = [SCNText textWithString:@"ssss" extrusionDepth:0.5];
    
    SCNNode *node = [SCNNode node];
    node.geometry = text;
    
    [scene.rootNode addChildNode:node];
    
}
@end
