//
//  DiariesController.swift
//  Intacta Engenharia
//
//  Created by Intacta Engenharia on 18/12/19.
//  Copyright © 2019 Intacta Engenharia. All rights reserved.
//

import UIKit
import FirebaseDatabase
class DiariesController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var diarytable: UITableView!
    var obra:Obra!
    var diarylist = [Diary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let alert = AppUtils.progressDialog(view: self, message: "Carregando os diários de obras")
        let model = DiaryModel(obra: obra)
        model.retrieveDiaries { (diaries) in
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                alert.dismiss(animated: false, completion: nil)
            }
            self.diarylist = diaries
            self.diarytable.reloadData()
        }
        diarytable.delegate = self
        diarytable.dataSource = self
        //loadiaries()
    }
    

    @IBAction func backbutton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    /*@IBAction func documentbutton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let documentVC = storyboard.instantiateViewController(withIdentifier: "DocumentsViewController") as! DocumentsViewController
        documentVC.obra = self.obra
        //documentVC.referencepath = "obras/" + self.obra.key
        self.present(documentVC,animated:true,completion:nil)
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diarylist.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //orderByDate()
        
        let diary = self.diarylist[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "diarycell", for: indexPath)
        cell.textLabel?.text = AppUtils.maskDate(data: diary.data)
        if(diarylist[indexPath.row].operavel){
            cell.backgroundColor = UIColor.white
            cell.textLabel?.textColor = UIColor.darkText
            cell.detailTextLabel?.textColor = UIColor.darkText
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.detailTextLabel?.text = diary.fiscal
        }else{
            cell.backgroundColor = UIColor.lightGray
            cell.textLabel?.textColor = UIColor.darkText
            cell.detailTextLabel?.textColor = UIColor.darkText
            cell.detailTextLabel?.text = "Dia não operável"
        }
    
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let diaryVC = storyboard.instantiateViewController(withIdentifier: "DiaryController") as! DiaryController
        diaryVC.modalPresentationStyle = .custom
        if(diarylist[indexPath.row].operavel){
            diaryVC.diary = self.diarylist[indexPath.row]
            diaryVC.obra = self.obra
            //diaryVC.referencepath = "obras/" + self.obra.key + "/diary/" + d.key
            self.present(diaryVC, animated: true, completion: nil)
        }

        
    }
}
