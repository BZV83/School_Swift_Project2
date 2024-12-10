//
//  IndividualRecipeView.swift
//  Project 2 Recipes
//
//  Created by Brendan Vick on 12/2/24.
//

import Foundation
import SwiftUI
import MarkdownUI

public struct IndividualRecipeView: View {
    @Environment(RecipeViewModel.self) var viewModel
    @Bindable var recipe: Recipe
    
    @State private var isEditing: Bool = false
    
    public var body: some View {
        VStack {
            HStack {
                Text(recipe.name)
                    .font(.title)
                Spacer()
                Toggle("Is Favorite", isOn: $recipe.isFavorite)
            }
            Markdown(recipe.summaryInfo)
            
            Markdown(recipe.ingredients)
            Markdown(recipe.instructions)
            Spacer()
            Markdown(recipe.categories)
        }
        .onChange(of: recipe.isFavorite) { viewModel.refreshData() }
        .toolbar {
            ToolbarItem {
                Button(action: editItem) {
                    Label("Edit", systemImage: "pencil")
                }
            }
        }
        .padding()
        .sheet(isPresented: $isEditing) {
            AddEditRecipe(editRecipe: recipe)
        }
    }
    
    private func editItem() {
        isEditing.toggle()
    }
}
