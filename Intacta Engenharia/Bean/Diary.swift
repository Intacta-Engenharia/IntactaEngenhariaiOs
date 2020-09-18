//
//  Diary.swift
//  Intacta Engenharia
//
//  Created by Intacta Engenharia on 19/12/19.
//  Copyright © 2019 Intacta Engenharia. All rights reserved.
//

import UIKit

class Diary: NSObject {
    
    var data,key,fiscal,local: String!
    var operavel: Bool!
    
    init(data: String, key: String,fiscal: String , operavel: Bool) {
        self.data = data
        self.key = key
        self.fiscal = fiscal
        self.operavel = operavel
    }
 
}
