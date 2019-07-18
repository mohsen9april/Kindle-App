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
    var coverImageUrl : String
    
    init(title : String, author : String ,image : UIImage , pages : [Page] ) {
        self.title = title
        self.author = author
        self.pages = pages
        self.image = image
        self.coverImageUrl = ""
    }
    
    init(dictionary : [String : Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.author = dictionary["author"] as? String ?? ""
        self.coverImageUrl = dictionary["coverImageUrl"] as? String ?? ""
        image = UIImage(named: "steve")!
        
        //pages
        var bookPages = [Page]()
        if let pagesDictionaries = dictionary["pages"] as? [[String : Any]] {
            for pageDictionary in pagesDictionaries {
                if let pageText = pageDictionary["text"] as? String {
                    let page = Page(number: 1, text: pageText)
                    bookPages.append(page)
                }
            }
        }
         pages = bookPages
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
