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
        return items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.todoCellIdentifier, for: indexPath)
        
        if let item = items?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.isDone ? .checkmark : .none
        }
        
        return cell
    }
    
    //MARK: - Table View Selected Row Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = items?[indexPath.row] {
            do{
                try self.realm.write {
                    item.isDone = !item.isDone
//                    realm.delete(item)
                }
            }catch{
                print("Error saving isDone status realm => \(error)")
            }
            
            tableView.reloadData()
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - SearchUIView Implementation
extension TodoViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            print(searchText)
            items = items?.filter("title CONTAINS[cd] %@", searchText).sorted(byKeyPath: "dateCreated",ascending: true)
            self.tableView.reloadData()
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
