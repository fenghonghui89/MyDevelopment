//
//  TypeCasting_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation


//MARK:- <<< method >>>
//MARK:is检查类型
func func_CheckingType() {
  
  let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
  ]// the type of "library" is inferred to be [MediaItem]
  
  
  //is检查类型
  var movieCount = 0
  var songCount = 0
  
  for item in library {
    if item is Movie {
      movieCount += 1
    } else if item is Song {
      songCount += 1
    }
  }
  
  print("~~Media library contains \(movieCount) movies and \(songCount) songs")
  // Prints "Media library contains 2 movies and 3 songs"
  
}


//MARK:as向下转型
func func_Downcasting() {
  
  let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
  ]// the type of "library" is inferred to be [MediaItem]
  
  //as向下转型
  for item in library {
    if let movie = item as? Movie {
      print("Movie: '\(movie.name)', dir. \(movie.director)")
    } else if let song = item as? Song {
      print("Song: '\(song.name)', by \(song.artist)")
    }
  }
  
  // Movie: Casablanca, dir. Michael Curtiz
  // Song: Blue Suede Shoes, by Elvis Presley
  // Movie: Citizen Kane, dir. Orson Welles
  // Song: The One And Only, by Chesney Hawkes
  // Song: Never Gonna Give You Up, by Rick Astley
}


//MARK:AnyObject 对象类型
func func_AnyObject() {
  
  let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
  ]
  
  for object in someObjects {
    let movie = object as! Movie
    print("Movie: '\(movie.name)', dir. \(movie.director)")
  }
  // Movie: 2001: A Space Odyssey, dir. Stanley Kubrick
  // Movie: Moon, dir. Duncan Jones
  // Movie: Alien, dir. Ridley Scott
  
  //简洁
  for movie in someObjects as! [Movie] {
    print("Movie: '\(movie.name)', dir. \(movie.director)")
  }
  // Movie: 2001: A Space Odyssey, dir. Stanley Kubrick
  // Movie: Moon, dir. Duncan Jones
  // Movie: Alien, dir. Ridley Scott
  
  
}

//MARK:Any 包含非对象类型
func func_Any(){
  
  var things = [Any]()
  
  things.append(0)
  things.append(0.0)
  things.append(42)
  things.append(3.14159)
  things.append("hello")
  things.append((3.0, 5.0))
  things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
  things.append({ (name: String) -> String in "Hello, \(name)" })
  
  //注意必须是非可选as
  for thing in things {
    switch thing {
    case 0 as Int:
      print("zero as an Int")
    case 0 as Double:
      print("zero as a Double")
    case let someInt as Int:
      print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
      print("a positive double value of \(someDouble)")
    case is Double:
      print("some other double value that I don't want to print")
    case let someString as String:
      print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
      print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
      print("a movie called '\(movie.name)', dir. \(movie.director)")
    case let function as String -> String:
      print(function("Hany"))
    default:
      print("something else")
    }
  }
  // zero as an Int
  // zero as a Double
  // an integer value of 42
  // a positive double value of 3.14159
  // a string value of "hello"
  // an (x, y) point at 3.0, 5.0
  // a movie called Ghostbusters, dir. Ivan Reitman
  // Hello, Hany
}


//MARK:- <<< class >>>
//MARK:类型转换
class MediaItem {
  var name: String
  init(name: String) {
    self.name = name
  }
}

class Movie: MediaItem {
  var director: String
  init(name: String, director: String) {
    self.director = director
    super.init(name: name)
  }
}

class Song: MediaItem {
  var artist: String
  init(name: String, artist: String) {
    self.artist = artist
    super.init(name: name)
  }
}
