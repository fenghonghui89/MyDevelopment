//
//  AdvancedOperators_BitwiseOperators.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//位运算符
/*
 位操作符通常在诸如图像处理和创建设备驱动等底层开发中使用，使用它可以单独操作数据结构中原始数据的比特位。在使用一个自定义的协议进行通信的时候，运用位运算符来对原始数据进行编码和解码也是非常有效的。
 
 Swift支持如下所有C语言的位运算符
 
 按位取反运算符~对一个操作数的每一位都取反。
 按位与运算符&对两个数进行操作，然后返回一个新的数，这个数的每个位都需要两个输入数的同一位都为1时才为1。
 按位或运算符|比较两个数，然后返回一个新的数，这个数的每一位设置1的条件是两个输入数的同一位其中一个不为0(即任意一个为1，或都为1)。
 按位异或运算符^比较两个数，然后返回一个数，这个数的每个位设为1的条件是两个输入数的同一位不同，如果相同就设为0。
 
 左移运算符<<和右移运算符>>会把一个数的所有比特位按以下定义的规则向左或向右移动指定位数。按位左移和按位右移的效果相当把一个整数乘于或除于一个因子为2的整数。向左移动一个整型的比特位相当于把这个数乘于2，向右移一位就是除于2。
 对无符整型的移位的效果如下：已经存在的比特位向左或向右移动指定的位数。被移出整型存储边界的的位数直接抛弃，移动留下的空白位用零0来填充。这种方法称为逻辑移位。
 对有符整形的移位的效果如下：对有符整型按位右移时，使用符号位(正数为0，负数为1)填充空白位，这就确保了在右移的过程中，有符整型的符号不会发生变化。这称为算术移位
 
 让已有的运算符也可以对自定义的类和结构进行运算，这称为运算符重载。=、(..?x:y) 不能重载
 标准的运算符不够玩，那你可以声明一些个性的运算符，但个性的运算符只能使用这些字符 / = - + * % < >！& | ^。~
 自定义运算符的结合性(associativity)的值默认为none，优先级(precedence)默认为100
 
 附：
 有符整形的二进制转十进制步骤：
 最高位为1，则为负数，先减一，再取反，看的出来的二进制如果放在无符号整形下是多少，然后添加负号
 例如：
 11111100 如果看成是无符号整形则是252
 -> 减一 11111011
 -> 取反 00000100
 -> 如果看成是无符号整形则是4
 -> 最高位为1 添加负号 -4
 所以可以看成是256-？=252
 */


import Foundation

func root_AdvancedOperators_BitwiseOperatorsd() {
  
}

//MARK:- <<< method >>>
//MARK:- 位运算符
//MARK:按位取反运算符 ~
private func func_BitwiseNOTOperators() {
  
  let bit:UInt8 = 0b11110000;
  let invertedBit = ~bit;//等于 0b00001111 十进制15
  print(invertedBit);
}

//MARK:按位与运算符 &
private func func_BitwiseANDOperators() {
  
  let firstSixBits: UInt8 = 0b11111100
  let lastSixBits: UInt8  = 0b00111111
  let middleFourBits = firstSixBits & lastSixBits  // 等于 00111100 十进制60
  print(middleFourBits)
}

//MARK:按位或运算符 |
private func func_BitwiseOROperators() {
  
  let someBits: UInt8 = 0b10110010
  let moreBits: UInt8 = 0b01011110
  let combinedbits = someBits | moreBits  // 等于 11111110 十进制254
  print(combinedbits)
}

//MARK:按位异或运算符 ^
private func func_BitwiseXOROperators() {
  
  let firstBits: UInt8 = 0b00010100
  let otherBits: UInt8 = 0b00000101
  let outputBits = firstBits ^ otherBits  // 等于 00010001 十进制17
  print(outputBits)
}

//MARK:按位左移<< / 右移运算符>>
private func func_BitwiseLeftRightShiftOperators() {
  
  let shiftBits: UInt8 = 4   // 即二进制的00000100
  shiftBits << 1             // 00001000
  shiftBits << 2             // 00010000
  shiftBits << 5             // 10000000
  shiftBits << 6             // 00000000
  shiftBits >> 2             // 00000001
  
  let pink: UInt32 = 0xCC6699
  let redComponent = (pink & 0xFF0000) >> 16    // redComponent 是 0xCC, 即 204
  let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent 是 0x66, 即 102
  let blueComponent = pink & 0x0000FF           // blueComponent 是 0x99, 即 153
  print(redComponent,greenComponent,blueComponent)
}








