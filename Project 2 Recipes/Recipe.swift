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
    var name: String
    var instructions: String
    var ingredients: String
    var categories: String
    
    init(name: String, ingredients: String, instructions: String, categories: String) {
        self.name = name
        self.ingredients = ingredients
        self.instructions = instructions
        self.categories = categories
    }
}
