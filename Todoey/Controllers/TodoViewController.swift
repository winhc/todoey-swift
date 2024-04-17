//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoViewController: UITableViewController {
    
    var itemArray: [Todo] = []
    
    var selectedCategory: Category? {
        didSet{
            loadItems()
        }
    }
    
    //    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("todo.plist")
    @IBOutlet weak var todoUISearchBar: UISearchBar!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoUISearchBar.delegate = self
        
        if let title = selectedCategory?.name{
            self.navigationItem.title = title
        }
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//        
//        loadItems()
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
                
                let item = Todo(context: self.context)
                item.title = itemName
                item.isDone = false
                item.category = self.selectedCategory
                
                self.itemArray.append(item)
                
                self.saveItems()
                
            }
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems(){
        do{
            try context.save()
        }catch {
            print("Error saving context => \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Todo> = Todo.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "category.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        
        do{
            itemArray = try context.fetch(request)
            self.tableView.reloadData()
        } catch {
            print("Error fetching data from context => \(error)")
        }
    }
    
    
    //    func saveItems(){
    //        let encoder = PropertyListEncoder()
    //        do{
    //            let data = try encoder.encode(self.itemArray)
    //            try data.write(to: self.dataFilePath!)
    //        }catch {
    //            print("Error encoding array \(error)")
    //        }
    //        self.tableView.reloadData()
    //    }
    //
    //    func loadItems() {
    //        if let data = try? Data(contentsOf: dataFilePath!){
    //            let decoder = PropertyListDecoder()
    //            do{
    //                itemArray = try decoder.decode([Todo].self, from: data)
    //            }catch{
    //                print("Decode error \(error)")
    //            }
    //        }
    //    }
    
}

