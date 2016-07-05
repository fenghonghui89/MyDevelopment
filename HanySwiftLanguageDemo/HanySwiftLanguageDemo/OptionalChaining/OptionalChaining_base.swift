//
//  OptionalChaining_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//可选链

import Foundation


func root_OptionalChaining_base()  {
  


}

//MARK:通过自判断链接调用属性
private func kl_1(){

  let john:Person = Person();
  
  if let numberOfRooms = john.residence?.numberOfRooms {
    print("this is \(numberOfRooms)");
  }else{
    print("this is nil");
  }//this is nil
}

//MARK:使用自判断链接调用方法
private func kl_2(){

  let john:Person = Person();
  
  if ((john.residence?.printNumberOfRooms()) != nil) {
    print("It was possible to print the number of rooms.")
  } else {
    print("It was not possible to print the number of rooms.")
  }//It was not possible to print the number of rooms.
}

//MARK:使用自判断链接调用子脚本
private func kl_3(){
  
  let john:Person = Person();
  
  let johnsHouse = Residence()
  johnsHouse.rooms.append(Room(name: "Living Room"))
  johnsHouse.rooms.append(Room(name: "Kitchen"))
  
  john.residence = johnsHouse
  
  if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")//The first room name is Living Room.
  } else {
    print("Unable to retrieve the first room name.")
  }

}

//MARK:连接多层链接
private func kl_4(){
  
  let john:Person = Person();
  
  let johnsAddress = Address()
  johnsAddress.buildingName = "The Larches"
  johnsAddress.street = "Laurel Street"
  
  john.residence!.address = johnsAddress
  
  if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")//John's street name is Laurel Street.
  } else {
    print("Unable to retrieve the address.")
  }
}

//MARK:链接自判断返回值的方法
private func kl_5(){
  
  let john:Person = Person();
  
  if let upper = john.residence?.address?.buildingIdentifier()?.uppercaseString {
    print("John's uppercase building identifier is \(upper).")//John's uppercase building identifier is THE LARCHES.
  }
}

//MARK:自判断链接

class Person {
  
  var residence:Residence?
  
}


class Residence {
  
  var rooms = [Room]()
  var numberOfRooms: Int {
    return rooms.count
  }
  var address: Address?
  
  subscript(i: Int) -> Room {
    return rooms[i]
  }
  
  func printNumberOfRooms() {
    print("The number of rooms is \(numberOfRooms)")
  }
  
}

class Room {
  
  let name:String
  init(name:String){
    self.name = name;
  }
  
}


class Address {
  
  var buildingName: String?
  var buildingNumber: String?
  var street: String?
  
  func buildingIdentifier() -> String? {
    if (buildingName != nil) {
      return buildingName
    } else if (buildingNumber != nil) {
      return buildingNumber
    } else {
      return nil
    }
  }
}