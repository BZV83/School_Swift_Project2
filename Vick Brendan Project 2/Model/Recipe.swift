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
    var summaryInfo: String
    var ingredients: String
    var instructions: String
    var categories: String
    var notes: String
    var isFavorite: Bool
    
    init(name: String, summaryInfo: String, ingredients: String, instructions: String, categories: String, notes: String, isFavorite: Bool) {
        self.name = name
        self.summaryInfo = summaryInfo
        self.ingredients = ingredients
        self.instructions = instructions
        self.categories = categories
        self.notes = notes
        self.isFavorite = isFavorite
    }
}
