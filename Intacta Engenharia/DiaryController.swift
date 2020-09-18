//
//  DiaryController.swift
//  Intacta Engenharia
//
//  Created by Intacta Engenharia on 19/12/19.
//  Copyright © 2019 Intacta Engenharia. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Alamofire
import SwiftGifOrigin

class DiaryController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    

    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var diaryTableView: UITableView!
    /*@IBOutlet weak var picsview: UICollectionView!
    @IBOutlet weak var datatable: UITableView!*/
    @IBOutlet weak var navbar: UINavigationBar!
    var obra: Obra!
    var diary:Diary!
    var referencepath: String!
    
    var servicelist = [String]()
    var workerlist = [String]()
    var photolist = [String]()
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sections.append(Section(title: "Serviços iniciados",items: [String]()))
        self.sections.append(Section(title: "Pessoal da obra",items: [String]()))
        
        let model = DiaryModel(obra: obra)
        model.retrievePhotos(keydiario: diary.key, completion: { photos in
            self.photolist = photos
            self.photoCollectionView.reloadData()
        })
        model.retrieveWorkers(keydiario: diary.key, completion: { workers in
            self.workerlist = workers
            self.sections[1].items = self.workerlist
            self.diaryTableView.reloadData()
        })
        model.retrieveServices(keydiario: diary.key, completion: { services in
            self.servicelist = services
            self.sections[0].items = self.servicelist
            self.diaryTableView.reloadData()
        })
        navbar.topItem?.title = AppUtils.maskDate(data: diary.data)
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        diaryTableView.delegate = self
        diaryTableView.dataSource = self
    }
    
    @IBAction func backbutton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photolist.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
       //load picture from urls
        
        //let imageurl =  self.pictures[indexPath.row]
        //cell.imageview.image = setUrlImage(urlImage: imageurl)
        //cell.imageview.image = UIImage(named: "imageloading")
        
        setUrlImage(urlImage: photolist[indexPath.item],imageview: cell.imageview)
        //cell.imageview.image = UIImage(imageLiteralResourceName: "teste")
       
        return cell
        
    }
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /*let numberOfCellInRow : Int = 1
        let padding : Int = 5
        let collectionCellWidth : CGFloat = (collectionView.frame.size.width/CGFloat(numberOfCellInRow)) - CGFloat(padding)
        print("collectionCellWidth: " + "\(collectionCellWidth)")
        print("view.frame: " + "\(self.view.frame.size.width)")*/
        return CGSize(width: 280 , height:200)
        
    }*/
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell//-----------------------------
        let cell:PhotoCell = collectionView.cellForItem(at: indexPath) as! PhotoCell
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let imageView = UIImageView(frame: CGRect(x: 10, y: 50, width: 250, height: 230))
        imageView.image = cell.imageview.image!//-------------------------------------
        //self.setUrlImage(urlImage: photolist[indexPath.item],imageview:imageView)
        let height = NSLayoutConstraint(item: alert.view ?? nil!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 320)
        let width = NSLayoutConstraint(item: alert.view ?? nil!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
        alert.view.addConstraint(height)
        alert.view.addConstraint(width)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            // your actions here...
        }))
        
        alert.view.addSubview(imageView)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setUrlImage(urlImage: String, imageview:UIImageView) {
        var image : UIImage?
        //imageview.image = UIImage(imageLiteralResourceName: "imageloading")
        imageview.image = UIImage.gif(asset: "loading-gif")
        //imageview.loadGif(asset: "loading-gif")
        
        AF.download(urlImage).responseData{ response in
        debugPrint(response)
            if let data = response.value {
                image = UIImage(data: data)
                imageview.image = image
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"itemscell", for: indexPath)
        let name = self.sections[indexPath.section].items[indexPath.row]
        cell.textLabel?.text = name
        
         return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    /*func alphabeticlist(nlist: [String]) -> [String]?{
          
          let orderedlist = nlist.sorted(by: { (item1, item2) -> Bool in
              return item1.compare(item2) == ComparisonResult.orderedAscending
          })
          
          return orderedlist
    }*/
}
 
