//
//  Document.swift
//  Intacta Engenharia
//
//  Created by Intacta Engenharia on 25/08/20.
//  Copyright © 2020 Intacta Engenharia. All rights reserved.
//

import UIKit

class Document: NSObject {
    var title:String
    var url:String
    
    init( title:String, url:String){
        self.title = title
        self.url = url
    }
    
}
