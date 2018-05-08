//
//  ViewControllerMe3
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//自定义几何体

#import "ViewControllerMe3.h"
#import <SceneKit/SceneKit.h>
#import "XTJRootDefine.h"
#import "SSZipArchive.h"
#import "XTJCoreNetworkManager.h"
#import "Cube.h"
@interface ViewControllerMe3 ()
<
SCNSceneRendererDelegate,SCNSceneExportDelegate,
SSZipArchiveDelegate
>
@property(nonatomic,strong)SCNScene *scene;
@property(nonatomic,strong)SCNView *scnView;
@property(nonatomic,strong)SCNNode *node;
@end

@implementation ViewControllerMe3

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
    cameraNode.position = SCNVector3Make(0, 100, 50);
    cameraNode.rotation = SCNVector4Make(1, 0, 0, -M_PI_4);
    [scene.rootNode addChildNode:cameraNode];
    
    //light
    SCNLight *ambientlight = [SCNLight light];
    ambientlight.type = SCNLightTypeAmbient;
    SCNNode *ambientlightNode = [SCNNode node];
    ambientlightNode.light = ambientlight;
    [scene.rootNode addChildNode:ambientlightNode];
    
    SCNLight *omnilight = [SCNLight light];
    omnilight.type = SCNLightTypeOmni;
    omnilight.color = [UIColor whiteColor];
    SCNNode *omnilightNode = [SCNNode node];
    omnilightNode.light = omnilight;
    omnilightNode.position = SCNVector3Make(0, 100, 50);
    [scene.rootNode addChildNode:omnilightNode];

    
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
//    box.name = @"盒子";
//    box.firstMaterial.diffuse.contents = ImageFile(@"image/婚庆布料");
    SCNNode *boxNode = [SCNNode node];
//    boxNode.geometry = [self plane:CGPointMake(10, 10)];
    boxNode.geometry = [Cube cubeWithSize:SCNVector3Make(10, 10, 10)];
    boxNode.position = SCNVector3Make(0, 50, 0);
    [scene.rootNode addChildNode:boxNode];
//    [self setupMaterial1:box];
    
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

#pragma mark - 自定义几何体
//http://www.gltech.win/%E5%AD%A6%E4%B9%A0scenekit%E7%B3%BB%E5%88%97%E6%96%87%E7%AB%A0/2017/12/01/%E8%87%AA%E5%AE%9A%E4%B9%89%E5%87%A0%E4%BD%95%E4%BD%93.html

//三角形序列方式
-(SCNGeometry *)plane:(CGPoint)size{

    NSInteger count = 6;
    //顶点数据
    SCNVector3 vertices[] = {
        //第一个三角形
        SCNVector3Make(-0.5*size.x, 0.5*size.y, 0),//A
        SCNVector3Make(-0.5*size.x, -0.5*size.y, 0),//B
        SCNVector3Make(0.5*size.x, -0.5*size.y, 0),//C
        //第二个三角形
        SCNVector3Make(-0.5*size.x, 0.5*size.y, 0),//A
        SCNVector3Make(0.5*size.x, -0.5*size.y, 0),//C
        SCNVector3Make(0.5*size.x, 0.5*size.y, 0)//D
    };
    SCNGeometrySource *vertexSource = [SCNGeometrySource geometrySourceWithVertices:vertices count:count];
    
    //uv数据(纹理)
    CGPoint uvs[] = {
        CGPointMake(0, 1),
        CGPointMake(0, 0),
        CGPointMake(1, 0),
        CGPointMake(0, 1),
        CGPointMake(1, 0),
        CGPointMake(1, 1)
    };
    SCNGeometrySource *uvSource = [SCNGeometrySource geometrySourceWithTextureCoordinates:uvs count:count];
    
    //法线数据
    SCNVector3 normals[] = {
        SCNVector3Make(0,0,1),
        SCNVector3Make(0,0,1),
        SCNVector3Make(0,0,1),
        SCNVector3Make(0,0,1),
        SCNVector3Make(0,0,1),
        SCNVector3Make(0,0,1)
    };
    SCNGeometrySource *normalSource = [SCNGeometrySource geometrySourceWithNormals:normals count:count];
    
    //从顶点里面取第0到5个组成三角形列表，让系统渲染
    UInt32 indices[] = {0,1,2,3,4,5};
    NSData *data = [NSData dataWithBytes:indices length:sizeof(UInt32)*6.0];//4*6
    
    SCNGeometryPrimitiveType type = SCNGeometryPrimitiveTypeTriangles;//三角形序列
    
    SCNGeometryElement *element = [SCNGeometryElement geometryElementWithData:data
                                                                primitiveType:type
                                                               primitiveCount:2
                                                                bytesPerIndex:sizeof(UInt32)];
    
    SCNGeometry *geometry = [SCNGeometry geometryWithSources:@[normalSource,uvSource,vertexSource]
                                                    elements:@[element]];
    
    return geometry;
}

//三角带模式
-(SCNGeometry *)plane1:(CGPoint)size{
    
    NSInteger count = 4;
    
    //顶点数据
    SCNVector3 vertices[] = {
        SCNVector3Make(-0.5*size.x, 0.5*size.y, 0),//A
        SCNVector3Make(-0.5*size.x, -0.5*size.y, 0),//B
        SCNVector3Make(0.5*size.x, -0.5*size.y, 0),//C
        SCNVector3Make(0.5*size.x, 0.5*size.y, 0)//D
    };
    SCNGeometrySource *vertexSource = [SCNGeometrySource geometrySourceWithVertices:vertices count:count];
    
    //uv数据(纹理)
    CGPoint uvs[] = {
        CGPointMake(0, 1),
        CGPointMake(0, 0),
        CGPointMake(1, 0),
        CGPointMake(1, 1)
    };
    SCNGeometrySource *uvSource = [SCNGeometrySource geometrySourceWithTextureCoordinates:uvs count:count];
    
    //法线数据
    SCNVector3 normals[] = {
        SCNVector3Make(0,0,1),
        SCNVector3Make(0,0,1),
        SCNVector3Make(0,0,1),
        SCNVector3Make(0,0,1)
    };
    SCNGeometrySource *normalSource = [SCNGeometrySource geometrySourceWithNormals:normals count:count];
    
    
    UInt32 indices[] = {1,2,0,3};//必须是1203
    NSData *data = [NSData dataWithBytes:indices length:sizeof(UInt32)*4.0];//4*4
    
    SCNGeometryPrimitiveType type = SCNGeometryPrimitiveTypeTriangleStrip;//三角带
    
    SCNGeometryElement *element = [SCNGeometryElement geometryElementWithData:data
                                                                primitiveType:type
                                                               primitiveCount:2
                                                                bytesPerIndex:sizeof(UInt32)];
    
    SCNGeometry *geometry = [SCNGeometry geometryWithSources:@[vertexSource,uvSource,normalSource]
                                                    elements:@[element]];
    
    return geometry;
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
