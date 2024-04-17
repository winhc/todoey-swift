//
//  TableViewController.swift
//  Todoey
//
//  Created by winlwinoo on 17/04/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categoryArray: [Category] = []
    
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
                
                let category = Category(context: self.context)
                category.name = name
                
                self.categoryArray.append(category)
                
                self.saveCategory()
                
            }
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    // MARK: - Data Manipulation Method
    
    func saveCategory(){
        do{
            try context.save()
        }catch {
            print("Error saving context => \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do{
            categoryArray = try context.fetch(request)
            self.tableView.reloadData()
        } catch {
            print("Error fetching data from context => \(error)")
        }
    }
    
}
