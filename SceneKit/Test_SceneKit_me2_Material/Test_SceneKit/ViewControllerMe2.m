//
//  ViewControllerMe2
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import "ViewControllerMe2.h"
#import <SceneKit/SceneKit.h>
#import "XTJRootDefine.h"
#import "SSZipArchive.h"
#import "XTJCoreNetworkManager.h"
@interface ViewControllerMe2 ()
<
SCNSceneRendererDelegate,SCNSceneExportDelegate,
SSZipArchiveDelegate
>
@property(nonatomic,strong)SCNScene *scene;
@property(nonatomic,strong)SCNView *scnView;
@property(nonatomic,strong)SCNNode *node;
@end

@implementation ViewControllerMe2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *doucumentsPath = [XTJTool doucumentsPath];
    NSLog(@"doucumentsPath path...%@",doucumentsPath);
}



#pragma mark - < method >
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
    SCNSphere *box = [SCNSphere sphereWithRadius:10];
    box.name = @"盒子";
    SCNNode *boxNode = [SCNNode node];
    boxNode.geometry = box;
    boxNode.position = SCNVector3Make(0, 50, 0);
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

#pragma mark - 材质
//材质-颜色值
-(void)setupMaterial:(SCNGeometry *)geometry{

    SCNMaterial *material = [SCNMaterial material];
    material.lightingModelName = SCNLightingModelBlinn;//光照模型类型 Lambert、Blinn(Lambert基础上加高光)
    material.diffuse.contents = [UIColor redColor];//材质的本色
    material.ambient.contents = [[UIColor alloc] initWithWhite:0.1 alpha:1];//环境光
    material.specular.contents = [UIColor whiteColor];//高光的颜色
    material.shininess = 1.0;//高光 0~1越大越光滑
    
    //由于PBR光照模型中ambient和diffuse是锁定的，所以需要把locksAmbientWithDiffuse设置为false，否则ambient只能和diffuse取相同的值。
    material.locksAmbientWithDiffuse = NO;
    
    geometry.materials = @[material];
}

//材质-贴图
-(void)setupMaterial1:(SCNGeometry *)geometry{
    
    SCNMaterial *material = [SCNMaterial material];
    
    material.lightingModelName = SCNLightingModelBlinn;//光照模型类型 Lambert、Blinn(Lambert基础上加高光)
    
    /*
     颜色贴图 漫反射贴图
     给几何体一个基本的颜色纹理,不考虑灯光和特效
     */
//    material.diffuse.contents = [UIColor redColor];//材质的本色
    material.diffuse.contents = ImageFile(@"image/earth");//材质的贴图
    
    /*
     环境光贴图
     */
    material.ambient.contents = [[UIColor alloc] initWithWhite:0.1 alpha:1];
    
    /*
     法线贴图
     形成表面崎岖不平的灯光效果
     有点光源的情况下才有效果？
     */
    material.normal.contents = ImageFile(@"image/earth_NRM");
    
    /*
     镜面贴图 高光贴图
     */
    material.specular.contents = [UIColor whiteColor];//高光的颜色
//    material.specular.contents = ImageFile(@"image/earth_specular");//设置高光的区域
    
    //光滑度 0~1越大越光滑
    material.shininess = 1.0;
    
    /*
     反射贴图
     以黑白图片精确定义了材质每个像素的反光程度.就是周围环境的光线在物体表面映射出的图像(实际就是天空盒子图像在物体表面的反光).
     */
//    material.reflective.contents = @[ImageFile(@"image/cube-1"),
//                                     ImageFile(@"image/cube-2"),
//                                     ImageFile(@"image/cube-3"),
//                                     ImageFile(@"image/cube-4"),
//                                     ImageFile(@"image/cube-5"),
//                                     ImageFile(@"image/cube-6")];
//
//    //菲涅尔系数，影响反射效果
//    material.fresnelExponent = 1.7;
    
    /*
     AO贴图 环境光闭塞贴图
     只有当场景中有ambient light环境光时才有作用,精确定义了每个像素在环境光作用下的被照亮程度.也就是让几何体的黑色部分不被环境光照亮而变浅.
     */
    material.ambientOcclusion.contents = nil;
    
    /*
     Emission map(发光贴图):在没有光线时,如果物体表面有荧光涂料,就会发光.发光贴图可以用来模拟这种物体.彩色贴图中,黑色不发光,亮色发光强,暗色发光弱.
     需要注意的是 在Scene Kit中Emission map(发光贴图)并不真正发光,只是模拟发光效果而已.就是说不能照亮其他物体,不能产生阴影.这点与其他3D创作工具不同.
     */
    material.emission.contents = nil;
    
    /*
     Multiply map(乘法贴图,正片叠底贴图):会影响其他所有效果.一般用来给最后的效果调整色彩或者亮度
     */
    material.multiply.contents = nil;
    
    /*
     Transparency map(透明贴图):黑色部分不透明,白色透明. 注意:球体内部需要开启double-sided mode才能看到
     */
    material.transparent.contents = nil;
    
    /*
     Metalness and Roughness maps(光泽度和粗糙度贴图):Xcode8引入的新特性,Physically Based Rendering (PBR)灯光模型可以使用Metalness和Roughness贴图.
     */
    material.metalness.contents = nil;
    material.roughness.contents = nil;
    
    //由于PBR光照模型中ambient和diffuse是锁定的，所以需要把locksAmbientWithDiffuse设置为false，否则ambient只能和diffuse取相同的值。
    material.locksAmbientWithDiffuse = NO;
    
    geometry.materials = @[material];
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
