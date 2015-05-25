//
//  MDAnimal.h
//  MyDevelopmentOC
//
//  Created by hanyfeng on 15/5/22.
//  Copyright (c) 2015年 MD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDAnimal : NSObject
{
    int _i;
    @package int _ipackage;//可以在包内部访问，一个项目一定是在同一个包下
@public int _ipublic;//可以在任意位置访问
@private int _iprivate;//只可以在本类的内部访问
@protected int _iprotected;//可以在本类内部或子类内部访问
}

-(void)eat;
-(void)say;
@end
