//
//  ViewController.swift
//  madd_assignment_02
//
//  Created by Chamindu Thiranjaya on 9/30/18.
//  Copyright © 2018 Chamindu Thiranjaya. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource{
    
    let urlString = "https://itunes.apple.com/search?term=Puzzle&limit=200&entity=software"
    var listData:[ListItem] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
    }
        
    func callAPI() {
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            print (data!)
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                if let resultSet = jsonObj!.value(forKey: "results") as? NSArray {
                    for element in resultSet {
                        if let elementDict = element as? NSDictionary {
                            if let title = elementDict.value(forKey: "trackName"){
                                if let artistName = elementDict.value(forKey: "artistName"){
                                    if let imageURL = elementDict.value(forKey: "artworkUrl60"){
                                        self.listData.append(ListItem(title: title as! String, artistName: artistName as! String, imageURL: imageURL as! String))
                                        OperationQueue.main.addOperation {
                                             self.tableView.reloadData()
                                        }
                                       
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }).resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.lblTitle.text = listData[indexPath.row].title
         cell.lblArtistName.text = listData[indexPath.row].artistName
        let imgURL = NSURL(string: listData[indexPath.row].imageURL)
        let data = NSData(contentsOf: (imgURL as? URL)!)
        cell.imgLogo.image = UIImage(data: data as! Data)
        return cell
    }
}

