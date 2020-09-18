//
//  User.swift
//  Intacta Engenharia
//
//  Created by Intacta Engenharia on 10/09/19.
//  Copyright © 2019 Intacta Engenharia. All rights reserved.
//

import UIKit

class User: NSObject {
    var cnpj:String
    var password:String
    var name:String
    
    init( cnpj:String, password:String, name:String){
        self.cnpj = cnpj
        self.password = password
        self.name = name
    }
    
}
