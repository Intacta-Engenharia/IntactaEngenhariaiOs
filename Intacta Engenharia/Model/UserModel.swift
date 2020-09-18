//
//  UserModel.swift
//  Intacta Engenharia
//
//  Created by Intacta Engenharia on 12/06/20.
//  Copyright © 2020 Intacta Engenharia. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UserModel: NSObject {
    
    func retrieveLogin(cnpj: String, password:String,completion: @escaping (_ isLogged:Bool,_ message:String,_ user:User?) -> Void){
        let ref = Database.database().reference().child("users")
            .queryOrdered(byChild: "cnpj")
            .queryEqual(toValue: cnpj)
        ref.observe(.childAdded, with:  { (snapshot) in
            if(!snapshot.exists()){
                print("no exists snapshot")
                completion(true,"O cpjn informado está incorreto, verifique o cnpj e tente novamente.", nil)
                return
            }
            let cnpjs = snapshot.childSnapshot(forPath: "cnpj").value as! String
            if cnpjs.elementsEqual(cnpj) {
                let user =  User(cnpj: cnpjs,
                            password: snapshot.childSnapshot(forPath: "password").value as! String,
                            name: snapshot.childSnapshot(forPath: "name").value as! String)
                if(!user.password.elementsEqual(password) ){
                    completion(true,"A senha está incorreta, verifique sua senha e tente novamente", nil)
                }
                //print("user")
                //dump(user)
                completion(true,"",user)
                //self.openObras()
                //self.dismiss(animated: true, completion: {self.openObras()})
                /*self.dismiss(animated: true, completion: { () in
                    self.obrascontroller.user = self.user
                    self.obrascontroller.loaduser()
                })
                }*/
            }
        }) { (error) in
            completion(true,"Houve um erro ao realizar a busca dos dados", nil)
            print("Firebase error ↓")
            dump(error) }
    }
    
    func foundUser(cnpj:String,completion: @escaping (_ message:String,_ user:User?) -> Void){
        let ref = Database.database().reference().child("users")
        ref.observe(.childAdded, with:  { (snapshot) in
            if(!snapshot.exists()){
                completion("Houve um erro, informações do seu usuário não existe.",nil)
                return
            }
            let cnpjs = snapshot.childSnapshot(forPath: "cnpj").value as! String
            if cnpjs.elementsEqual(cnpj) {
                let user =  User(cnpj: cnpjs,
                            password: snapshot.childSnapshot(forPath: "password").value as! String,
                            name: snapshot.childSnapshot(forPath: "name").value as! String)
                completion("",user)
            }
        }) { (error) in
            completion("Houve um erro ao realizar a busca dos dados", nil)
            print("Firebase error ↓")
            dump(error)
            
        }
    }
    /*
    func checkUser() -> Bool {
          let preferences = UserDefaults.standard
          return preferences.object(forKey: "user") != nil
    }
    
    func checkinformation(user:User, password:String) -> Bool {
        print("user ↓")
        dump(user)
        
        if !user.password.elementsEqual(password){
            createDialog(title: "Desculpe", message: "A senha está incorreta, verifique sua senha e tente novamente")
            print("senha incorreta")
            return false
        }else{
            return true
        }
    }
    
    func foundeduser(snapshot: DataSnapshot) -> Bool{
        
        let s = snapshot.childSnapshot(forPath: "cnpj").value as! String

        if s.elementsEqual(self.cnpjinput.text!) {
            let p = snapshot.childSnapshot(forPath: "password").value as! String
            let n = snapshot.childSnapshot(forPath: "name").value as! String
            self.user =  User(cnpj: s, password: p, name: n)
            return true
        }
        
        return false
        
    }
    
    
    func retrieveDiaries(completion: @escaping (_ diaries:[Diario]) -> Void){
        var diariolist = [Diario]()
        let ref = Database.database().reference().child("obras").child(obra.key).child("diary")
        ref.observe(.childAdded, with: { (snapshot) in
            // Get user value
            let key = snapshot.key
            let value = snapshot.value as? NSDictionary
            
            let data = value?["data"] as? String ?? ""
            let fiscal = value?["fiscal"] as? String ?? ""
            let local = value?["local"] as? String ?? ""
            let operavel = value?["operavel"] as? Bool ?? false
            
            let diario:Diario = Diario(data: data, key: key, fiscal: fiscal, local: local, operavel: operavel)
            diariolist.append(diario)
            completion(self.orderByDate(diaries:diariolist))
          
        }) { (error) in
            print("Firebase(DiarioModel) error ↓")
            print(error.localizedDescription)
            dump(error)
        }
     
    }
 */

}
