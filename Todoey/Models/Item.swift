//
//  Item.swift
//  Todoey
//
//  Created by winlwinoo on 17/04/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var isDone: Bool = false
    @objc dynamic var dateCreated: Date = Date()
    var category = LinkingObjects(fromType: Category.self, property: "items")
}
