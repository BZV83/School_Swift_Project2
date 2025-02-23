//
//  RecipeViewModel.swift
//  Project 2 Recipes
//
//  Created by Brendan Vick on 11/19/24.
//

import Foundation
import SwiftData

@Observable
class RecipeViewModel: ObservableObject {
    
    //MARK: - Properties
    
    private var modelContext: ModelContext
    
    //MARK: - Model Access
    
    private(set) var recipes: [Recipe] = []
    private(set) var favoriteRecipes: [Recipe] = []
    private(set) var categories: [String] = []
    
    func recipes(for category: String) -> [Recipe] {
        return recipes.filter {
            $0.categories.lowercased().contains(category.lowercased())
        }
    }
    
    //MARK: - Init
    
    init(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchData()
    }
    
    //MARK: - User intent
    
    func refreshData() {
        fetchData()
    }
    
    func save(_ recipe: Recipe) {
        modelContext.insert(recipe)
        fetchData()
    }
    
    func update(_ recipe: Recipe) {
        saveAllChanges()
        fetchData()
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        modelContext.delete(recipe)
        fetchData()
    }
    
    func markFavorite(_ recipe: Recipe) {
        recipe.isFavorite.toggle()
        fetchData()
    }
    
    // MARK: - Private helpers
    
    private func fetchData() {
        fetchRecipes()
        fetchFavorites()
        gatherCategories()
        
        if recipes.isEmpty {
            sampleRecipes.forEach { modelContext.insert($0) }
            fetchData()
        }
    }
    
    private func fetchRecipes() {
        try? modelContext.save()
        
        do {
            let descriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\.name)])
            
            recipes = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load recipes.")
        }
    }
    
    private func fetchFavorites() {
        do {
            let descriptor = FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.isFavorite },
                sortBy: [SortDescriptor(\.name)]
            )
            
            favoriteRecipes = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load favorites.")
        }
    }
    
    private func gatherCategories() {
        var tags: Set<String> = []
        
        recipes.forEach { recipe in
            let categoryPieces = recipe.categories.split(separator: ",")
            
            categoryPieces.forEach { category in
                let canonicalCategory = category.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
                
                if !tags.contains(canonicalCategory) {
                    tags.insert(canonicalCategory)
                }
            }
        }
        
        categories = Array(tags)
    }
    
    private func saveAllChanges() {
        try? modelContext.save()
    }
}
