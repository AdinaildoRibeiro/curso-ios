//
//  ActionManager.swift
//  Contatos
//
//  Created by ios7649 on 04/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit


class ActionManager {
    
    let controller: UIViewController
    
    init(presentIn controller: UIViewController){
        self.controller = controller
    }
    
    func apresentaAcoes(of contato:Contato){
        
        let alerta = UIAlertController(title: "", message: contato.nome, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cancelar = UIAlertAction(title: "cancel".localized, style: UIAlertActionStyle.cancel, handler: nil)
        let ligar = UIAlertAction(title: "call".localized, style: UIAlertActionStyle.default){ (action) in
            self.ligar(telefone: contato.telefone)
        }
        let navegar = UIAlertAction(title: "browse".localized, style: UIAlertActionStyle.default){ (action) in
            self.navegar(site: contato.site)
        }
        // outra sintaxe para o clousure 
        let localizar = UIAlertAction(title: "localized.address".localized, style: UIAlertActionStyle.default, handler: { (action) in return self.localizar(endereco: contato.endereco) })
        
        alerta.addAction(cancelar)
        alerta.addAction(ligar)
        alerta.addAction(navegar)
        alerta.addAction(localizar)
        
        controller.present(alerta, animated: true, completion: nil)
    }
    
    private func openApp(by url:String){
        
        guard let appUrl = URL(string: url) else {
            return
        }
        
        UIApplication
            .shared
                .open(appUrl, options: [:], completionHandler: nil)
    }
    
    private func ligar(telefone: String){
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone {
            openApp(by: "tel:" + telefone)
        }else {
            let alerta = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelar = UIAlertAction(title: "", style: UIAlertActionStyle.cancel, handler: nil)
            
            alerta.addAction(cancelar)
            
            controller.present(alerta, animated: true, completion: nil)
        }
    }
    
    private func navegar(site: String){
        
        var appSite = site
        
        if !site.hasPrefix("http") {
            appSite = "http://" + site
        }
        
        openApp(by: appSite)
        
    }
    
    private func localizar(endereco: String){
        guard let url = "https://maps.google.com/maps?q= \(endereco)"
                            .addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        else {
            return
        }
        
        openApp(by: url)
    }
    
}
