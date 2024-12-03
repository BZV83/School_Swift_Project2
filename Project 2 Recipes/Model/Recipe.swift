//
//  Item.swift
//  Project 2 Recipes
//
//  Created by Brendan Vick on 11/14/24.
//

import Foundation
import SwiftData

@Model
final class Recipe {
    @Attribute(.unique) var name: String
    @Attribute var summary: String
    @Attribute var instructions: String
    @Attribute var ingredients: String
    @Relationship var category: Category?
    var isFavorite: Bool = false
    
    init(name: String, summary: String, ingredients: String, instructions: String, category: Category?) {
        self.name = name
        self.summary = summary
        self.ingredients = ingredients
        self.instructions = instructions
        self.category = category
    }
}
