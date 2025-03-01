//
//  Patty_Cake_RecipesApp.swift
//  Project 2 Recipes
//
//  Created by Brendan Vick on 11/14/24.
//

import SwiftUI
import SwiftData

@main
struct Patty_Cake_RecipesApp: App {
    let container: ModelContainer
    let viewModel: RecipeViewModel
    var body: some Scene {
        WindowGroup {
            RecipeView()
        }
        .modelContainer(container)
        .environment(viewModel)
    }
    
    init () {
        do {
            container = try ModelContainer(for: Recipe.self)
        } catch {
            fatalError("Could not initialize ModelContainer: \(error)")
        }
        
        viewModel = RecipeViewModel(container.mainContext)
    }
}
