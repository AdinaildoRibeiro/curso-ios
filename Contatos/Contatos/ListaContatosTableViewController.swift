//
//  ListaContatosTableViewController.swift
//  Contatos
//
//  Created by ios7649 on 02/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

class ListaContatosTableViewController: UIViewController {
    
    
    @IBOutlet weak var tableview: UITableView!
    
    fileprivate let dao = ContatoDAO.shared
    fileprivate var indexPathSelecionado: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(acoes(gesto:)))
        
        tableview.addGestureRecognizer(longPress)
        // tableview.gestureRecognizers = [longPress] // substitui todos os gestos ja adicionados pelo passado no array
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableview.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //if dao.size() > 0 {
        //    let indexPath = IndexPath(row: 0, section: 0)
        //    tableview.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
        //}
        
        if let indexPath = indexPathSelecionado{
            tableview.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.middle)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(2)){
                self.tableview.deselectRow(at: indexPath, animated: true)
                self.indexPathSelecionado = nil
            }
            
            
        }
    }
    
    @objc func acoes(gesto: UIGestureRecognizer){
                
        guard gesto.state == UIGestureRecognizerState.began else {
            return
        }
        
        let ponto = gesto.location(in: tableview)
        
        guard let indexPath = tableview.indexPathForRow(at: ponto) else{
            return
        }
        
        let contato = dao.findBy(posicao: indexPath.row)
        
        ActionManager(presentIn: self).apresentaAcoes(of: contato)
        
        
    }
}


extension ListaContatosTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dao.size()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "cell_ID", for: indexPath) as? CelulaCustomizada
            else {
                fatalError("error.custom.cell".localized)
            }
        
        let contato = dao.findBy(posicao: indexPath.row)
        // Configure the cell...
        cell.txtNomePerfil?.text = contato.nome
        cell.imgFotoPerfil?.image = contato.foto
        return cell
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
                   return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCellEditingStyle.delete{
            let contato = dao.findBy(posicao: indexPath.row)
            let titulo = "confirm.delete.header".localized
            let mensagem = String(format: "confirm.delete.body".localized, arguments: [contato.nome] )
            
            let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: UIAlertControllerStyle.alert)
            let cancelarAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil)
            let excluirAction = UIAlertAction(title: "remove", style: UIAlertActionStyle.destructive)
            { (action) in
                self.dao.remove(byId: indexPath.row)
                self.tableview.deleteRows(at: [indexPath], with: .fade)
            }
            
            alerta.addAction(excluirAction)
            alerta.addAction(cancelarAction)
            present(alerta, animated: true, completion: nil)
        }
    }
}

extension ListaContatosTableViewController: UITableViewDelegate  {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let contato = dao.findBy(posicao: indexPath.row)
        
        performSegue(withIdentifier: "ToFormContatoForUpdate", sender: contato)
        
        /*if let formContato = storyboard?.instantiateViewController(withIdentifier: "FormContato") as? ViewController {
            formContato.contato = contato
            navigationController?.pushViewController(formContato, animated: true)
            
        }*/
    }
}

extension ListaContatosTableViewController  {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let contato = sender as? Contato
                
        if segue.identifier == "ToFormContatoForUpdate" {
            let form = segue.destination as? ViewController
            form?.delegate = self
            form?.contato = contato
        }
        
        if segue.identifier == "ToFormContatoForInsert" {
            print("Inserindo...")
        }
        
        if segue.identifier == "weatherSegue" {
            let form = segue.destination as? ClimaViewController
            form?.contato = contato
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
    }
    
    
}

extension ListaContatosTableViewController  : ManipulaContatoDelegate {

    func criado(contato:Contato){
        if let row = dao.getPosicao(by: contato) {
            indexPathSelecionado = IndexPath(row: row, section: 0)
        }
    }
    
    func atualizado(contato:Contato){
        if let row = dao.getPosicao(by: contato) {
            indexPathSelecionado = IndexPath(row: row, section: 0)
        }
    }
}
