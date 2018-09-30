//
//  ViewController.swift
//  madd_assignment_02
//
//  Created by Chamindu Thiranjaya on 9/30/18.
//  Copyright © 2018 Chamindu Thiranjaya. All rights reserved.
//

import UIKit

let urlString = "https://itunes.apple.com/search?term=Puzzle&limit=200&entity=software"
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
    }
    
    
    func callAPI() {
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            print (data!)
        }).resume()
    }
    
}

