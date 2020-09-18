//
//  DocumentsViewController.swift
//  Intacta Engenharia
//
//  Created by Intacta Engenharia on 27/01/20.
//  Copyright © 2020 Intacta Engenharia. All rights reserved.
//

import UIKit
import SafariServices

class DocumentsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var documentTableView: UITableView!
    //var referencepath: String!
    var obra: Obra!
    let documents=["ART","ART de Execução","Contrato","Cronograma","Ordem de serviço"]
    var documentlist = [Document]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model:DocumentModel = DocumentModel(obra: obra)
        model.retrieveDocuments { (documents) in
            self.documentlist = documents
            self.documentTableView.reloadData()
        }
        documentTableView.dataSource = self
        documentTableView.delegate = self
    }
    
    @IBAction func btndismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return documentlist.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)
        cell.textLabel?.text = documentlist[indexPath.item].title
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("what document")
        print(indexPath.row)
        //whereclick(row:indexPath.row)
        openUrl(url: documentlist[indexPath.item].url)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Documentos"
        
    }

    func openUrl(url:String ){
        print("openurl")
        print(url)
        let url = URL(string:url)
        //UIApplication.shared.open(url!, options: [:])
        let vc = SFSafariViewController(url: url!)
        present(vc, animated: true, completion: nil)
    }
    
    func whereclick(row:Int){
        switch row {
        case 0:
            if(!obra.art.isEmpty){
                openUrl(url: obra.art)
            }else{
                AppUtils.dialog(title:"Desculpe",message:"ART ainda não foi lançada no sistema",view: self)
            }
        case 1:
            if(!obra.artexecution.isEmpty){
                openUrl(url: obra.artexecution)

            }else{
                AppUtils.dialog(title:"Desculpe",message:"ART de Execução ainda não foi lançada no sistema",view:self)
            }
        case 2:
            if(!obra.contracturl.isEmpty){
                openUrl(url: obra.contracturl)
            }else{
                AppUtils.dialog(title:"Desculpe",message:"Contrato ainda não foi lançado no sistema",view:self)
            }
        case 3:
            if(!obra.cronogram.isEmpty){
                openUrl(url: obra.cronogram)
            }else{
                AppUtils.dialog(title:"Desculpe",message:"Cronograma ainda não foi lançado no sistema",view:self)
            }
        case 4:
            if(!obra.serviceorder.isEmpty){
                openUrl(url: obra.serviceorder)
            }else{
                AppUtils.dialog(title:"Desculpe",message:"Ordem de serviço ainda não foi lançada no sistema",view:self)
            }
        default:
            AppUtils.dialog(title:"Erro inesperado",message:"O Item selecionado não foi reconhecido",view:self)
        }
    }
}
