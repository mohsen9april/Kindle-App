//
//  PageCell.swift
//  Kindle App
//
//  Created by Mohsen Abdollahi on 7/16/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit

class PageCell : UICollectionViewCell {
    
    let textLabel : UILabel = {
       let label = UILabel()
        label.text = "Text for Our Label Text for Our LabelText for Our LabelText for Our LabelText for Our LabelText for Our LabelText for Our LabelText for Our LabelText for Our LabelText for Our LabelText for Our LabelText for Our LabelText for Our LabelText for Our LabelText for Our LabelText for Our LabelText for Our LabelText for Our LabelText for Our LabelText for Our LabelText for Our Label"
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        
        addSubview(textLabel)
        //textLabel.frame = CGRect(x: 20, y: 200, width: 250, height: 50)
        textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
