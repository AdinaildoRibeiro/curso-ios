//
//  ClimaViewController.swift
//  Contatos
//
//  Created by ios7649 on 06/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit
import AlamofireImage

class ClimaViewController: UIViewController {

    @IBOutlet weak var lblMain: UILabel!
    @IBOutlet weak var lblCondicao: UILabel!
    @IBOutlet weak var lblMinimo: UILabel!
    @IBOutlet weak var lblMaximo: UILabel!
    @IBOutlet weak var imgCondicao: UIImageView!
    
    var contato: Contato!
    let api = Api()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCondicao.isHidden = true
        lblMaximo.isHidden = true
        lblMinimo.isHidden = true
        
        api.getWeather(by: contato ) { (clima, url, error) in
            
            guard error == nil else {
                self.navigationController?.popViewController(animated: true)
                return
            }
            
            guard let clima = clima else { return }
            
            self.lblCondicao.text = clima.weather[0].main
            self.lblMaximo.text = clima.main.max.description + "º"
            self.lblMinimo.text = clima.main.min.description + "º"
            
            if let url = url {
                self.imgCondicao.af_setImage(withURL: url)
                
            }
            
            
            self.lblCondicao.isHidden = false
            self.lblMaximo.isHidden = false
            self.lblMinimo.isHidden = false
                
            
        }
    }

}
