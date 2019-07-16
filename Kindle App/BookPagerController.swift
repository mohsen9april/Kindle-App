//
//  BookPagerController.swift
//  Kindle App
//
//  Created by Mohsen Abdollahi on 7/15/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit

class BookPagerController : UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    var book : Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        //navigationItem.title = "Book"
        navigationItem.title = self.book?.title
        
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "CellId")
        
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .horizontal
        
        layout?.minimumLineSpacing = 0
        collectionView.isPagingEnabled = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleClose))
        
    }
    @objc func handleClose() {
        dismiss(animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return book?.pages.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! PageCell
        cell.textLabel.text = book?.pages[indexPath.item].text
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: (view.frame.height) - 44 - 20)
    }
}
