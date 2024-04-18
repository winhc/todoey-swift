//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class TodoViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var items: Results<Item>?
    
    var selectedCategory: Category? {
        didSet{
            loadItems()
        }
    }
    
    @IBOutlet weak var todoUISearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoUISearchBar.delegate = self
        
        if let title = selectedCategory?.name{
            self.navigationItem.title = title
        }
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    @IBAction func addUIBarButtonItemPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey", message: "", preferredStyle: .alert
        )
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add Item", style: .default){
            (action) in
            if let itemName = textField.text, textField.text != "" {
                
                if let currentCategory = self.selectedCategory {
                    do {
                        try self.realm.write{
                            let item = Item()
                            item.title = itemName
                            currentCategory.items.append(item)
                        }
                    }catch{
                        print("Error saving realm => \(error)")
                    }
                    self.tableView.reloadData()
                }
                
            }
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func loadItems() {
        items = selectedCategory?.items.sorted(byKeyPath: "dateCreated",ascending: true)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        super.updateModel(at: indexPath)
        if let item = items?[indexPath.row] {
            do{
                try self.realm.write {
                    realm.delete(item)
                }
            }catch{
                print("Error deleting item realm => \(error)")
            }
        }
    }
    
}

