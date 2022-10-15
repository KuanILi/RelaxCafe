//
//  CoffeeStoreInfo.swift
//  RelaxCafe
//
//  Created by kuani on 2022/9/27.
//

import Foundation

struct CoffeeStoreInfo:Codable{
    var name:String
    var city:String
    var url:String?
    var address:String?
    var latitude:String?
    var longitude:String
    var open_time:String?
}
