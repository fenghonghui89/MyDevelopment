/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information

*/

@import simd;
@import SceneKit;
@import GameController;

#import "ViewController18.h"

@interface ViewController18() {
    // Nodes to manipulate the camera
    SCNNode *_cameraYHandle;
    SCNNode *_cameraXHandle;
    
    
    UITouch *_panningTouch;
}

- (void)panCamera:(CGPoint)direction;

@end

@interface ViewController18 (GameControls)


@end
