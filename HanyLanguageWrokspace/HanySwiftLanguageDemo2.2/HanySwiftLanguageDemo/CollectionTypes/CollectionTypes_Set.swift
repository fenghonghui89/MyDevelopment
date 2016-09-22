//
//  CollectionTypes_Set.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//集合

import Foundation


func root_CollectionTypes_Set() {
  
}


//MARK:- <<< method >>>
//MARK:创建
private func func_createSet() {
  
  var letters = Set<Character>()
  print("the set count:\(letters.count)")
  
  letters = []
  print("the set count:\(letters.count)")
  
  var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
  var favoriteGenres1: Set = ["Rock", "Classical", "Hip hop"]
  
}

//MARK:访问 增删 判断 遍历
private func func_AccessAndModifySet() {
  
  //创建
  var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
  print("I have \(favoriteGenres.count) favorite music genres.")
  // Prints "I have 3 favorite music genres."
  
  //判断是否为空
  if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
  } else {
    print("I have particular music preferences.")
  }
  // Prints "I have particular music preferences."
  
  
  //插入
  favoriteGenres.insert("Jazz")
  // favoriteGenres now contains 4 items
  
  //移除
  if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
  } else {
    print("I never much cared for that.")
  }
  // Prints "Rock? I'm over it."
  
  
  //判断是否包含
  if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
  } else {
    print("It's too funky in here.")
  }
  // Prints "It's too funky in here."
  
  
  //遍历
  for genre in favoriteGenres {
    print("\(genre)")
  }
  // Classical
  // Jazz
  // Hip hop
  
  
  //排序
  for genre in favoriteGenres.sort() {
    print("\(genre)")
  }
  // Classical
  // Hip hop
  // Jazz
  
  
}

//MARK:集合之间的交集并集 union intersect subtract exclusiveOr
private func func_PerformingSetOperations (){
  
  
  let oddDigits: Set = [1, 3, 5, 7, 9]
  let evenDigits: Set = [0, 2, 4, 6, 8]
  let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
  var result = [Int]();
  
  result = oddDigits.union(evenDigits).sort()
  // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] 并集
  
  result = oddDigits.intersect(evenDigits).sort()
  // [] 交集
  
  result = oddDigits.subtract(singleDigitPrimeNumbers).sort()
  // [1, 9] 自身减去两个集合中的交集
  
  result = oddDigits.exclusiveOr(singleDigitPrimeNumbers).sort()
  // [1, 2, 9] 两个集合的并集 减去两个集合的交集
  
  for value in result {
    print(value)
  }
  
}

//MARK:集合之间的关系判断 isSubsetOf isSupersetOf isDisjointWith
private func func_CampareTwoSet() {
  
  let houseAnimals: Set = ["🐶", "🐱"]
  let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
  let cityAnimals: Set = ["🐦", "🐭"]
  
  houseAnimals.isSubsetOf(farmAnimals)
  // true
  
  farmAnimals.isSupersetOf(houseAnimals)
  // true
  
  farmAnimals.isDisjointWith(cityAnimals)
  // true
  
  
}
