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
    var contato : Contato?
    var isNew = true
    var delegate : ManipulaContatoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let contato = self.contato {
            preencheForm(with: contato)
            isNew = false
        }else{
            contato = Contato()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func salvar(_ sender: AnyObject) {
        
        preencheContato()
        
        if isNew {
            dao.add(novoContato: contato!)
            delegate?.criado(contato: contato!)
        }else{
            delegate?.atualizado(contato: contato!)
        }
        
        _ = navigationController?.popViewController(animated: true)
    }

    private func preencheForm(with contato: Contato){
        txtNome.text = contato.nome
        txtTelefone.text = contato.telefone
        txtEndereco.text = contato.endereco
        txtSite.text = contato.site
    }
    
    private func preencheContato(){
        contato?.nome = txtNome.text!
        contato?.telefone = txtTelefone.text!
        contato?.endereco = txtEndereco.text!
        contato?.site = txtSite.text!
    }
    
    
}

