//
//  TodoListViewControllerExtension.swift
//  Todoey
//
//  Created by winlwinoo on 15/04/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//MARK: - TableUIView Implementation
extension TodoViewController {
    
    //MARK: - Table View Data Source Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.todoCellIdentifier, for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isDone ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - Table View Selected Row Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itemArray[indexPath.row]
        
//        context.delete(item)
//        itemArray.remove(at: indexPath.row)
        
        
        item.isDone = !item.isDone
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - SearchUIView Implementation
extension TodoViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchText = searchBar.text {
            let request: NSFetchRequest<Todo> = Todo.fetchRequest()
            
            let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
            
//            request.predicate = predicate
            
            let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
            
            request.sortDescriptors = [sortDescriptor]
            
            loadItems(with: request,predicate: predicate)
            
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}
