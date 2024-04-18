//
//  CategoryViewControllerExtension.swift
//  Todoey
//
//  Created by winlwinoo on 17/04/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import UIKit
//import ChameleonFramework

extension CategoryViewController{
    
    // MARK: - TableView DataSource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let category = categories?[indexPath.row]
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
//        cell.backgroundColor = .randomFlat()
        
        cell.textLabel?.text = category?.name
        
        return cell
    }
    
    
    // MARK: - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.goToTodoUITableViewIdentifier, sender: self)
    }
}
