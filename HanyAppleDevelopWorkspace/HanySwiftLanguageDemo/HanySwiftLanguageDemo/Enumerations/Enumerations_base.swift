//
//  Enumerations_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//枚举

import Foundation


func root_Enumerations_base() {
    
}

//MARK:- 枚举语法（支持嵌套） if判断
private func func_EnumerationSyntax(){
    
    enum CompassPoint {
        case north
        case south
        case east
        case west
        
        enum Planet {
            case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
        }
    }
    
    var directionToHead = CompassPoint.west
    directionToHead = .east
    print(directionToHead);
    
    
    if CompassPoint.north == directionToHead {
        
    }
    
    let planet = CompassPoint.Planet.earth;
    if planet == CompassPoint.Planet.jupiter {
        
    }
    
}

//MARK:- 枚举是值类型 用switch匹配枚举值
private func func_MatchingEnumerationValueswithASwitchStatement() {
    
    //定义
    enum CompassPoint{
        
        case east
        case south
        case west
        case north
        
        //存储型 类型属性
        static var None2:Int = 2
        
        //计算型 类型属性
        static var None: Int {
            return 111
        }
        
        //obj方法
        func objMethod(){
            print("enum objMethod~");
        }
        
        //静态方法
        static func classMethod(){
            print("enum classMethod~");
        }
        
        
    }
    
    //赋值 方法
    var dest = CompassPoint.east;
    dest = .north;
    print("enum 类型属性：\(CompassPoint.None2)");
    dest.objMethod();
    CompassPoint.classMethod();
    
    //判断
    switch dest {
    case .east:
        print("\(dest) this is east");
    default:
        print("\(dest) this is no east");
    }
    
    //枚举是值类型
    var bdest = dest;
    bdest = .south;
    print(dest,bdest);
}

//MARK:- enum的类型 枚举值(rawValue)
private func func_RawValues(){
    
    //enum的类型 case默认值
    enum VNodeFlags : UInt32 {
        case Delete = 0x00000001
        case Write = 0x00000002
        case Extended = 0x00000004
        case Attrib = 0x00000008
        case Link = 0x00000010
        case Rename = 0x00000020
        case Revoke = 0x00000040
        case None = 0x00000080
    }
    
    enum Human:String{
        case name = "default name";
        case age = "default age";
        case sex = "default sex";
    }
    
    let Tom = Human.sex.rawValue;
    print(Tom);
    
    
    //如果枚举类型是String，则枚举值是元素本身
    enum CompassPoint: String {
        case North, South, East, West
    }
    
    print("CompassPoint value:\(CompassPoint.North.rawValue)");
    
    //如果是整形，没有定义的枚举值默认自增长
    enum CustomNumTag:Int{
        case one = 1,two,three,four;
    }
    
    let num = CustomNumTag.four.rawValue;
    print(num);
    
    //通过枚举值获取对应case 获取不成功返回nil
    let num1 = CustomNumTag.init(rawValue: 3);
    switch num1! {//必须用可选值的强制解析
    case .one:
        print("1:\(CustomNumTag.one.rawValue)");
    case .two:
        print("2:\(CustomNumTag.two.rawValue)");
    case .three:
        print("3:\(CustomNumTag.three.rawValue)");
    case .four:
        print("4:\(CustomNumTag.four.rawValue)");
    }
    
    //用可选值的绑定来做
    if let num2 = CustomNumTag(rawValue:5){
        switch num2 {
        case .one:
            print("~1:\(CustomNumTag.one.rawValue)");
        case .two:
            print("~2:\(CustomNumTag.two.rawValue)");
        case .three:
            print("~3:\(CustomNumTag.three.rawValue)");
        case .four:
            print("~4:\(CustomNumTag.four.rawValue)");
        }
    }else{
        print("is nill..");
    }
    
    
    
    
}

//MARK:- 关联值(类似元组) if判断(类似元组的元组分解)
private func func_AssociatedValues() {
    
    //eg1
    enum Barcode{
        case upca(p1:Int,p2:Int,p3:Int);
        case qrCode(p:String);
    }
    
    var productBarcode = Barcode.upca(p1:1, p2:2, p3:3);
    productBarcode = .qrCode(p:"abc");//只能保留一个，所以会替换上面的
    
    switch productBarcode {
    case let .upca(numberSystem, identifier, check):
        print("UPC-A with value of \(numberSystem), \(identifier), \(check).")
    case let .qrCode(productCode):
        print("QR code with value of \(productCode).")
    }

    if case let Barcode.qrCode(p: "") = productBarcode {

    }

    
    //eg2
    enum Trade {
        case Buy(stock: String, amount: Int)
        case Sell(stock: String, amount: Int)
    }
    
    let trade = Trade.Buy(stock: "APPL", amount: 500)
    if case let Trade.Buy(stock, amount) = trade {
        print("buy \(amount) of \(stock)")
    }
}


//MARK:- 递归 / 间接(Indirect)类型 用于枚举的递归计算
private func func_RecursiveEnumerations() {
    
    
    enum ArithmeticExpression {
        case number(p:Int)
        indirect case addition(ArithmeticExpression, ArithmeticExpression)
        indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
    }
    
    
    
    let five = ArithmeticExpression.number(p:5)
    let four = ArithmeticExpression.number(p:4)
    let sum = ArithmeticExpression.addition(five, four)
    let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(p:2))
    print(product);
    
    
    func evaluate(expression: ArithmeticExpression) -> Int {
        
        switch expression {
        case let .number(value):
            return value
        case let .addition(left, right):
            return evaluate(expression:left) + evaluate(expression:right)
        case let .multiplication(left, right):
            return evaluate(expression:left) * evaluate(expression:right)
        }
    }
    
    print(evaluate(expression:product))
    // Prints "18" 上面三个return都会触发
    
    
}


//MARK:- mutating（允许改变隐藏参数self的case值）
private func func1_4() {
    
    enum TriStateSwitch {
        case off, low, high ;
        mutating func next() {
            switch self {
            case .off:
                self = .low
            case .low:
                self = .high
            case .high:
                self = .off
            }
        }
    }
    var ovenLight = TriStateSwitch.low
    ovenLight.next()
    ovenLight.next()
    print(ovenLight);
    
    
    
}


