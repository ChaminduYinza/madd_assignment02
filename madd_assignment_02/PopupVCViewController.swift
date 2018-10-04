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
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var imageLogo: UIImageView!
    
    var getTitle = String()
    var getCompany = String()
    var getType = String()
    var getGenre = String()
    var getFree = String()
    var getLogo = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupUiBox.layer.cornerRadius = 10
        lblFree.layer.borderWidth = 1
        lblFree.layer.borderColor = UIColor.green.cgColor
        lblFree.layer.cornerRadius = 5
        
        
        
        lblFree.text = getFree
        lblTitle.text = getTitle
        lblCompany.text = getCompany
        lblType.text = getType
        lblGenre.text = getGenre
        imageLogo.image = getLogo
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
