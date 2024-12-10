//
//  AddEditRecipe.swift
//  Project 2 Recipes
//
//  Created by Brendan Vick on 12/2/24.
//

import Foundation
import SwiftUI

struct AddEditRecipe: View {
    @Environment(RecipeViewModel.self) var viewModel
    @Environment(\.presentationMode) var presentationMode
    
    let editRecipe: Recipe?

    @State private var recipe: Recipe = Recipe(
        name: "",
        summaryInfo: "",
        ingredients: "",
        instructions: "",
        categories: "",
        notes: "",
        isFavorite: false
    )
    
    init(editRecipe: Recipe?) {
        self.editRecipe = editRecipe
        
        if let recipeToEdit = editRecipe {
            recipe.name = recipeToEdit.name
            recipe.summaryInfo = recipeToEdit.summaryInfo
            recipe.ingredients = recipeToEdit.ingredients
            recipe.instructions = recipeToEdit.instructions
            recipe.categories = recipeToEdit.categories
            recipe.notes = recipeToEdit.notes
            recipe.isFavorite = recipeToEdit.isFavorite
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Recipe Name", text: $recipe.name)
                    TextField("Short Summary", text: $recipe.summaryInfo, axis: .vertical)
                }
                
                Section(header: Text("Recipe Ingredients (Entered in bullet points)")) {
                    TextEditor(text: $recipe.ingredients)
                }
                
                Section(header: Text("Recipe Instructions (Bullet points, numbered, or just plain text)")) {
                    TextEditor(text: $recipe.instructions)
                }
                
                Section(header: Text("Category")) {
                    TextField("Categories (comma separated)", text: $recipe.categories)
                }
                
                Section {
                    Button("Save") {
                        saveRecipe()
                    }
                }
            }
            .navigationTitle("Add New Recipe")
        }
    }
    
    private var isEditing: Bool {
        editRecipe != nil
    }
    
    private func saveRecipe() {
        if isEditing {
            if let recipeToEdit = editRecipe {
                recipeToEdit.name = recipe.name
                recipeToEdit.summaryInfo = recipe.summaryInfo
                recipeToEdit.ingredients = recipe.ingredients
                recipeToEdit.instructions = recipe.instructions
                recipeToEdit.categories = recipe.categories
                recipeToEdit.notes = recipe.notes
                recipeToEdit.isFavorite = recipe.isFavorite
            }
            viewModel.update(recipe)
        } else {
            viewModel.save(recipe)
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}
