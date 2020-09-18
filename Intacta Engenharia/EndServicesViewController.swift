//
//  SecondViewController.swift
//  Intacta Engenharia
//
//  Created by Intacta Engenharia on 06/09/19.
//  Copyright © 2019 Intacta Engenharia. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EndServicesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //@IBOutlet weak var finishservicestable: UITableView!
    @IBOutlet weak var endServiceTableView: UITableView!
    var obra:Obra?
    var endServicelist = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = ObraModel()
        model.retrieveEndServices(keyobra: self.obra!.key, completion:{ endServices in
            self.endServicelist = endServices
            self.endServiceTableView.reloadData()
            //print("endServices ↓")
            //dump(self.endServicelist)
        })
        endServiceTableView.delegate = self
        endServiceTableView.dataSource = self
        //loadservices()
    }
    
    @IBAction func backbutton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return endServicelist.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "EndServiceCell", for: indexPath)
          
          // Fetch obra
          let name = endServicelist[indexPath.row]
           // Configure Cell
          cell.textLabel?.text = name
          //cell.detailTextLabel?.text = String(value) + "%"
          return cell
      }
}

