//
//  ViewController.swift
//  madd_assignment_02
//
//  Created by Chamindu Thiranjaya on 9/30/18.
//  Copyright © 2018 Chamindu Thiranjaya. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate{
    
    var listData:[ListItem] = []
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.hideKeyboard()
        
    }
    
    //Call InternetValidity class Connection function in order to validate internet conectivity
    override func viewDidAppear(_ animated: Bool) {
        if !InternetValidtity.Connection(){
            self.Alert(Message: "Your device is not connected with internet")
        }
    }
    
    //Alert function
    func Alert (Message: String){
        let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
                                        //Valdiate whehter the current element has a key named 'genres'
                                        if let genres = elementDict.value(forKey: "genres"){
                                            //Setting genres array into NSArray inorder to access
                                            if let  genresDict = genres as? NSArray{
                                                //Valdiate whehter the current element has a key named 'wrapperType'
                                                if let wrapperType = elementDict.value(forKey: "wrapperType"){
                                                    //Valdiate whehter the current element has a key named 'formattedPrice'
                                                    if let formattedPrice = elementDict.value(forKey: "formattedPrice"){
                                                        //Append data into the ListItem
                                                        self.listData.append(ListItem(title: title as! String, artistName: artistName as! String, imageURL: imageURL as! String, formattedPrice: formattedPrice as! String, wrapperType: wrapperType as! String, genre: genresDict[0] as! String))
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PopUpVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationController = segue.destination as? PopupVCViewController {
            destinationController.getTitle = listData[(tableView.indexPathForSelectedRow?.row)!].title
            destinationController.getCompany = listData[(tableView.indexPathForSelectedRow?.row)!].artistName
            destinationController.getType = listData[(tableView.indexPathForSelectedRow?.row)!].wrapperType
            destinationController.getGenre = listData[(tableView.indexPathForSelectedRow?.row)!].genre
            destinationController.getFree = listData[(tableView.indexPathForSelectedRow?.row)!].formattedPrice
            let imgURL = NSURL(string : listData[(tableView.indexPathForSelectedRow?.row)!].imageURL)
            let data = NSData(contentsOf: (imgURL as URL?)!)
            destinationController.getLogo = UIImage(data : data! as Data)!
        }
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

extension UIViewController {
    //This function will trigger when the user type anywhere else after promt the keyboard and the current keyboard will be hiden from the view
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


