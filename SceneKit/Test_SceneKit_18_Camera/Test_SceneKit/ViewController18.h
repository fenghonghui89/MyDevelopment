//
//  ViewController18
//  TestProjectWithOCNoSB
//
//  Created by hanyfeng on 2018/1/18.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>

// Collision bit masks
typedef NS_OPTIONS(NSUInteger, AAPLBitmask) {
    AAPLBitmaskCollision        = 1UL << 2,
    AAPLBitmaskCollectable      = 1UL << 3,
    AAPLBitmaskEnemy            = 1UL << 4,
    AAPLBitmaskSuperCollectable = 1UL << 5,
    AAPLBitmaskWater            = 1UL << 6
};

@interface ViewController18 : UIViewController
@property (nonatomic, strong)SCNView *gameView;

@end

