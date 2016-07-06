//
//  StringsAndCharacters_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//字符与字符串

/*
 swift的String是值类型
 不能添加字符或字符串到一个字符中，因为字符类型只能有一个字符
 \0 (null character),
 \\ (backslash), 
 \t (horizontal tab), 
 \n (line feed), 
 \r (carriage return), 
 \" (double quote) and 
 \' (single quote)
 特殊字符写法：\u{n}，n是1-8位的十六进制数
 */

import Foundation

func root_StringsAndCharacters_base() {
  kl_AccessAndChangeString();
}




//MARK: - <<< string >>> -
//MARK:定义 空字符串 打印输出
private func kl_InitializingAnEmptyString() {
  
  //定义
  let s = "avc";
  let s1:String = "avc";
  let s2:String = String("avc");
  print(s,s1,s2)
  
  let charArr:[Character] = ["a","b","c","d"]
  let satStr = String(charArr)
  print(satStr)
  
  //空字符串
  let s3 = "";
  let s4 = String();
  
  if s3.isEmpty{
    print("string is empty \(s4)")
  }
  
  
}

//MARK:打印输出
private func kl_print(){
  
  let t1:Int = 1;
  let t2:Float = 1.1;
  let t3:Character = "c";
  let t4:Bool = true;
  let t5:String = "abc"
  let t6:String = "def"
  
  let message = "\(t1)  \(t2) \(t3) \(t4) \(t5)"
  print(message);
  print("\(t1)  \(t2) \(t3) \(t4) \(t5)");
  print(t1,t2,t3,t4,t5);
  print(t5+" "+t6);
  
  let strs = ["a","b","c","d","e"]
  for char in strs {
    print(char, terminator: "~")
  }//a~b~c~d~e~
  
  print("aa","bb","cc", separator: "_", terminator: "~")//aa_bb_cc~
}

//MARK:字符串和字符的连接
private func kl_StringMutability() {
  
  let string1 = "hello"
  let string2 = " there"
  var welcome = string1 + string2
  // welcome now equals "hello there"
  
  var instruction = "look over"
  instruction += string2
  // instruction now equals "look over there"
  
  
  let exclamationMark:Character = "!"
  welcome.append(exclamationMark)
  // welcome now equals "hello there!"
  
}

//MARK:字符串中的特殊字符
private func kl_StringSpecialCharacter(){
  
  let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"// "Imagination is more important than knowledge" - Einstein
  let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
  let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
  let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496
  print(wiseWords,dollarSign,blackHeart,sparklingHeart)
  
}

//MARK:Unicode扩展字符集
private func kl_ExtendCharacter(){
  
  let eAcute: Character = "\u{E9}"                         // é
  let combinedEAcute: Character = "\u{65}\u{301}"          // e followed by ́
  // eAcute is é, combinedEAcute is é
  
  let precomposed: Character = "\u{D55C}"                  // 한
  let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
  // precomposed is 한, decomposed is 한
  
  let enclosedEAcute: Character = "\u{E9}\u{20DD}" // e followed 圆圈
  // enclosedEAcute is é⃝
  
  let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}" // u followed s
  // regionalIndicatorForUS is 🇺🇸
  
  print(eAcute,combinedEAcute,precomposed,decomposed,enclosedEAcute,regionalIndicatorForUS)
  
}

//MARK:字符串的字符数 characters.count
private func kl_CharacterCount() {
  
  let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
  print("unusualMenagerie has \(unusualMenagerie.characters.count) characters")
  
  var word = "cafe"
  print("the number of characters in \(word) is \(word.characters.count)")
  // Prints "the number of characters in cafe is 4"
  
  word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301
  
  print("the number of characters in \(word) is \(word.characters.count)")
}

//MARK:通过index查找字符串的字符
private func kl_AccessAndChangeString(){
  
  let greeting:String = "Guten Tag!"
  var result =  greeting[greeting.startIndex] // G
  result = greeting[greeting.endIndex.predecessor()] // 上一个 ! endIndex是最后一个字符的下一个位置，最好不要直接用
  result = greeting[greeting.startIndex.successor()] // 下一个 u
  
  let index = greeting.startIndex.advancedBy(7)//7
  result = greeting[index]// a
  result = greeting[index.predecessor()]//T
  
  print("~\(result)~")
  
  //indices 索引的集合
  for index in greeting.characters.indices {
    print("\(greeting[index])", terminator: "~")
  }
}

//MARK:字符串的插入和移除
private func kl_InsertAndRemove(){
  
  var welcome = "hello"
  welcome.insert("!", atIndex: welcome.endIndex)
  // welcome now equals "hello!"
  
  
  welcome.insertContentsOf(" there".characters, at: welcome.endIndex.predecessor())
  // welcome now equals "hello there!"
  
  
  welcome.removeAtIndex(welcome.endIndex.predecessor())
  // welcome now equals "hello there"
  
  
  let range = welcome.endIndex.advancedBy(-6)..<welcome.endIndex
  welcome.removeRange(range)
  // welcome now equals "hello"
  
}

//MARK:比较 判断
private func kl_stringCompare(){
  
  let name = "world"
  if name == "world" {
    print("hello, world")
  } else {
    print("I'm sorry \(name), but I don't recognize you")
  }
  
  let st = "abcjpg"
  if st.hasSuffix("jpg") {
    print("has suffix")
  }
}

//MARK:字符串大小写转换
private func kl_lowercaseString() {
  
  let str1:String = "abcd";
  let str2:String = "ABCD";
  
  print(str1.uppercaseString);
  print(str2.lowercaseString);
}

//MARK:枚举字符串中的所有字符 字符unicode编码
private func kl_unicode() {
  
  let dogString = "Dog‼🐶"
  
  //遍历
  for a in dogString.characters{
    print(a);
  }
  print("")
  
  for index in dogString.characters.indices {
    print("\(dogString[index])")
  }
  print("")
  
  //utf8
  for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
  }
  print("")// 68 111 103 226 128 188 240 159 144 182
  
  //utf16
  for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
  }
  print("")// 68 111 103 8252 55357 56374
  
  //unicode标量 相当于utf32
  for b in dogString.unicodeScalars{
    print("string:\(b) - value:\(b.value)");
  }
  
}
