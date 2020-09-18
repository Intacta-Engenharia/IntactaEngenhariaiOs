//
//  AppUtils.swift
//  Intacta Engenharia
//
//  Created by Intacta Engenharia on 12/06/20.
//  Copyright © 2020 Intacta Engenharia. All rights reserved.
//

import UIKit

class AppUtils: NSObject {
        
    static func dialog(title:String,message:String,view:UIViewController){
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        view.present(alert, animated: true, completion: nil)
    }
    
    static func maskDate(data: String) -> String{
        var d = ""
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yyyy"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEE, d MMM yyyy"
        dateFormatterPrint.locale = Locale(identifier: "pt_BR")

        if let date = dateFormatterGet.date(from: data) {
            //print(dateFormatterPrint.string(from: date))
            d = dateFormatterPrint.string(from: date)
        } else {
           print("Error convert date in string")
        }
        
        return d
        
    }
    
    static func progressDialog(view:UIViewController,message:String) -> UIAlertController{
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.message = message

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 50, y: 0, width: 150, height: 150))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)

        let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view as Any, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: alert.view.frame.height * 0.12)
        alert.view.addConstraint(height);
        
        view.present(alert, animated: true, completion: nil)
        return alert
    }
}
