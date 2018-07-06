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
    private let coreData: CoreDataUtil<Contato>
    static let shared = ContatoDAO()
    
    override init(){
        coreData = CoreDataUtil<Contato>()
        contatos = coreData.findAll()
    }
    
    
    /* outra forma de implementar o Design Pattern Singleton
    private static var instance: ContatoDAO
    
    static func sharedInstance() -> ContatoDAO{
        if instance == nil{
            instance = ContatoDAO()
        }
        return instance
    }
    */
    
    func novoContato() -> Contato{
        return coreData.newManaged()
    }
    
    func add(novoContato: Contato){
        contatos.append(novoContato)
        coreData.commit()
    }
    
    func update(contato: Contato){
        coreData.commit()
    }
    
    func size() ->Int {
        return contatos.count
    }
    
    func findBy(posicao:Int) -> Contato {
        return contatos[posicao]
    }
    
    func remove(byId:Int){
        let contato = findBy(posicao: byId)
        coreData.remove(managedObject: contato)
        contatos.remove(at: byId)
        coreData.commit()
    }
    
    func getPosicao(by contato: Contato) -> Int? {
        //return contatos.index(where: { other in return other.nome == contato.nome })
        return contatos.index(where: { other in
            other.nome == contato.nome
        })
    }
    
    func findAll() -> [Contato]{
        return contatos
    }
}
