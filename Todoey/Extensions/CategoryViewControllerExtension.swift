//
//  CategoryViewControllerExtension.swift
//  Todoey
//
//  Created by winlwinoo on 17/04/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension CategoryViewController{
    // MARK: - TableView DataSource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.categoryCellIdentifier, for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    
    // MARK: - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.goToTodoUITableViewIdentifier, sender: self)
    }
}
