//
//  RecipeView.swift
//  Project 2 Recipes
//
//  Created by Brendan Vick on 11/14/24.
//

import SwiftUI
import SwiftData

struct RecipeView: View {
    @Environment(RecipeViewModel.self) private var viewModel
    
    @State private var searchString: String = ""
    @State private var addEditRecipe: Bool = false
    
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink(destination: recipeListView(for: viewModel.recipes, with: "All Recipes")) {
                    Text("All Recipes")
                }
                NavigationLink(destination: recipeListView(for: viewModel.favoriteRecipes, with: "Favorites")) {
                    Text("Favorite Recipes")
                }
                ForEach(viewModel.categories, id: \.self) { category in
                    NavigationLink(destination: recipeListView(
                        for: viewModel.recipes(for: category),
                        with: "\(category) Recipes")
                    ) {
                        Text(category)
                    }
                }
            }
            .sheet(isPresented: $addEditRecipe) {
                AddEditRecipe(editRecipe: nil)
            }
        } content: {
            recipeListView(for: viewModel.recipes, with: "Your Recipes")
        } detail: {
            Text("Select a recipe")
        }
    }
    
    private func recipeListView(for recipes: [Recipe], with title: String) -> some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink(recipe.name, destination: IndividualRecipeView(recipe: recipe))
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    addEditRecipe.toggle()
                }) {
                    Label("Add Recipe", systemImage: "plus")
                }
            }
//            ToolbarItem {
//                EditButton()
//            }
        }
        .navigationTitle(title)
        .searchable(text: $searchString)
    }
}
