//
//  RecipeViewModel.swift
//  Project 2 Recipes
//
//  Created by Brendan Vick on 11/19/24.
//

import Foundation
import SwiftData

class RecipeViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    @Published var categories: [String] = []
    
    @Published var selectedCategory: String? = nil
    @Published var searchString: String = ""
    
    private var modelContext: ModelContext
    
    init(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchRecipes()
    }
    
    public func fetchRecipes() {
        try? modelContext.save()
        
        do {
            let descriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\.name)])
            
            recipes = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load recipes.")
        }
    }
    
    //fetch ability
//    private func fetchFavorites() {
//        do {
//            let descriptor = FetchDescriptor<Recipe>(
//                predicate: #Predicate { $0.isFavorite },
//                sortBy: [SortDescriptor(\.name)])
//            
//            favorites = try modelContext.fetch(descriptor)
//        } catch {
//            print("Failed to load favorites.")
//        }
//    }
}
