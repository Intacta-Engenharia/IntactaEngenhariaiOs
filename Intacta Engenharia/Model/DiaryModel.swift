//
//  DiaryModel.swift
//  Intacta Engenharia
//
//  Created by Intacta Engenharia on 17/06/20.
//  Copyright © 2020 Intacta Engenharia. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DiaryModel: NSObject {
    
    var obra: Obra
    
    init(obra:Obra) {
        self.obra = obra;
        //print("call init")
    }

    func retrieveDiaries(completion: @escaping (_ diaries:[Diary]) -> Void){
        var diariolist = [Diary]()
        let ref = Database.database().reference().child("obras").child(obra.key).child("diary")
            .queryOrdered(byChild: "data")
            //.queryLimited(toLast: 10)
        ref.observe(.value, with: { (snapshot) in
             // Get user value
            /*print("snapshot ↓")
            print(snapshot)
            let key = snapshot.key
            let value = snapshot.value as? NSDictionary*/
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let key = child.key
                let value = child.value as? NSDictionary
                
                let data = value?["data"] as? String ?? ""
                let fiscal = value?["fiscal"] as? String ?? ""
                let operavel = value?["operavel"] as? Bool ?? false
                 
                let diario:Diary = Diary(data: data, key: key, fiscal: fiscal, operavel: operavel)
                diariolist.append(diario)
                
            }
            completion(self.orderByDate(diaries:diariolist))
        
         }) { (error) in
            print("Firebase(DiarioModel) error ↓")
            print(error.localizedDescription)
            dump(error)
         }
      
     }
     func orderByDate(diaries:[Diary]) -> [Diary]{
         var aux = diaries
         let df = DateFormatter()
         df.dateFormat = "dd/MM/yyyy"
         aux.sort(by:{df.date(from:$0.data)! > df.date(from:$1.data)!})
         return aux
     }
     
     func retrievePhotos(keydiario:String,completion: @escaping (_ photos:[String]) -> Void){
         var photolist = [String]()
         let ref = Database.database().reference().child("obras").child(obra.key).child("diary").child(keydiario).child("photos")
         ref.observe(.childAdded, with: { (snapshot) in
             // Get user value
             let value = snapshot.value as! String
             photolist.append(value)
             completion(photolist)
           
         }) { (error) in
             print("Firebase(DiarioModel) error ↓")
             print(error.localizedDescription)
             dump(error)
         }
      
     }
    func retrieveWorkers(keydiario:String,completion: @escaping (_ workers:[String]) -> Void){
        var workerlist = [String]()
     let ref = Database.database().reference().child("obras").child(obra.key).child("diary").child(keydiario).child("workers")
        ref.observe(.childAdded, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as! String
            workerlist.append(value)
            completion(workerlist)
          
        }) { (error) in
            print("Firebase(DiarioModel) error ↓")
            print(error.localizedDescription)
            dump(error)
        }
     
    }
     func retrieveServices(keydiario:String,completion: @escaping (_ services:[String]) -> Void){
         var serivcelist = [String]()
         let ref = Database.database().reference().child("obras").child(obra.key).child("diary").child(keydiario).child("services")
         ref.observe(.childAdded, with: { (snapshot) in
             // Get user value
             let value = snapshot.value as! String
             serivcelist.append(value)
             completion(serivcelist)
           
         }) { (error) in
             print("Firebase(DiarioModel) error ↓")
             print(error.localizedDescription)
             dump(error)
         }
      
     }

}
