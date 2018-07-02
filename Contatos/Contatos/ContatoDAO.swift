//
//  ContatoDAO.swift
//  Contatos
//
//  Created by ios7649 on 02/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

class ContatoDAO: NSObject {

    private var contatos: [Contato]
    
    static let shared = ContatoDAO()
    
    /* outra forma de implementar o Design Pattern Singleton
    private static var instance: ContatoDAO
    
    static func sharedInstance() -> ContatoDAO{
        if instance == nil{
            instance = ContatoDAO()
        }
        return instance
    }
    */
    
    private override init(){
        contatos = Array()
    }
    
    func add(novoContato: Contato){
        contatos.append(novoContato)
        print(contatos)
    }
    
    func size() ->Int {
        return contatos.count
    }
    
    func findBy(posicao:Int) -> Contato {
        return contatos[posicao]
    }
    
}
