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
    
    //scnview
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
    
    SCNScene *scene = [SCNScene scene];
    
    //正方体1
    SCNBox *box = [SCNBox boxWithWidth:1 height:1 length:1 chamferRadius:0];
    box.firstMaterial.diffuse.contents = [UIImage imageNamed:@"女装布料"];
    
    SCNNode *boxNode = [SCNNode node];
    boxNode.geometry = box;
    
    [scene.rootNode addChildNode:boxNode];
    
    //正方体2
    SCNBox *box2 = [SCNBox boxWithWidth:1 height:1 length:1 chamferRadius:0];
    box2.firstMaterial.diffuse.contents = [UIImage imageNamed:@"功能性布料"];

    SCNNode *boxNode2 = [SCNNode node];
    boxNode2.geometry = box2;
    boxNode2.position = SCNVector3Make(0, 10, -20);

    [scene.rootNode addChildNode:boxNode2];
    
    //新建camera
    SCNCamera *camera = [SCNCamera camera];

    //视角 影响大小
//    camera.xFov = 20;//x轴视角 默认60
//    camera.yFov = 20;//y轴视角 默认60
//
//    camera.focalDistance = 45;//焦距，默认10
//    camera.focalBlurRadius = 1;//物体模糊度 默认0
//
//    camera.zFar = 60;//最远照射距离
    
    //正投影
//    camera.usesOrthographicProjection = YES;//开启后，物体在远离或靠近相机时，大小不变
//    camera.orthographicScale = 10;//比例越大图形越小 scale=屏幕:图形

    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 0, 10);
    [scene.rootNode addChildNode:cameraNode];
    
    
    
    /*
     A:[scene.rootNode addChildNode:cameraNode];
     B:scnView.scene = scene;
     
     pointOfView是否有值，与camera是否有效，无关
     
     如果A先于B
     则pointOfView有值，否则为nil
     
     如果场景不是通过scn读取而是手动生成，则A就算不是先于B，也有效
     */
    scnView.scene = scene;
    NSLog(@"%@",scnView.pointOfView);

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
