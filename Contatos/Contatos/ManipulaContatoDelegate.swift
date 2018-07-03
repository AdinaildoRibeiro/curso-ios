//
//  ManipulaContatoDelegate.swift
//  Contatos
//
//  Created by ios7649 on 03/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

protocol ManipulaContatoDelegate {

    func criado(contato:Contato)
    
    func atualizado(contato:Contato)
}
