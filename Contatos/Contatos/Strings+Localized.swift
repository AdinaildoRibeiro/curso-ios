//
//  Strings+Localized.swift
//  Contatos
//
//  Created by ios7649 on 03/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit

extension String {

    var localized : String{
        return NSLocalizedString(self, comment: "")
    }
    
}
