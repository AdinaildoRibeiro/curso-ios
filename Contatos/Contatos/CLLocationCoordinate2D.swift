//
//  CLLocationCoordinate2D.swift
//  Contatos
//
//  Created by ios7649 on 06/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D : Equatable {
    
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
        
    }
    
}
