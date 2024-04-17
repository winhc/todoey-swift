//
//  Category.swift
//  Todoey
//
//  Created by winlwinoo on 17/04/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var dateCreated: Date = Date()
    let items: List<Item> = List<Item>()
}
