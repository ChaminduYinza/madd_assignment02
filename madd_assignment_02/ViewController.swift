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
                print(jsonObj!.value(forKey: "results"))
            }
        }).resume()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
}

