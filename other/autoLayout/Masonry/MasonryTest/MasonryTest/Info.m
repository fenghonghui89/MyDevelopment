//
//  Info.m
//  MasonryTest
//
//  Created by 冯鸿辉 on 16/1/12.
//  Copyright © 2016年 DGC. All rights reserved.
//

#import <Foundation/Foundation.h>


 mas_makeConstraints 只负责新增约束 Autolayout不能同时存在两条针对于同一对象的约束 否则会报错
 mas_updateConstraints 针对上面的情况 会更新在block中出现的约束 不会导致出现两个相同约束的情况
 mas_remakeConstraints 则会清除之前的所有约束 仅保留最新的约束
 三种函数善加利用 就可以应对各种情况了


注意点1： 使用 mas_makeConstraints方法的元素必须事先添加到父元素的中，例如[self.view addSubview:view];
注意点2： masequalTo 和 equalTo 区别：masequalTo 比equalTo多了类型转换操作，一般来说，大多数时候两个方法都是 通用的，但是对于数值元素使用mas_equalTo。对于对象或是多个属性的处理，使用equalTo。特别是多个属性时，必须使用equalTo,例如 make.left.and.right.equalTo(self.view);