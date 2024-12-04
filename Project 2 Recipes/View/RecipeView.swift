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
    @State private var isAddModalVisible: Bool = false
    
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink(destination: recipeListView(for: viewModel.recipes, with: "All Recipes")) {
                    Text("All Recipes")
                }
                NavigationLink(destination: recipeListView(for: viewModel.favoriteRecipes, with: "Favorites")) {
                    Text("Favorite Recipes")
                }
                //TODO: - Fetch tags
                // Navigation link to get all tags associated with that category.
                // similar to fetchFavorites except the predicate will just check if the string contains the tag
                ForEach(viewModel.categories, id: \.self) { category in
                    Text(category)
                }
            }
        } content: {
            recipeListView(for: viewModel.recipes, with: "Your Recipes")
        } detail: {
            Text("Select a recipe")
        }
        .sheet(isPresented: $isAddModalVisible) {
            AddRecipeView(isVisible: $isAddModalVisible)
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
                    isAddModalVisible.toggle()
                }) {
                    Label("Add Recipe", systemImage: "plus")
                }
            }
//                ToolbarItem(placement: .topBarTrailing) {
//                    EditButton()
//                }
        }
        .navigationTitle(title)
        .searchable(text: $searchString)
    }
}
