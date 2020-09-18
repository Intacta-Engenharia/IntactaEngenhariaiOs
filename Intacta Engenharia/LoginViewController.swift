//
//  LoginViewController.swift
//  Intacta Engenharia
//
//  Created by Intacta Engenharia on 09/09/19.
//  Copyright © 2019 Intacta Engenharia. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase


class LoginViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var load: UIActivityIndicatorView!
    @IBOutlet weak var btnlogin: UIButton!
    @IBOutlet weak var passwordinput: UITextField!
    @IBOutlet weak var cnpjinput: UITextField!
    var obrascontroller : ObrasViewController!
    var user:User!
      override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func check(_ sender: UIButton) {
        if(checkFields()){
            return
        }
        let model = UserModel()
        model.retrieveLogin(cnpj: self.cnpjinput.text!, password: passwordinput.text!) { (isLogged, message ,user) in
            self.user = user
            if(!message.isEmpty){
                AppUtils.dialog(title: "Desculpe", message: message, view: self)
                return
            }
            let preferences = UserDefaults.standard
            let currentLevelKey = "user"
            preferences.set(user?.cnpj, forKey: currentLevelKey)
            let didSave = preferences.synchronize()
            if !didSave {
                print(("erro ao salvar dados do usuário no dispositivo"))
                AppUtils.dialog(title: "Desculpe", message: "Houve um erro ao salvar os dados do usuário no dispositivo", view: self)
            }
            self.openObras()
            //self.dismiss(animated: true, completion:nil)
 
            
        }
    }

    
    func openObras(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ObrasView") as! ObrasViewController
        vc.modalPresentationStyle = .custom
        vc.user = self.user
        //self.obrascontroller.loaduser()
        //vc.loaduser()
        
        self.present(vc,animated:true,completion:nil)
    }
    
    func checkFields() -> Bool{
        if(cnpjinput.text!.isEmpty){
            cnpjinput.placeholder = "Preencha este campo"
            cnpjinput.backgroundColor = UIColor.red
            return true
        }
        if(passwordinput.text!.isEmpty){
            passwordinput.placeholder = "Preencha este campo"
            passwordinput.backgroundColor = UIColor.red
            return true
        }
        return false
    }
    
    
}
