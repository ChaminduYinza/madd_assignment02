//
//  ListItem.swift
//  madd_assignment_02
//
//  Created by Chamindu Thiranjaya on 9/30/18.
//  Copyright © 2018 Chamindu Thiranjaya. All rights reserved.
//

import Foundation
class Item {
    
    var title: String = ""
    var artistName: String = ""
    var imageURL:String = ""
    
    init(title:String,artistName:String,imageURL:String) {
        self.title = title
        self.artistName = artistName
        self.imageURL = imageURL
    }
}

