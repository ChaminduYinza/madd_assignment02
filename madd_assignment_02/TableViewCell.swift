//
//  TableViewCell.swift
//  madd_assignment_02
//
//  Created by Chamindu Thiranjaya on 9/30/18.
//  Copyright © 2018 Chamindu Thiranjaya. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblArtistName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
