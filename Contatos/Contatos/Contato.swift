//
//  Contato.swift
//  Contatos
//
//  Created by ios7649 on 02/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class Contato: NSManagedObject, MKAnnotation {

    @NSManaged var nome: String!
    @NSManaged var endereco: String!
    @NSManaged var telefone: String!
    @NSManaged var site: String!
    @NSManaged var foto: UIImage!
    @NSManaged var latitude: NSNumber!
    @NSManaged var longitude: NSNumber!
    
    
    
    override var description: String {
        return " Name = " + nome! + " / Endereco = " + endereco! + " / Telefone: " + telefone! + " / Site = " + site
    }
    
    var title: String? { return nome }
    
    var subtitle: String? { return telefone }
    
    static func ==(lhs: Contato, rhs: Contato) -> Bool {
        return lhs.nome == rhs.nome
    }
    
    var coordinate: CLLocationCoordinate2D{
        
        if(latitude == nil || longitude == nil){
            return kCLLocationCoordinate2DInvalid
        }
        
        return CLLocationCoordinate2D(latitude: latitude.doubleValue, longitude: longitude.doubleValue)
    }
    
}

