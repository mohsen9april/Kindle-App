//
//  ViewController.swift
//  Kindle App
//
//  Created by Mohsen Abdollahi on 7/14/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var books : [Book]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(bookCell.self, forCellReuseIdentifier: "CellId")
        tableView.tableFooterView = UIView()
        view.backgroundColor = .white
        navigationItem.title = "Kindle"
        setupBooks()
        fetchBooks()
        
    }

    func fetchBooks(){
        if let url = URL(string: "https://www.google.com/test.json") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error to fetch external json book!")
                    debugPrint(error.localizedDescription)
                    //return
                }
                    guard let data = data else { return }

                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    guard let bookDictionaries = json as? [ [String : Any] ] else { return }
                    
                    self.books = []
                    
                    for bookDictionay in bookDictionaries {
                        let title = bookDictionay["title"] as! String
                        let author = bookDictionay["author"] as! String
                        
                        let book = Book(title: title, author: author, image: UIImage(named: "steve")!, pages: [])
                        print(book.title)
                        self.books?.append(book)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    
                } catch let jsonError {
                    print("Failed to Parse JSON properly")
                    print(jsonError)
                }

            }.resume()

        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = books?.count {
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! bookCell
        
        let book = books?[indexPath.row]
        cell.didSetbook = book
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedBook = self.books?[indexPath.item]
        
        let layout = UICollectionViewFlowLayout()
        let bookPageController = BookPagerController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: bookPageController)
        present(navController , animated: true, completion: nil)
        
        bookPageController.book = selectedBook

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    func setupBooks(){
        
        let page1 = Page(number: 1, text: "Text for the first page Steve Jobs")
        let page2 = Page(number: 2, text: "Text for the second page Steve Jobs")
        let SteveBookPages = [page1 , page2]
        let book1 = Book(title: "Steve Jobs", author: "Walter Isaacson", image: #imageLiteral(resourceName: "steve"), pages: SteveBookPages)
        
        let book2 = Book(title: "Bill Gates : A Biography", author: "Micael Becraft", image: #imageLiteral(resourceName: "bill"),
                         pages: [Page(number: 1, text: "Test for Page 1 Bill Gates"),
                                 Page(number: 2, text: "Text For Page 2 BillGates"),
                                 Page(number: 3, text: "Text For Page 3 BillGates"),
                                 Page(number: 4, text: "Text For Page 4 Biil Gates") ])
        
        self.books = [book1 , book2]
        
    }
    
}

