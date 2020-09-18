//
//  ObraModel.swift
//  Intacta Engenharia
//
//  Created by Intacta Engenharia on 16/06/20.
//  Copyright © 2020 Intacta Engenharia. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ObraModel: NSObject {

    func retrieveObras(cnpj:String,completion: @escaping (_ obras:[Obra]) -> Void){
        var obralist = [Obra]()
        let ref = Database.database().reference().child("obras")
        ref.observe(.childAdded, with: { (snapshot) in
            // Get user value
            let key = snapshot.key
            
            let value = snapshot.value as? NSDictionary
            
            let art = value?["art"] as? String ?? ""
            let artexecute = value?["artexecute"] as? String ?? ""
            let contracturl = value?["contracturl"] as? String ?? ""
            let cronogram = value?["cronogram"] as? String ?? ""
            let serviceorder = value?["serviceorder"] as? String ?? ""

            let obraname = value?["obra"] as? String ?? ""
            let data = value?["data"] as? String ?? ""
            let entry = value?["entry"] as? Int ?? 0
            let valor = value?["valor"] as? Int ?? 0
            let progress = value?["progress"] as? Int ?? 0
            let user = value?["user"] as? String ?? ""
            let local = value?["local"] as? String ?? ""

            let obra:Obra = Obra(contracturl: contracturl, data: data, entry: entry, obra: obraname, serviceorder: serviceorder, user: user, valor: valor, progress: progress, key: key, cronogram: cronogram, art: art, artexecution: artexecute, local: local)
            
            if user == cnpj {
                obralist.append(obra)
            }
            
            completion(obralist)
          // ...
        }) { (error) in
            print("Firebase(ObraModel) error ↓")
            print(error.localizedDescription)
            dump(error)
        }
        //print("ObraList ↓")
        //dump(obralist)
     
    }
    
    func retrieveEndServices(keyobra:String,completion: @escaping (_ endServices:[String]) -> Void){
        var endServicelist = [String]()
        let ref = Database.database().reference().child("obras").child(keyobra).child("endservices")
        ref.observe(.childAdded, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as! String
            endServicelist.append(value)
        
            completion(endServicelist)
          // ...
        }){ (error) in
            print("Firebase(ObraModel) error ↓")
            print(error.localizedDescription)
            dump(error)
        }
        //print("ObraList ↓")
        //dump(obralist)
     
    }
    
}
