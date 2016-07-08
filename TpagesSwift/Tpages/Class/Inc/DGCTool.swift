//
//  DGCDefine.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 DGC. All rights reserved.
//


import Foundation
import UIKit


class DGCTool {
  
    /// 单例
  static let sharedInstance:DGCTool = {
    let instance = DGCTool()
    return instance
    
  }()
  
  /**
   通过一个字符串返回一个color
   
   :param: hexColor 0x111111? - #111111? - 111111?
   :param: alpha    透明度
   
   :returns: color
   */
  static func TColor(hexColor hexColor:String,alpha:CGFloat) -> UIColor {
    
    var cString:String = hexColor.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    cString = cString.uppercaseString
    
    //字符串应该为6或8位
    if cString.characters.count < 6 {
      return UIColor.clearColor()
    }
    
    //0x111111? - #111111? - 111111?
    if cString.hasPrefix("0x") {
      cString = cString.substringFromIndex(cString.startIndex.advancedBy(2))
    }else if cString.hasPrefix("#"){
      cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
    }else if cString.characters.count != 6 {
      return UIColor.clearColor()
    }
    
    //分离rgb
    var range:Range = Range(cString.startIndex..<cString.startIndex.advancedBy(2))
    let rString:String = cString.substringWithRange(range)
    
    range.startIndex = cString.startIndex.advancedBy(2)
    let gString:String = cString.substringWithRange(range)
    
    range.startIndex = cString.startIndex.advancedBy(4)
    let bString:String = cString.substringWithRange(range)
    
    //转为数值
    var r:UInt32 = 0,g:UInt32 = 0,b:UInt32 = 0
    NSScanner.init(string: rString).scanHexInt(&r)
    NSScanner.init(string: gString).scanHexInt(&g)
    NSScanner.init(string: bString).scanHexInt(&b)
    
    let rv:CGFloat = CGFloat(float_t(r)/255.0)
    let gv:CGFloat = CGFloat(float_t(g)/255.0)
    let bv:CGFloat = CGFloat(float_t(b)/255.0)
    
    return UIColor.init(red: rv, green: gv, blue: bv, alpha: alpha)
    
    
  }
  
  /**
   把plist文件转为数组
   
   :param: plistName plist文件名
   
   :returns: 数组
   */
  static func getPlistDataByName(plistName:String) -> NSArray{
    
    if let plistPath:String? = NSBundle.mainBundle().pathForResource(plistName, ofType: "plist") {
      let data = NSArray.init(contentsOfFile: plistPath!)
      return data!
    }else{
      dlog("no plist file")
    }
  }

  
  
  /**
   输出设备相关信息
   */
  static func showDeviceInfo(){
  
    //uuid
    let puuid:CFUUID = CFUUIDCreate(nil);
    let uuidCString:CFString = CFUUIDCreateString(nil, puuid)
    let uuid:String = CFStringCreateCopy(nil, uuidCString) as String

    
    //设备型号
    let name = UnsafeMutablePointer<utsname>.alloc(1)
    uname(name)
    
    let machine = withUnsafePointer(&name.memory.machine) { (ptr) -> String? in
      
      let int8Ptr = unsafeBitCast(ptr, UnsafePointer<CChar>.self)
      return String.fromCString(int8Ptr)
    }
    
    name.dealloc(1)
    
    var model:String = String()
    if let m = machine {
      model = m
    }
    
    //UIDevice
    let device = UIDevice()
    
    //NSProcessInfo
    let info = NSProcessInfo()
    
  
    print("{\n",
          "ip－－\(getIFAddresses().first)\n",
          "设备所有者的名称－－\(device.name)\n",
          "设备的类别－－\(device.model)\n",
          "设备的本地化版本－－\(device.localizedModel)\n",
          "设备运行的系统－－\(device.systemName)\n",
          "当前系统的版本－－\(device.systemVersion)\n",
          "NSUUID－－\(NSUUID.init().UUIDString)\n",
          "IDFV－－\(device.identifierForVendor?.UUIDString)\n",
          "电池充电水平－－\(device.batteryLevel*100)\n",
          "设备型号－－\(model)\n",
          "uuid－－\(uuid)",
          "processName－－\(info.processName)\n",
          "processorCount－－\(info.processorCount)\n",
          "processIdentifier－－\(info.processIdentifier)\n",
          "arguments－－\(info.arguments)\n",
          "environment－－\(info.environment)\n",
          "patchVersion－－\(info.operatingSystemVersion.patchVersion)\n",
          "globallyUniqueString－－\(info.globallyUniqueString)\n",
          "operatingSystemVersionString－－\(info.operatingSystemVersionString)\n",
          "physicalMemory－－\(info.physicalMemory/(1024*1024))\n",
          "systemUptime－－\(info.systemUptime)\n",
          "activeProcessorCount－－\(info.activeProcessorCount)\n",
          "}"
    )
    
  
  }
  
  /**
   ip
   
   :returns: ip
   */
  static func getIFAddresses() -> [String] {
    var addresses = [String]()
    
    // Get list of all interfaces on the local machine:
    var ifaddr : UnsafeMutablePointer<ifaddrs> = nil
    if getifaddrs(&ifaddr) == 0 {
      
      // For each interface ...
      var ptr = ifaddr
      
      while ptr != nil {
        
        let flags = Int32(ptr.memory.ifa_flags)
        var addr = ptr.memory.ifa_addr.memory
        
        // Check for running IPv4, IPv6 interfaces. Skip the     loopback interface.
        if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
          if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
            
            // Convert interface address to a human readable string:
            var hostname = [CChar](count: Int(NI_MAXHOST), repeatedValue: 0)
            if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),
              nil, socklen_t(0), NI_NUMERICHOST) == 0) {
              if let address = String.fromCString(hostname) {
                addresses.append(address)
              }
            }
          }
        }
        ptr = ptr.memory.ifa_next
      }
      
      freeifaddrs(ifaddr)
    }
    
    return addresses
  }


}




        