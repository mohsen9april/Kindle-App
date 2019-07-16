//
//  Models.swift
//  Kindle App
//
//  Created by Mohsen Abdollahi on 7/14/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit

class Book {
    
    var title : String
    var author : String
    var image : UIImage
    var pages : [Page]
    
    init(title : String, author : String ,image : UIImage , pages : [Page]) {
        self.title = title
        self.author = author
        self.pages = pages
        self.image = image
    }
    
    init(dictionary : [String : Any]) {
        self.title = ""
        self.author = ""
        image = UIImage(named: "steve")!
        pages = []
    }
    
    
}

class Page {
    var number : Int
    var text : String
    
    init(number : Int , text : String ) {
        self.number = number
        self.text = text
    }
}
