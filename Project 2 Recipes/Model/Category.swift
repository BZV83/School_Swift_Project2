//
//  Category.swift
//  Project 2 Recipes
//
//  Created by Brendan Vick on 11/29/24.
//

import Foundation
import SwiftData

@Model
final class Category {
    @Attribute(.unique) var name: String
    @Relationship(deleteRule: .cascade) var recipes: [Recipe]
    
    init(name: String) {
        self.name = name
        self.recipes = []
    }
}
