//
//  DocumentModel.swift
//  Intacta Engenharia
//
//  Created by Intacta Engenharia on 25/08/20.
//  Copyright © 2020 Intacta Engenharia. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DocumentModel: NSObject {
    var obra: Obra
    
    init(obra:Obra) {
        self.obra = obra;
        //print("call init")
    }

    func retrieveDocuments(completion: @escaping (_ documents:[Document]) -> Void){
        var documentlist = [Document]()
        let ref = Database.database().reference().child("obras").child(obra.key).child("documents")
        ref.observe(.value, with: { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let value = child.value as? NSDictionary
                
                let title = value?["title"] as? String ?? ""
                let url = value?["url"] as? String ?? ""
                 
                let document:Document = Document(title: title, url: url)
                documentlist.append(document)
            }
            completion(documentlist)
        
         }) { (error) in
            print("Firebase(DiarioModel) error ↓")
            print(error.localizedDescription)
            dump(error)
         }
      
     }
}
