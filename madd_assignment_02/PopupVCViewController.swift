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
        lblFree.layer.borderColor = UIColor(hexString: "#0FC0BF").cgColor
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

//Convert hexcode to UIColor
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
