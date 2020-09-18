//
//  ObrasController.swift
//  Intacta Engenharia
//
//  Created by Intacta Engenharia on 09/09/19.
//  Copyright © 2019 Intacta Engenharia. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ObrasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var userobras: UITableView!
    
    var user:User!
    var obralist = [Obra]()
    var usercnpj: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(!usercnpj.isEmpty){
            let model = UserModel()
            model.foundUser(cnpj: usercnpj) { (message,user) in
                if(!message.isEmpty){
                    AppUtils.dialog(title: "Desculpe", message: message, view: self)
                }
                self.user = user
                self.navbar.topItem?.title = user!.name
                let obraModel = ObraModel()
                obraModel.retrieveObras(cnpj:user!.cnpj,completion:{ obras in
                    self.obralist = obras
                    self.userobras.reloadData()
                })
            }
        }else{
            self.navbar.topItem?.title = user!.name
            let obraModel = ObraModel()
            obraModel.retrieveObras(cnpj:self.user!.cnpj,completion:{ obras in
                self.obralist = obras
                self.userobras.reloadData()
            })
        }
        self.userobras.delegate = self
        self.userobras.dataSource = self
        
    }
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "user")
        UserDefaults.standard.synchronize()
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginView") as! LoginViewController

        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDel.window?.rootViewController = loginVC
        /*let preferences = UserDefaults.standard
        let currentLevelKey = "user"
        preferences.removeObject(forKey: currentLevelKey)
        preferences.synchronize()
        self.dismiss(animated: true, completion: nil)*/
        
        print("user logout")
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "Selecione uma obra"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellidentifier", for: indexPath)
        
        // Fetch obra
        let obra = obralist[indexPath.row]
        // Configure Cell
        cell.textLabel?.text = obra.obra
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.detailTextLabel?.text = obra.local + " \nprogresso da obra: " + String(obra.progress) + "%"
    
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbarVC = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        tabbarVC.modalPresentationStyle = .custom
        if let vcs = tabbarVC.viewControllers,
            let diaryVC = vcs.first as? DiariesController,
            let endVC = vcs[1] as? EndServicesViewController,
            let documentVC = vcs.last as? DocumentsViewController{
                diaryVC.obra = obralist[indexPath.row]
                endVC.obra = obralist[indexPath.row]
                documentVC.obra = obralist[indexPath.row]
            
                self.present(tabbarVC, animated:true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return obralist.count
    }

}
