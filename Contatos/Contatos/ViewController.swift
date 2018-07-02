//
//  ViewController.swift
//  Contatos
//
//  Created by ios7649 on 02/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtTelefone: UITextField!
    @IBOutlet weak var txtEndereco: UITextField!
    @IBOutlet weak var txtSite: UITextField!
    
    let dao = ContatoDAO.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func salvar(_ sender: AnyObject) {
        
        let contato = Contato()
        
        contato.nome = txtNome.text!
        contato.telefone = txtTelefone.text!
        contato.endereco = txtEndereco.text!
        contato.site = txtSite.text!
        
        print(contato)
        
        dao.add(novoContato: contato)
        
        _ = navigationController?.popViewController(animated: true)
    }

}

