//
//  CelulaCustomizada.swift
//  Contatos
//
//  Created by ios7649 on 04/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

class CelulaCustomizada: UITableViewCell {

    @IBOutlet weak var imgFotoPerfil: UIImageView!
    
    @IBOutlet weak var txtNomePerfil: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgFotoPerfil.layer.cornerRadius = 15
        imgFotoPerfil.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
