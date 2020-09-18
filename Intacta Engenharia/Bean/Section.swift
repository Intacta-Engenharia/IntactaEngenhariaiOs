//
//  Section.swift
//  Intacta Engenharia
//
//  Created by Intacta Engenharia on 20/12/19.
//  Copyright © 2019 Intacta Engenharia. All rights reserved.
//

import UIKit

class Section: NSObject {
    var title: String!
    var items: [String]!
    init(title: String, items: [String]){
           self.title = title
           self.items = items
       }
    
    
}
