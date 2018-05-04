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
    
    SCNView *scnView = [[SCNView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    scnView.center = self.view.center;
    scnView.scene = scene;
    scnView.backgroundColor = [UIColor redColor];
    scnView.allowsCameraControl = YES;
    scnView.antialiasingMode = SCNAntialiasingModeMultisampling4X;//开启抗锯齿
    scnView.showsStatistics = YES;
    scnView.preferredFramesPerSecond = 60;//帧率
    [self.view addSubview:scnView];
    [self.view sendSubviewToBack:scnView];
    _scnView = scnView;
    
    //球体
    SCNSphere *sphere = [SCNSphere sphereWithRadius:0.5];
    sphere.firstMaterial.diffuse.contents = @"女装布料.png";
    SCNNode *node = [SCNNode node];
    node.geometry = sphere;
    [scene.rootNode addChildNode:node];
    
    //子节点
    SCNText *text = [SCNText textWithString:@"让学习成为一种习惯" extrusionDepth:0.03];//字体深度
    text.firstMaterial.diffuse.contents = [UIColor purpleColor];
    text.font = [UIFont systemFontOfSize:0.15];
    
    SCNNode *childNode = [SCNNode node];
    childNode.position = SCNVector3Make(-0.5, 0, 1);
    childNode.geometry = text;
    [node addChildNode:childNode];
    
}

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
@end
