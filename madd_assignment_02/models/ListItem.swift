//
//  ListItem.swift
//  madd_assignment_02
//
//  Created by Chamindu Thiranjaya on 9/30/18.
//  Copyright © 2018 Chamindu Thiranjaya. All rights reserved.
//

import Foundation
class ListItem {
    
    var title: String = ""
    var artistName: String = ""
    var imageURL:String = ""
    var formattedPrice: String = ""
    var wrapperType: String = ""
    var genre: String = ""
    
    init(title:String,artistName:String,imageURL:String,formattedPrice:String,wrapperType:String,genre:String ) {
        self.title = title
        self.artistName = artistName
        self.imageURL = imageURL
        self.formattedPrice = formattedPrice
        self.wrapperType = wrapperType
        self.genre = genre
    }
}

