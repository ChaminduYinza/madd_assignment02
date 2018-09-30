//
//  ViewController.swift
//  madd_assignment_02
//
//  Created by Chamindu Thiranjaya on 9/30/18.
//  Copyright © 2018 Chamindu Thiranjaya. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate{
    
    var listData:[ListItem] = []
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    /*
     * Call API function
     */
    func callAPI(paramURL:String) {
        print(paramURL)
        let url = NSURL(string: paramURL)
        //Send get request to the given URL
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            //Converting response to readable JSON
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                //Validate whether the reponse has a key named 'results'
                if let resultSet = jsonObj!.value(forKey: "results") as? NSArray {
                    //Clear current search history
                    self.listData.removeAll()
                    //Loop through each element in results array in response recieved from the API
                    for element in resultSet {
                        //Convert curent element into a NSDictionary
                        if let elementDict = element as? NSDictionary {
                            //Valdiate whehter the current element has a key named 'trackName'
                            if let title = elementDict.value(forKey: "trackName"){
                                //Valdiate whehter the current element has a key named 'artistName'
                                if let artistName = elementDict.value(forKey: "artistName"){
                                    //Valdiate whehter the current element has a key named 'artworkUrl60'
                                    if let imageURL = elementDict.value(forKey: "artworkUrl60"){
                                        //Append data into the ListItem
                                        self.listData.append(ListItem(title: title as! String, artistName: artistName as! String, imageURL: imageURL as! String))
                                        OperationQueue.main.addOperation {
                                            //Reload table view
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
    
    //Setting number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    //Setting the table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.lblTitle.text = listData[indexPath.row].title
        cell.lblArtistName.text = listData[indexPath.row].artistName
        let imgURL = NSURL(string: listData[indexPath.row].imageURL)
        let data = NSData(contentsOf: (imgURL as URL?)!)
        cell.imgLogo.image = UIImage(data: data! as Data)
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = self.searchBar.text
        //Concat typed string with URL
        let urlString = "https://itunes.apple.com/search?term="+searchText!+"&init=200&entity=software"
        //Encode url string
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        guard !(searchText?.isEmpty)! else {
            return
        }
        self.callAPI(paramURL: encodedString!)
    }
}


