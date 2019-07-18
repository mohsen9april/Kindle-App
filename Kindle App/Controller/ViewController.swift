//
//  ViewController.swift
//  Kindle App
//
//  Created by Mohsen Abdollahi on 7/14/19.
//  Copyright © 2019 Mohsen Abdollahi. All rights reserved.
//

import UIKit

//class ViewController: UITableViewController {
class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var books : [Book]?
    
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarStyles()
        setupNavigationBarButton()
        view.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        navigationItem.title = "Kindle"
        
        safeArea = view.layoutMarginsGuide
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(bookCell.self, forCellReuseIdentifier: "CellId")
        tableView.backgroundColor = UIColor.darkGray
        tableView.separatorColor = UIColor(white: 1, alpha: 0.2)
        
        tableView.tableFooterView = UIView()
        
        
        fetchBooks()
        
    }
    
    func setupNavigationBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleMenu))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "amazon")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(HandleAmazon))
        
    }
    @objc func handleMenu(){
        print(123)
    }
    @objc func HandleAmazon(){
        print("amazon Pressed !")
    }
    
    
    func setupNavigationBarStyles() {
        //navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func fetchBooks(){
        if let url = URL(string: "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json") {
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
                        
                        // First Way to fetch and append data
                        //let title = bookDictionay["title"] as! String
                        //let author = bookDictionay["author"] as! String
                        //let book = Book(title: title, author: author, image: UIImage(named: "steve")!, pages: [])
                        //print(book.title)
                        
                        // Second Way to fetch and append data with dictionary
                        let book = Book(dictionary: bookDictionay )
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = books?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! bookCell
        let book = books?[indexPath.row]
        cell.didSetbook = book
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = self.books?[indexPath.item]
        let layout = UICollectionViewFlowLayout()
        let bookPageController = BookPagerController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: bookPageController)
        present(navController , animated: true, completion: nil)
        
        bookPageController.book = selectedBook
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    //Add Footer to TableView
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        
        //add Segment button in Footer
        let segmentedControll = UISegmentedControl(items: ["Cloud" , "Devices"])
        segmentedControll.translatesAutoresizingMaskIntoConstraints = false
        segmentedControll.tintColor = .white
        segmentedControll.selectedSegmentIndex = 0
        footerView.addSubview(segmentedControll)
        segmentedControll.widthAnchor.constraint(equalToConstant: 200).isActive = true
        segmentedControll.heightAnchor.constraint(equalToConstant: 30).isActive = true
        segmentedControll.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        segmentedControll.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        //Add a button in Footer
        let gridButton = UIButton(type: .system)
        gridButton.setImage(UIImage(named: "grid")?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        gridButton.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(gridButton)
        gridButton.leftAnchor.constraint(equalTo: footerView.leftAnchor , constant: 5).isActive = true
        gridButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        gridButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        gridButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        //Add a button in Footer
        let sortButton = UIButton(type: .system)
        sortButton.setImage(UIImage(named: "sort")?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(sortButton)
        sortButton.rightAnchor.constraint(equalTo: footerView.rightAnchor , constant: -5).isActive = true
        sortButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        sortButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sortButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
}

