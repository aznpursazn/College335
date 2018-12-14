//
//  info.swift
//  Lab7
//
//  Created by Kathy Nguyen on 10/28/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import Foundation
import UIKit

class Informations {
    var infos:[Info] = []
    
    func lengthInfo() -> Int {
        return infos.count
    }
    
    func getInfo(index: Int) -> Info {
        return infos[index]
    }
    
    func addInfo(info: Info) {
        infos.append(info)
    }
    
    func deleteAll() {
        infos.removeAll()
    }
}

class Info {
    var long: NSNumber?
    var lat: NSNumber?
    var date: NSString?
    var dep: NSNumber?
    var mag: NSNumber?
    var src: NSString?
    var eqid: NSString?
    
    init(ln: NSNumber, lt: NSNumber, d: NSString, dp: NSNumber, m: NSNumber, s: NSString, e: NSString) {
        long = ln
        lat = lt
        date = d
        dep = dp
        mag = m
        src = s
        eqid = e
    }
}
