//
//  TableViewController.swift
//  Todoey
//
//  Created by winlwinoo on 17/04/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        loadCategory()
    }
    
    // MARK: - Add New Category Action
    
    @IBAction func addCategoryUIBarButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert
        )
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add Category", style: .default){
            (action) in
            if let name = textField.text, textField.text != "" {
                
                let category = Category()
                category.name = name
                
                self.saveCategory(category: category)
                
            }
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    // MARK: - Data Manipulation Method
    
    func saveCategory(category: Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch {
            print("Error saving realm => \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategory() {
        
        categories = realm.objects(Category.self).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }
    
    // MARK: - override update model
    override func updateModel(at indexPath: IndexPath) {
        super.updateModel(at: indexPath)
        if let safetyCategories = self.categories {
            do{
                try self.realm.write {
                    self.realm.delete(safetyCategories[indexPath.row].items)
                    self.realm.delete(safetyCategories[indexPath.row])
                }
            }catch{
                print("Delete Error \(error)")
            }
        }
    }
    
}
