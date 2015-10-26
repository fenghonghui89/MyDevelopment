//
//  TGInitialViewController.h
//  TGCameraViewController
//
//  Created by Bruno Furtado on 15/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//

@import UIKit;
#import "TGCamera.h"


@interface TGInitialViewController : UIViewController
<
    UINavigationControllerDelegate, UIImagePickerControllerDelegate,
    TGCameraDelegate
>

@end