//
//  Clima.swift
//  Contatos
//
//  Created by ios7649 on 06/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import Foundation
import ObjectMapper

class Clima: Mappable{
 
    var main : Temperatura!
    var weather: [WheaterInfo]!
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        main <- map["main"]
        weather <- map["weather"]
    }
    
}

class WheaterInfo: Mappable {
    var main: String!
    var icon: String!
    var description: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        main <- map["main"]
        icon <- map["icon"]
        description <- map["description"]
    }
}

class Temperatura: Mappable {
    var min: Double!
    var max: Double!
    
    required init?(map: Map) {
        //
    }
    
    func mapping(map: Map) {
        min <- map["temp_min"]
        max <- map["temp_max"]
    }
}



