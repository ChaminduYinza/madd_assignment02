//
//  PopupVCViewController.swift
//  madd_assignment_02
//
//  Created by Rushan Edirisuriya on 10/4/18.
//  Copyright © 2018 Chamindu Thiranjaya. All rights reserved.
//

import UIKit

class PopupVCViewController: UIViewController {

    @IBOutlet weak var popupUiBox: UIView!
    @IBOutlet weak var lblFree: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        popupUiBox.layer.cornerRadius = 10
        lblFree.layer.borderWidth = 1
        lblFree.layer.borderColor = UIColor.green.cgColor
        lblFree.layer.cornerRadius = 5
        
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    


}
