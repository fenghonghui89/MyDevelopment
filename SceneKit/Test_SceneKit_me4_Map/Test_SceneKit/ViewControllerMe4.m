//
//  ViewControllerMe4
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import "ViewControllerMe4.h"
#import <SceneKit/SceneKit.h>
#import "XTJRootDefine.h"
#import "SSZipArchive.h"
#import "XTJCoreNetworkManager.h"
#import "Cube.h"
@interface ViewControllerMe4 ()
<
SCNSceneRendererDelegate,SCNSceneExportDelegate,
SSZipArchiveDelegate
>
@property(nonatomic,strong)SCNScene *scene;
@property(nonatomic,strong)SCNView *scnView;
@property(nonatomic,strong)SCNNode *node;
@end

@implementation ViewControllerMe4

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *doucumentsPath = [XTJTool doucumentsPath];
    NSLog(@"doucumentsPath path...%@",doucumentsPath);
}



#pragma mark - method
-(void)showLog:(NSString *)path{

    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSError *error = nil;
    NSArray *files = [fm contentsOfDirectoryAtPath:path error:&error];
    if (error) {
        NSLog(@"error..%@",error.localizedDescription);
    }else{
        for (NSString *fileName in files) {
            NSLog(@"file name..%@",fileName);
        }
    }

}

-(void)setupScnview{
    
    SCNScene *scene = [SCNScene scene];
    self.scene = scene;
    
    //camera
    SCNCamera *camera = [SCNCamera camera];
    camera.automaticallyAdjustsZRange = YES;
    
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 0, 50);
//    cameraNode.rotation = SCNVector4Make(1, 0, 0, -M_PI_4);
    [scene.rootNode addChildNode:cameraNode];
    
    //light
    SCNLight *ambientlight = [SCNLight light];
    ambientlight.type = SCNLightTypeAmbient;
    SCNNode *ambientlightNode = [SCNNode node];
    ambientlightNode.light = ambientlight;
    [scene.rootNode addChildNode:ambientlightNode];
    
//    SCNLight *omnilight = [SCNLight light];
//    omnilight.type = SCNLightTypeOmni;
//    omnilight.color = [UIColor whiteColor];
//    SCNNode *omnilightNode = [SCNNode node];
//    omnilightNode.light = omnilight;
//    omnilightNode.position = SCNVector3Make(0, 100, 50);
//    [scene.rootNode addChildNode:omnilightNode];

    
    //floor
//    SCNFloor *floor = [SCNFloor floor];
//    floor.name = @"地板";
//    floor.firstMaterial.diffuse.contents = ImageFile(@"image/素材1");
//    floor.width = 1000;
//    floor.length = 1000;
//
//    SCNNode *floorNode = [SCNNode nodeWithGeometry:floor];
//    floorNode.position = SCNVector3Make(0, 0, 0);
//    floorNode.physicsBody = [SCNPhysicsBody staticBody];//静态身体
//    [scene.rootNode addChildNode:floorNode];
    
    //box
//    SCNBox *box = [SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];
    Cube *box = [Cube cubeWithSize:SCNVector3Make(10, 10, 10)];
    box.name = @"盒子";
    SCNNode *boxNode = [SCNNode node];
    boxNode.geometry = box;
    boxNode.position = SCNVector3Make(0, 0, 0);
    [scene.rootNode addChildNode:boxNode];
    [self setupMaterial1:box];
    
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
    self.scnView = scnView;
    
    scnView.scene = scene;
    
    // add a tap gesture recognizer
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    NSMutableArray *gestureRecognizers = [NSMutableArray array];
    [gestureRecognizers addObject:tapGesture];
    [gestureRecognizers addObjectsFromArray:scnView.gestureRecognizers];
    scnView.gestureRecognizers = gestureRecognizers;
}

#pragma mark - 贴图

//材质-贴图
-(void)setupMaterial1:(SCNGeometry *)geometry{
    
    NSArray *images = @[ImageFile(@"image/春夏布料"),ImageFile(@"image/功能性布料"),ImageFile(@"image/婚庆布料"),ImageFile(@"image/家居布料"),ImageFile(@"image/棉类布料"),ImageFile(@"image/女装布料")];
    NSMutableArray *materials = [NSMutableArray array];
    for (int i=0; i<images.count; i++) {
        SCNMaterial *material = [SCNMaterial material];
        material.lightingModelName = SCNLightingModelBlinn;//光照模型类型 Lambert、Blinn(Lambert基础上加高光)
        material.diffuse.contents = images[i];//材质的贴图
        material.locksAmbientWithDiffuse = NO;
        
        //u轴上的重复模式
        material.diffuse.wrapS = SCNWrapModeRepeat;
        
        //v轴上的重复模式
        material.diffuse.wrapT = SCNWrapModeRepeat;
        
        if (@available(iOS 11.0,*)) {
            //放大时的采样算法 默认lines
            material.diffuse.magnificationFilter = SCNFillModeLines;
            
            //缩小时的采样算法 默认lines
            material.diffuse.minificationFilter = SCNFillModeFill;
        }
        
        [materials addObject:material];
    }
    geometry.materials = materials;
}


#pragma mark - < action >
- (IBAction)tap:(id)sender {
    [self setupScnview];
}

- (IBAction)tap1:(id)sender {
    
}

- (IBAction)tap2:(id)sender {
    
}

- (IBAction)tap3:(id)sender {
    [self.scnView removeFromSuperview];
    self.scnView = nil;
}

-(void)handleTap:(UITapGestureRecognizer *)gestureRecognize{
    
    // retrieve the SCNView
    SCNView *scnView = self.scnView;
    
    // check what nodes are tapped
    CGPoint p = [gestureRecognize locationInView:scnView];
    NSArray *hitResults = [scnView hitTest:p options:nil];
    
    // check that we clicked on at least one object
    if([hitResults count] > 0){
        // retrieved the first clicked object
        SCNHitTestResult *result = [hitResults objectAtIndex:0];
        
        //SCNHitTestResult参数
        SCNNode *node = result.node;//点击到的节点
        NSLog(@"节点名字:%@",node.geometry.name);
        NSInteger geoIndex = result.geometryIndex;//几何体索引
        NSLog(@"几何体索引..%ld",(long)geoIndex);
        NSInteger faceIndex = result.faceIndex;//面的索引
        NSLog(@"面的索引..%ld",(long)faceIndex);
        SCNVector3 localCoordinates = result.localCoordinates;//本地坐标系统
        SCNVector3 worldCoordinates = result.worldCoordinates;//世界坐标系统
        //        SCNNode *boneNode = result.boneNode;//骨骼
        CGPoint textureCoordinates = [result textureCoordinatesWithMappingChannel:0];//纹理
        
        
        // get its material
        SCNMaterial *material = result.node.geometry.firstMaterial;//材质
        
        //高亮点击的部分
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

#pragma mark - < SSZipArchiveDelegate >
- (void)zipArchiveWillUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo{
    NSLog(@"WillUnzipArchiveAtPat..");
}

- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPath{
    NSLog(@"DidUnzipArchiveAtPath..");
}

- (void)zipArchiveProgressEvent:(unsigned long long)loaded total:(unsigned long long)total{
    NSLog(@"zip ProgressEvent..%llu",loaded);
}

#pragma mark - < SCNSceneExportDelegate >
-(NSURL *)writeImage:(UIImage *)image withSceneDocumentURL:(NSURL *)documentURL originalImageURL:(NSURL *)originalImageURL{
    
    NSLog(@"writeImage...%@ %@ %@",image,documentURL,originalImageURL);
    return nil;
}

#pragma mark - < SCNSceneRendererDelegate >

- (void)renderer:(id <SCNSceneRenderer>)renderer updateAtTime:(NSTimeInterval)time{
    NSLog(@"1.updateAtTime..%f",time);
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didApplyAnimationsAtTime:(NSTimeInterval)time{
    NSLog(@"2.didApplyAnimationsAtTime..%f",time);
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didSimulatePhysicsAtTime:(NSTimeInterval)time{
    NSLog(@"3.didSimulatePhysicsAtTime..%f",time);
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didApplyConstraintsAtTime:(NSTimeInterval)time{
    NSLog(@"didApplyConstraintsAtTime..%f",time);
}

- (void)renderer:(id <SCNSceneRenderer>)renderer willRenderScene:(SCNScene *)scene atTime:(NSTimeInterval)time{
    NSLog(@"4.willRenderScene..%f",time);
}

- (void)renderer:(id <SCNSceneRenderer>)renderer didRenderScene:(SCNScene *)scene atTime:(NSTimeInterval)time{
    NSLog(@"5.didRenderScene..%f",time);
}
@end