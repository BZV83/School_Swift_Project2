//
//  Project_2_RecipesApp.swift
//  Project 2 Recipes
//
//  Created by Brendan Vick on 11/14/24.
//

import SwiftUI
import SwiftData

@main
struct Project_2_RecipesApp: App {
    let container: ModelContainer
    let viewModel: RecipeViewModel
    var body: some Scene {
        WindowGroup {
            RecipeView()
                .environmentObject(viewModel)
        }
        .modelContainer(for: [Recipe.self])
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
