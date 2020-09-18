//
//  Obra.swift
//  Intacta Engenharia
//
//  Created by Intacta Engenharia on 11/09/19.
//  Copyright © 2019 Intacta Engenharia. All rights reserved.
//

import UIKit

class Obra: NSObject {
    init(contracturl: String, data: String, entry: Int, obra: String, serviceorder: String, user: String, valor: Int, progress: Int,key: String,cronogram:String,art:String,artexecution:String, local:String) {
        self.contracturl = contracturl
        self.data = data
        self.entry = entry
        self.obra = obra
        self.serviceorder = serviceorder
        self.user = user
        self.valor = valor
        self.progress = progress
        self.key = key
        self.cronogram = cronogram
        self.art = art
        self.artexecution = artexecution
        self.local = local
    }
    
    var contracturl,data,obra,serviceorder,user,key,cronogram,art,artexecution,local: String
    var valor,progress,entry: Int
    
    
    

    

}
