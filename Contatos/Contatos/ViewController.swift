//
//  ViewController.swift
//  Contatos
//
//  Created by ios7649 on 02/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtTelefone: UITextField!
    @IBOutlet weak var txtEndereco: UITextField!
    @IBOutlet weak var txtSite: UITextField!
    @IBOutlet weak var imgFotoContato: UIImageView!
    @IBOutlet weak var imgLoader: UIActivityIndicatorView!
    @IBOutlet weak var imgLoaderCoordenadas: UIActivityIndicatorView!
    @IBOutlet weak var txtLongitude: UITextField!
    @IBOutlet weak var txtLatitude: UITextField!
    
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
            contato = dao.novoContato()
            
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
            dao.update(contato: contato!)
            delegate?.atualizado(contato: contato!)
        }
        
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func getCoordenadas(_ sender: UIButton) {
        let enconder = CLGeocoder()
        
        defer{
            sender.isHidden = false
            self.imgLoaderCoordenadas.stopAnimating()
        }
        
        
        imgLoaderCoordenadas.startAnimating()
        sender.isHidden = true
        
        guard let endereco = txtEndereco.text
            else { return }
        
        enconder.geocodeAddressString(endereco) {
            (resultado, erro) in
            
            guard erro == nil else { return }
            
            guard let localidades = resultado else { return }
            
            if (localidades.count <= 0 ) { return }
                       
            guard let localizacao = localidades[0].location else { return }
            
            let coordenadas = localizacao.coordinate
            
            self.txtLatitude.text = coordenadas.latitude.description
            self.txtLongitude.text = coordenadas.longitude.description
        }
        
        
    }
    
    private func preencheForm(with contato: Contato){
        txtNome.text = contato.nome
        txtTelefone.text = contato.telefone
        txtEndereco.text = contato.endereco
        txtSite.text = contato.site
        imgFotoContato.image = contato.foto
        
        if let foto = imgFotoContato {
            foto.layer.cornerRadius = foto.layer.cornerRadius / 2
            foto.clipsToBounds = true
        }
        if let latitude = contato.latitude {
            txtLatitude.text = latitude.description
        }
        if let longitude = contato.longitude{
            txtLongitude.text = longitude.description
        }
    }
    
    private func preencheContato(){
        contato?.nome = txtNome.text!
        contato?.telefone = txtTelefone.text!
        contato?.endereco = txtEndereco.text!
        contato?.site = txtSite.text!
        if let foto = imgFotoContato.image{
            contato?.foto = foto
        }
        if let latitude =  Double(txtLatitude.text!)   {
            contato?.latitude = NSNumber(value: latitude)
        }
        if let longitude = Double(txtLongitude.text!){
            contato?.longitude = NSNumber(value: longitude)
        }
    }
    
    @IBAction func selecionarFoto(_ sender: UITapGestureRecognizer) {
        
        imgLoader.startAnimating()
        imgFotoContato.isUserInteractionEnabled = false
        
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let alerta = UIAlertController(title: "choose.source".localized,
                                           message: nil,
                                           preferredStyle: UIAlertControllerStyle.actionSheet)
            
            let camera = UIAlertAction(title: "take.photo".localized,
                                       style: UIAlertActionStyle.default,
                                       handler: { (action) in return self.exibeImagem(from: UIImagePickerControllerSourceType.camera) })
            
            let library = UIAlertAction(title: "photo.library".localized,
                                        style: UIAlertActionStyle.default) {
                                            action in self.exibeImagem(from: UIImagePickerControllerSourceType.photoLibrary)
                                        }
            
            let cancelar = UIAlertAction(title: "cancel".localized,
                                         style: UIAlertActionStyle.cancel,
                                         handler: { (action) in return self.stopImageLoader() })
            
            alerta.addAction(camera)
            alerta.addAction(library)
            alerta.addAction(cancelar)
            
            present(alerta, animated: true,completion: nil)
            
        }else {
            exibeImagem(from: UIImagePickerControllerSourceType.photoLibrary)
        }
        
        
        
    }
    
    private func exibeImagem(from source: UIImagePickerControllerSourceType){
        let imageController = UIImagePickerController()
        imageController.allowsEditing = true
        imageController.delegate = self
        imageController.sourceType = source
        
        present(imageController, animated: true,completion: nil)

    }
    
}

extension ViewController : UINavigationControllerDelegate , UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // executa o bloco antes de qualquer return
        defer{
            stopImageLoader()
            picker.dismiss(animated: true, completion: nil)
        }
        
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            return
        }
        
        imgFotoContato.image = image
        imgFotoContato.layer.cornerRadius = imgFotoContato.layer.cornerRadius / 2
        imgFotoContato.clipsToBounds = true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        stopImageLoader()
        picker.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func stopImageLoader(){
        imgLoader.stopAnimating()
        imgFotoContato.isUserInteractionEnabled = true
        
    }
    
}

